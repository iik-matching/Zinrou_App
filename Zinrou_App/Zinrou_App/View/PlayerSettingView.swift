import SwiftUI

struct PlayerSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View {
        // Created by 北里優宜    2022/2/26
        ZStack {
            Image(decorative:"人狼背景画像")     // 画像指定
                .resizable()    // 画像サイズをフレームサイズに合わせる
            VStack{
                    Text("【 プレイヤー追加画面 】")
                        .font(.largeTitle)
                        .frame(width: 400)
                        .foregroundColor(Color(.white))
                        .background(
                            // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                         ).padding(.top, 20)
                
                ScrollView {
                    ZStack {
                        // 放射状グラデーション（赤→黒）を生成
                            RadialGradient(gradient: Gradient(colors: [.red, .black]), center: .center, startRadius: 1, endRadius: 300)
                                  .ignoresSafeArea()      // フレームサイズをセーフエリア外まで広げる
                          
                    
                        VStack(spacing:15){
                            ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                VStack{
                                    Text(baseData.game.players[index].name)
                                        .font(.system(size: 34, design: .serif))
                                        .foregroundColor(Color(.white))
                                    HStack{
                                        Button(action: {
                                            print("編集")
                                        }){
                                            Text("編集")
                                                .font(.system(size: 22, design: .serif))
                                                .fontWeight(.semibold)
                                                .frame(width: 80, height: 32)
                                                .foregroundColor(Color(.white))
                                                .background(Color(.black))
                                                .cornerRadius(18)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(Color(.green), lineWidth: 2.0)
                                                )
                                        }
                                        Button(action: {
                                            withAnimation {
                                                baseData.playerDeleteAlert.toggle()
                                            }
                                            print("削除")
                                            baseData.deletePlayerIndex = index
                                        }){
                                            Text("削除")
                                                .font(.system(size: 22, design: .serif))
                                                .fontWeight(.semibold)
                                                .frame(width: 80, height: 32)
                                                .foregroundColor(Color(.black))
                                                .background(Color(.white))
                                                .cornerRadius(18)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(Color(.orange), lineWidth: 2.0)
                                                )

                                        }
                                    }
                                }.padding()
                            }
                        }
                        .frame(width: 350.0)
                    }.padding(.horizontal,44.0).border(Color.black, width: 3)
                }
            
                VStack(spacing:10){
                    Button(action: {
                        withAnimation{
                            baseData.addPlayerAlert.toggle()
                        }
                    }){
                        Text("プレイヤー追加")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(width: 320, height: 48)
                            .foregroundColor(Color(.white))
                            .background(Color(.blue))
                            .cornerRadius(24)
                        
                    }
                    Button(action: {
                        baseData.allocateJobTitle()
                        withAnimation{
                            baseData.isShowYakushokuView.toggle()
                        }
                    }){
                        Text("役職設定画面へ")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(width: 320, height: 48)
                            .foregroundColor(Color(.white))
                            .background(Color(.purple))
                            .cornerRadius(24)
                    }
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
