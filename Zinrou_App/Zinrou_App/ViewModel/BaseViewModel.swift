import SwiftUI

class BaseViewModel: ObservableObject ,SelectProtocol{
    
    @Published var game = Game(players: [])
    @Published var nowIndex = 0
    @Published var deletePlayerIndex:Int? = nil
    @Published var editPlayerIndex:Int = 0
    @Published var uranaikekka = ""
    @Published var addPlayerAlert = false
    @Published var playersCount = 0
    @Published var playersName: [String] = []
    @Published var yakushokuArray: [YakushokuProtocol] = []
    @Published var didAction = false
    @Published var resultMessage = ""
    @Published var attackDeathMessage = ""
    @Published var boteDeathMessage = ""
    @Published var resultZinnei = ""
    @Published var timeCount = 0
    @Published var uranattaPlayer:Player? = nil
    @Published var suspectNameList: [String] = []
    @Published var finalVoteFlg = false
    @Published var finalVoteCount = 0
    @Published var currentMaxCount = 0

    
    //アラート１
    @Published var playerAddAlert = false
    @Published var playerDeleteAlert = false
    @Published var playerEditAlert = false
    @Published var meetingAlert = false
    @Published var isShowYakushokuView = false
    @Published var isShowGameView = false
    @Published var isShowResultView = false
    @Published var isMyAlertView = false
    @Published var isPlayerSettingView = false
    @Published var isGameExplanationView = false
    @Published var isPositionExplanationView = false
    @Published var isDeveloperView = false
    @Published var isAppInfoView = false
    @Published var isShowYakusyokuSettingView = false
    @Published var isActionResultView1 = false
    @Published var isActionResultView2 = false
    @Published var isFinalVoteResultView = false

    
    @Published var KakuninViewMessage = "" //自作アラートのメッセージ
    
    @Published var MyAlertMessage = "" //自作アラートのメッセージ
    
    @Published var isKakuninFrag = false //確認を終えたかのフラグ
    
    init(){
        if game.players.count < 4 {
            //初期４人をセット
            game.players.append(Player(name: "Aさん", yakushoku: nil))
            game.players.append(Player(name: "Bさん", yakushoku: nil))
            game.players.append(Player(name: "Cさん", yakushoku: nil))
            game.players.append(Player(name: "Dさん", yakushoku: nil))
        }
    }
    
    //プレイヤー追加
    func addPlayer(playersName: String){
        if (playersName != ""){
            game.players.append(Player(name: playersName, yakushoku: nil))
        }else{
            //名前が未記入だった場合追加されない
            MyAlertMessage = "名前を入力してください"
            isMyAlertView.toggle()
        }
    }
    
    func deletePlayer(){
        game.players.remove(at: deletePlayerIndex!)
        deletePlayerIndex = nil
    }
    
    //    func getPlayerName(index: Int) -> String{
    //        return game.players[index].name
    //    }
    
    func setEditPlayerIndex(index: Int){
        editPlayerIndex = index
    }
    
    func getEditPlayerIndex() -> Int{
        return editPlayerIndex
    }
    
    //役職を割り振る
    func allocateJobTitle(){
        
        //４人で決め打ちしているのが問題
        var yakushoku_array : [String] = [YakushokuConst.SIMIN,
                                          YakushokuConst.ZINROU,
                                          YakushokuConst.URANAISI,
                                          YakushokuConst.KISHI]
        //市民を追加するしように変更　いずれ人狼の数、占い師の数、騎士の数、設定画面が必要
        //５人以上の場合は、追加人数分市民を追加。
        if(game.players.count >= 5){
            let AddCount = game.players.count - 4;
            for _ in 0...AddCount - 1 {
                yakushoku_array.append(YakushokuConst.SIMIN)
            }
        }
        
        yakushoku_array = yakushoku_array.shuffled()
        for i in 0...game.players.count - 1 {
            game.players[i].yakushoku = getYakushoku(yakushokuName: yakushoku_array[i])
        }
    }
    
    func getNowName()->String{
        return game.players[nowIndex].name
    }
    
    
    
