//import Foundation
//import SwiftUI
//
//class GameViewModel:ObservableObject,NextProtocol,SelectProtocol{
//    @Published var game = Game(players: [])
//    @Published var nowIndex = 0
//    @Published var uranaikekka = ""
//    
//    func getNowName()->String{
//        return game.players[nowIndex].name
//    }
//
//    func addPlayer(playersName: Array<String>, yakushokuArray: Array<YakushokuProtocol>){
//        let yakushokuArrayShuffled = yakushokuArray.shuffled()
//        for i in 0...playersName.count-1{
//            game.players.append(Player(name: playersName[i],yakushoku: yakushokuArrayShuffled[i]))
//        }
//    }
//
//    func next(){
//        if nowIndex < game.players.count - 1{
//            nowIndex += 1
//        }else{
//            nowIndex = 0
//            //朝のアクション後の場合
//            if game.asaOrYoru == GameConst.ASA{
//                //一番多い人をきる
//                var max = 0
//                var killname = ""
//                for player in game.players{
//                    if player.count > max{
//                        max = player.count
//                        killname = player.name
//                    }
//                }
//                for i in 0...game.players.count-1{
//                    if killname == game.players[i].name{
//                        game.players[i].isDeath = true
//                    }
//                }
//                //夜の場合
//            }else{
//                for i in 0...game.players.count-1{
//                    if game.players[i].isShuugeki == true{
//                        if game.players[i].isGuard == false{
//                            print(game.players[i].name+"が食べられました。")
//                            game.players[i].isDeath = true
//                        }else{
//                            print("騎士が守りました。")
//                        }
//                    }
//                }
//            }
//
//            //朝夜チェンジ
//            game.switchAsaYoru()
//            //カウントリセット
//            for i in 0...game.players.count-1{
//                game.players[i].count = 0
//            }
//
//            if game.endHantei(){
//                print("人狼が勝ちました")
//            }else{
//                print("まだゲームは続きます")
//            }
//
//
//            log1()
//        }
//    }
//
//    func getasaOryoru()->String{
//        return game.asaOrYoru
//    }
//
//    func select(name: String) {
//        for i in 0...game.players.count-1{
//            if game.players[i].name == name{
//                game.players[i].count += 1
//            }
//        }
//    }
//
//    func kill(name: String) {
//        for i in 0...game.players.count-1{
//            if game.players[i].name == name{
//                game.players[i].isShuugeki = true
//            }
//        }
//    }
//
//    func gurde(name: String) {
//        for i in 0...game.players.count-1{
//            if game.players[i].name == name{
//                game.players[i].isGuard = true
//            }
//        }
//    }
//
//    func uranau(name: String) {
//        for i in 0...game.players.count-1{
//            if game.players[i].name == name{
//                print(game.players[i].yakushoku.name)
//                uranaikekka = game.players[i].name+"は"+game.players[i].yakushoku.zinnei
//            }
//        }
//    }
//
//    func log(){
//        for player in game.players{
//            print(player.count)
//        }
//    }
//    func log1(){
//        for player in game.players{
//            print(player.name+" \(player.isDeath)")
//        }
//    }
//}
//
//protocol NextProtocol{
//    func next()
//}
//
//protocol SelectProtocol{
//    func select(name:String)
//    func kill(name:String)
//    func gurde(name:String)
//    func uranau(name:String)
//}
