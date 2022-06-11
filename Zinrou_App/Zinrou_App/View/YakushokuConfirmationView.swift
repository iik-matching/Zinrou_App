import Foundation
import SwiftUI
import AVFoundation

struct YakushokuConfirmationView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isShowYakushokuView {
            ZStack{
                Image(decorative:"人狼背景画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack(){
                    Text("【 役職公開画面 】")
                        .font(.largeTitle)
                        .frame(width: 400)
                        .foregroundColor(Color(.white))
                        .background(
                            // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                        ).padding(.top, 20)
                    
                    
                        Text(baseData.resultMessage)
                        .foregroundColor(Color(.white))
                        .font(.largeTitle)
                        .frame(width: 200)
                        .background(
                        // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .bottom, endPoint: .top)
                    ).padding(.top, 20)
    
                    
                        ScrollView {
                            VStack{
                                ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                    HStack{
                                        Text(baseData.game.players[index].name)
                                            .font(.system(size: 38, design: .serif))
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.white)
                                        //人狼を赤くする
                                        if(baseData.game.players[index].yakushoku!.name == YakushokuConst.ZINROU){
                                            Text("(\(baseData.game.players[index].yakushoku!.name))")
                                                .font(.largeTitle)
                                                .foregroundColor(.red)
                                        }else{
                                            Text("(\(baseData.game.players[index].yakushoku!.name))")
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                        }
                                        
                                    }
                                }.padding()
                                
                            }.frame(width: 350.0).background(
                                // 放射状グラデーション（赤→黒）を生成
                                RadialGradient(gradient: Gradient(colors: [.red, .black]), center: .center, startRadius: 1, endRadius: 180)
                                    .ignoresSafeArea()       //フレームサイズをセーフエリア外まで広げる
                            )
                        }
                        .frame(width: nil)
                        Button(action: {
                            baseData.initializeGame()
                        }){
                            Text("ホーム画面へ")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(width: 240, height: 50)
                                .foregroundColor(Color(.white))
                                .background(Color(.purple))
                                .cornerRadius(20)
                        }.padding(.vertical,15)
                }
            }
        }
    }
}

struct YakushokuConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        YakushokuConfirmationView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                baseData.isShowYakushokuView = true
                
                baseData.allocateJobTitle()
                baseData.resultMessage = "市民勝利"
                return baseData
            }())
    }
}

