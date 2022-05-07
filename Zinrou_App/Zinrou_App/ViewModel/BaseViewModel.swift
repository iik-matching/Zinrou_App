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
    @Published var resultYakusyoku = ""
    @Published var timeCount = 0
    @Published var selectindex:Int? = nil
    
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
            nowIndex = 0
            //朝のアクション後の場合
            if game.asaOrYoru == GameConst.ASA{
                //一番多い人をきる
                var max = 0
                var killname = ""
                for player in game.players{
                    if player.count > max{
                        max = player.count
                        killname = player.name
                    }
                }
                for i in 0...game.players.count-1{
                    if killname == game.players[i].name{
                        game.players[i].isDeath = true
                        print("\(game.players[i].name)が投票により死亡しました。")
                    }
                }
                //夜の場合
            }else{
                for i in 0...game.players.count-1{
                    if game.players[i].isShuugeki == true{
                        if game.players[i].isGuard == false{
                            print(game.players[i].name+"が食べられました。")
                            game.players[i].isDeath = true
                        }else{
                            print("騎士が守りました。")
                        }
                    }
                }
                timeCount = 100
                meetingAlert.toggle()
            }
            
            //朝夜チェンジ
            game.switchAsaYoru()
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
        if(game.players[nowIndex].isDeath == true){
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
            resultMessage = "  [占い結果]\n"
            isShowResultView.toggle()
            
            for i in 0...game.players.count-1{
                if game.players[i].name == name{
                    print(game.players[i].yakushoku!.name)
                    //占った結果で役職が人狼だったら人狼、人狼以外は全部市民にする
                    if (game.players[i].yakushoku!.name == YakushokuConst.ZINROU){
                        resultYakusyoku = "人狼"
                    }else {
                        resultYakusyoku = "村人"
                    }
                    resultMessage += game.players[i].name+"は"+resultYakusyoku
                }
            }
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
