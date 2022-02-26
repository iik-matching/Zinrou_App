import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var game = Game(players: [])
    @Published var nowIndex = 0
    @Published var deletePlayerIndex:Int? = nil
    @Published var uranaikekka = ""
    @Published var addPlayerAlert = false
    @Published var playersCount = 0
    @Published var playersName: [String] = []
    @Published var yakushokuArray: [YakushokuProtocol] = []
    //アラート１
    @Published var playerAddAlert = false
    @Published var playerDeleteAlert = false
    @Published var isShowYakushokuView = false
    
    
    
    init(){
        //初期４人をセット
        game.players.append(Player(name: "Aさん", yakushoku: nil))
        game.players.append(Player(name: "Bさん", yakushoku: nil))
        game.players.append(Player(name: "Cさん", yakushoku: nil))
        game.players.append(Player(name: "Dさん", yakushoku: nil))
        
    }
    
    //プレイヤー追加
    func addPlayer(playersName: String){
        game.players.append(Player(name: playersName, yakushoku: nil))
    }
    
    func deletePlayer(){
        game.players.remove(at: deletePlayerIndex!)
        deletePlayerIndex = nil
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
            for _ in 0...AddCount - 1  {
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
            }

            //朝夜チェンジ
            game.switchAsaYoru()
            //カウントリセット
            for i in 0...game.players.count-1{
                game.players[i].count = 0
            }
            
            if game.endHantei(){
                print("人狼が勝ちました")
            }else{
                print("まだゲームは続きます")
            }
            
            
            log1()
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
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].count += 1
            }
        }
    }
    
    func kill(name: String) {
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].isShuugeki = true
            }
        }
    }
    
    func gurde(name: String) {
        for i in 0...game.players.count-1{
            if game.players[i].name == name{
                game.players[i].isGuard = true
            }
        }
    }
    
//    func uranau(name: String) {
//        for i in 0...game.players.count-1{
//            if game.players[i].name == name{
//                print(game.players[i].yakushoku.name)
//                uranaikekka = game.players[i].name+"は"+game.players[i].yakushoku.zinnei
//            }
//        }
//    }
    
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