    func next(){
        didAction = false
        if nowIndex < game.players.count - 1{
            nowIndex += 1
        }else{
            suspectNameList = []
            nowIndex = 0

            //朝のアクション後の場合
            if game.asaOrYoru == GameConst.ASA{
                boteDeathMessage = ""
                suspectNameList = getSuspectName(max: getMaxCount())
                let killname:[String]  = suspectNameList
                currentMaxCount = getMaxCount()
                
                if (currentMaxCount != 1 || finalVoteFlg ) { //プレイヤー全員の投票数が同じ出ない場合
                    if killname.count < 2 { //通常投票の場合
                        for i in 0...killname.count-1{
                            for j in 0...game.players.count-1{
                                print("killname[i]",killname[i])
                                print("game.players[i].name",game.players[j].name)
                                if killname[i] == game.players[j].name{
                                    game.players[j].isDeath = true
                                    boteDeathMessage += "\(game.players[j].name)さんです。\n"
                                    print("\(game.players[j].name)が投票により処刑されました。")
                                }
                            }
                        }
                    }else{ //決選投票の場合
                        finalVoteFlg = true
                        finalVoteCount += 1
                        print("決戦投票killname.count1",killname.count)
                        print("決戦投票finalVoteCount1",finalVoteCount)
                        if finalVoteCount == 2 && killname.count >= 2{ //2回目の決選投票の場合
                            print("決戦投票finalVoteCount2",finalVoteCount)
                            let randomInt = Int.random(in: 0..<killname.count)   // 0からkillname.count分だけの範囲で整数（Int型）乱数を生成
                            let deathPlayer:String = changePlayerIsDeath(index:randomInt)
                            boteDeathMessage += "\(deathPlayer)さんです。\n"
                            print("\(deathPlayer)が投票により処刑されました。")
                            currentMaxCount = 0
                            isActionResultView2.toggle()
                        }
                        isActionResultView2.toggle()
                        print("決戦投票")
                    }
                }
        
                if game.endHantei() == GameConst.KEIZOKU {
                    isActionResultView2.toggle()
                }
                
            //夜の場合
            }else{
                currentMaxCount = 0
                finalVoteCount = 0
                finalVoteFlg = false
                suspectNameList = getSuspectName(max: getMaxCount())
                print("suspectNameList 夜の場合",suspectNameList)
                
                //初夜の場合
                if(CheckShoya()){
                    attackDeathMessage = "いませんでした。\n(第１夜は襲撃されません)"
                }else{
                    for i in 0...game.players.count-1{
                        if(game.players[i].isShuugeki == true){
                            if game.players[i].isGuard == false{
                                attackDeathMessage = game.players[i].name+"さんです。"
                                print(game.players[i].name+"が食べられました。")
                                game.players[i].isDeath = true
                            }else{
                                attackDeathMessage = "いませんでした。"
                                print("騎士が守りました。")
                            }
                        }
                }
            }
            
                if game.endHantei() == GameConst.KEIZOKU {
                    timeCount = 100
                    isActionResultView1.toggle()
                    //meetingAlert.toggle()
                }
            }
        
            //カウントリセット
            for i in 0...game.players.count-1{
                game.players[i].count = 0
                game.players[i].isGuard = false
                game.players[i].isShuugeki = false
            }
            
            //継続判定
            let HANTEI = game.endHantei()
            if HANTEI == GameConst.ZINROUSHOURI {
                print(GameConst.ZINROUSHOURI)
                //isShowResultView.toggle()
                resultMessage = GameConst.ZINROUSHOURI
                isShowYakushokuView.toggle()
            }else if(HANTEI == GameConst.SIMINSHOURI){
                //print(GameConst.SIMINSHOURI)
                //isShowResultView.toggle()
                resultMessage = GameConst.SIMINSHOURI
                isShowYakushokuView.toggle()
            }else if HANTEI == GameConst.KEIZOKU {
                print(GameConst.KEIZOKU)
                var count = 0;
                for i in 0...game.players.count-1{
                    if(game.players[i].isDeath == false){
                        count += 1;
                    }
                }
                print("残り\(count)人")
            }
            
            log1()
        }
        
        //もし次に人が死んでいたらさらに次に行く
        if(game.players[nowIndex].isDeath == true || (finalVoteFlg == true && suspectNameList.contains(game.players[nowIndex].name))){
            next()
        }
    }
    
