//import SwiftUI
//
//struct ActionView: View {
//    @EnvironmentObject var gameViewData:GameViewModel
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    var delegate:NextProtocol?
//    
//    var body: some View {
//        VStack(spacing:20){
//            Text(player.name)
//            Text(gameViewData.getasaOryoru() + "のアクション")
//            ForEach(0..<gameViewData.game.players.count, id: \.self); <#_#>{ index in
//                if gameViewData.game.players[index].name != player.name&&gameViewData.game.players[index].isDeath == false{
//                    HStack{
//                        Text(gameViewData.game.players[index].name)
//                        Button(action: {
//                            if gameViewData.game.asaOrYoru == GameConst.ASA{
//                                player.yakushoku.action1(name: gameViewData.game.players[index].name, delegate: viewModel)
//                            }else{
//                                player.yakushoku.action2(name: gameViewData.game.players[index].name, delegate: viewModel)
//                            }
//
//                            viewModel.log()
//                        }) {
//                            if viewModel.getasaOryoru() == GameConst.ASA{
//                                Text("疑う")
//                            }else{
//                                Text(player.yakushoku.actionText)
//                            }
//                        }
//                    }
//                }
//            }
//            if player.yakushoku.name == YakushokuConst.URANAISI && viewModel.getasaOryoru() == GameConst.YORU{
//                Text(viewModel.uranaikekka)
//            }
//            Button(action: {
//                print("contentView画面へ")
//                self.presentationMode.wrappedValue.dismiss()
//                delegate?.next()
//            }) {
//                Text("次の人へ渡してください。")
//            }
//        }.font(.system(size: 30)).onDisappear{viewModel.uranaikekka = ""}
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
////struct GameView_Previews: PreviewProvider {
////    @State static var model = Player(name: "Aさん", yakushoku: Simin())
////    static var previews: some View {
////        GameView(viewModel: ViewModel(), player: $model)
////    }
////}
