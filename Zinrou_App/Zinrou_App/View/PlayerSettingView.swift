import SwiftUI

struct PlayerSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                VStack(spacing:15){
                    ForEach(0..<baseData.game.players.count, id: \.self) { index in
                        VStack{
                            Text(baseData.game.players[index].name)
                                .font(.largeTitle)
                            HStack{
                                Button(action: {
                                    print("編集")
                                }){
                                    Text("編集").font(.largeTitle)
                                }
                                Button(action: {
                                    print("削除")
                                }){
                                    Text("削除").font(.largeTitle)
                                }
                            }
                        }.padding()
                    }
                }
            }.padding(.horizontal,50).border(Color.black, width: 3)
            
            VStack(spacing:10){
                Button(action: {
                    print("プレイヤー追加")
                    withAnimation{
                        baseData.customAlert.toggle()
                    }
                }){
                    Text("プレイヤー追加").font(.largeTitle)
                }
                Button(action: {
                    baseData.allocateJobTitle()
                    withAnimation{
                        baseData.isShowYakushokuView.toggle()
                    }
                }){
                    Text("役職設定画面へ").font(.largeTitle)
                }
            }
          
        }
    }
}

struct PlayerSettingView_Previews: PreviewProvider {
    @State static var base = BaseViewModel()
    static var previews: some View {
        PlayerSettingView()
            .environmentObject(base)
    }
}
