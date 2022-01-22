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
                                Text(baseData.game.players[index].yakushoku!.name)
                                .font(.largeTitle)
                            }
                    }.padding()
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
                            return baseData
                        }())
    }
}