    func getYakushoku(yakushokuName:String)->YakushokuProtocol{
        switch yakushokuName {
        case YakushokuConst.SIMIN:
            return Simin()
        case YakushokuConst.ZINROU:
            return Zinrou()
        case YakushokuConst.URANAISI:
            return Uranaishi()
        case YakushokuConst.KISHI:
            return Kishi()
        default:
            return Simin()
        }
    }
    
    func getasaOryoru()->String{
        return game.asaOrYoru
    }
    
    func select(name: String) {
        print(name+"を怪しむ")
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].count += 1
            }
        }
    }
    
    func kill(name: String) {
        print(name+"を食ベる")
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].isShuugeki = true
            }
        }
    }
    
    func gurde(name: String) {
        print(name+"を守る")
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].isGuard = true
            }
        }
    }
    
    func uranau(name: String) {
        print(name+"を占う")
        
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                
                uranattaPlayer = game.players[i]
                
                print(game.players[i].yakushoku!.name)
            }
        }
        
        isShowResultView.toggle()
    }
    
    //同じ名前チェック
    func PlayerNameCheak(name: String) -> Bool{
        
        for i in 0...game.players.count-1{
            //同じ名前が存在する場合
            if game.players[i].name == name{
                return false
            }
        }
        
        return true
    }
    
    
    func log(){
        for player in game.players{
            print(player.count)
        }
    }
    
    func log1(){
        for player in game.players{
            print(player.name+" \(player.isDeath)")
        }
    }
    
    func initializePlayer()->[Player]{
        var nextPlayers:[Player] = []
        for i in 0...game.players.count-1{
            nextPlayers.append(Player(name: game.players[i].name, yakushoku: nil))
        }
        game.players = nextPlayers
        return game.players
    }
    
    func CheckShoya()->Bool{
        if (game.turnCount == 1 && getasaOryoru() == GameConst.YORU){
            return true
        }else{
            return false
        }
    }
    
    func changePlayerIsDeath(index:Int)->String{
        for i in 0...game.players.count-1{
            if suspectNameList[index] == game.players[i].name{
                game.players[i].isDeath = true
                return game.players[i].name
            }
        }
        return ""
    }
    
    func getMaxCount()->Int {
        //一番多い人をきる
        var max = 0
        for player in game.players{
            if player.count > max && player.isShuugeki != true{
                max = player.count
            }
            print("\(player.name)の投票数：\(player.count)")
        }
        print("MAX前",max)
        return max
    }
    
    func getSuspectName(max:Int)->[String]{
        var NameList:[String] = []
        //一番多い人をきる
        for player in game.players{
            if player.count == max && player.isShuugeki != true{
                    NameList.append(player.name)
            }
        }

        return NameList
    }
    
    func initializeGame(){
        game = Game(players:initializePlayer())
        nowIndex = 0
        deletePlayerIndex = nil
        editPlayerIndex = 0
        uranaikekka = ""
        addPlayerAlert = false
        playersCount = 0
        playersName = []
        yakushokuArray = []
        didAction = false
        resultMessage = ""
        //アラート１
        playerAddAlert = false
        playerDeleteAlert = false
        playerEditAlert = false
        isShowYakushokuView = false
        isShowGameView = false
        isShowResultView = false
        isPlayerSettingView = false
        isGameExplanationView = false
        isPositionExplanationView = false
        isDeveloperView = false
        isAppInfoView = false
        isShowYakusyokuSettingView = false
        isFinalVoteResultView = false
    }
}

protocol NextProtocol{
    func next()
}

protocol SelectProtocol{
    func select(name:String)
    func kill(name:String)
    func gurde(name:String)
    func uranau(name:String)
}

protocol NextPageProtocol{
    func nextPage()
}
