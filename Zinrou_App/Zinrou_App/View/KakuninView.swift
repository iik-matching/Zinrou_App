////
//  KakuninView.swift
////  Zinrou_App
////
////  Created by 糸島光 on 2021/11/28.
////
//
//import Foundation
//import SwiftUI
//
//struct KakuninView: View {
//    @StateObject var gameViewData = GameViewModel()
//    
//    var body: some View {
//        VStack(spacing:20){
//            Text(gameViewData.game.asaOrYoru)
//            Text("あなたは"+gameViewData.getNowName()+"ですか？")
//
//            NavigationLink(destination: ActionView(player: gameViewData.game.players[gameViewData.nowIndex],delegate:gameViewData).environmentObject(gameViewData), label: {           Text("はい。次へ").font(.largeTitle)}
//            ).frame(height: 80)
//        }.font(.system(size: 30))
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
