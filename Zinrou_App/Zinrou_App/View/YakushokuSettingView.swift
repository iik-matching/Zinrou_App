import Foundation
import SwiftUI

struct YakushokuSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isShowYakushokuView {
            ZStack{
               Image(decorative:"人狼背景画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                
                VStack(){
                    Text("【 役職公開画面 】")
                        .font(.largeTitle)
                        .frame(width: 400)
                        .foregroundColor(Color(.white))
                        .background(
                            // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                        ).padding(.top, 20)
                  
                VStack{
                    Text(baseData.resultMessage)
                    ForEach(0..<baseData.game.players.count, id: \.self) { index in
                        HStack{
                            Text(baseData.game.players[index].name)
                                .font(.largeTitle)
                            //人狼を赤くする
                            if(baseData.game.players[index].yakushoku!.name == YakushokuConst.ZINROU){
                                Text(baseData.game.players[index].yakushoku!.name)
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }else{
                                Text(baseData.game.players[index].yakushoku!.name)
                                    .font(.largeTitle)
                            }
                            
                        }
                    }.padding()
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
                                            Text("(" +
                                                baseData.game.players[index].yakushoku!.name + ")")
                                                .font(.largeTitle)
                                                .foregroundColor(.red)
                                        }else{
                                            Text("(" + baseData.game.players[index].yakushoku!.name + ")")
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
                        withAnimation{
                            baseData.isShowYakushokuView.toggle()
                        }
                    }){
                        Text("ホーム画面へ")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color(.white))
                            .background(Color(.purple))
                            .cornerRadius(20)
                    }.padding(.vertical,15)
            }
        }
      }
    }
}

struct YakushokuSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            YakushokuSettingView()
                .environmentObject({ () -> BaseViewModel in
                    let baseData = BaseViewModel()
                    baseData.isShowYakushokuView = true
                    
                    //４人の場合のデータを設定
                    var yakushoku_array : [String] = [YakushokuConst.SIMIN,
                                                      YakushokuConst.ZINROU,
                                                      YakushokuConst.URANAISI,
                                                      YakushokuConst.KISHI]
                    yakushoku_array = yakushoku_array.shuffled()
                    for i in 0...baseData.game.players.count - 1 {
                        baseData.game.players[i].yakushoku = baseData.getYakushoku(yakushokuName: yakushoku_array[i])
                    }
                    
                    return baseData
                }())
            .previewInterfaceOrientation(.portraitUpsideDown)
            YakushokuSettingView()
                .environmentObject({ () -> BaseViewModel in
                    let baseData = BaseViewModel()
                    baseData.isShowYakushokuView = true
                    
                    //４人の場合のデータを設定
                    var yakushoku_array : [String] = [YakushokuConst.SIMIN,
                                                      YakushokuConst.ZINROU,
                                                      YakushokuConst.URANAISI,
                                                      YakushokuConst.KISHI]
                    yakushoku_array = yakushoku_array.shuffled()
                    for i in 0...baseData.game.players.count - 1 {
                        baseData.game.players[i].yakushoku = baseData.getYakushoku(yakushokuName: yakushoku_array[i])
                    }
                    
                    return baseData
                }())
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
