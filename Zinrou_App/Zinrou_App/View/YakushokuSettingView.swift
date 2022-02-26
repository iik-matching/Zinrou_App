import Foundation
import SwiftUI

struct YakushokuSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isShowYakushokuView {
            ZStack{
                Color.brown.ignoresSafeArea()
                VStack{
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
                    
                    Button(action: {
                        withAnimation{
                            baseData.isShowYakushokuView.toggle()
                        }
                    }){
                        Text("前の画面へ").font(.largeTitle)
                    }
                }
            }
        }
        
    }
}

struct YakushokuSettingView_Previews: PreviewProvider {
    static var previews: some View {
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
    }
}
