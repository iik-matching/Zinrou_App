//
//  ResultView.swift.swift
//  Zinrou_App
//
//  Created by 入江健太 on 2022/03/12.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isShowResultView{
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack(spacing:15){
                    VStack{
                        Image(decorative:"\(baseData.resultYakusyoku)画像")     // 画像指定
                                .resizable()
                                .frame(width: 300.0, height: 300.0)
                    }
                    
                    
                    VStack(spacing:15){
                        Text(baseData.resultMessage)
                            .font(.system(size: 28, design: .serif))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.white))
                        
                        Button(action: {
                            baseData.isShowResultView.toggle()
                        }){
                            Text("閉じる")
                                .font(.system(size: 22, design: .serif))
                                .fontWeight(.semibold)
                                .frame(width: 120, height: 32)
                                .foregroundColor(Color(.white))
                                .background(
                                    // 線形グラデーション（青→黒）を生成
                                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                                )
                                .cornerRadius(18)
                        }
                    }
                }
            }
        }
    }
}

struct ResultView_swift_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                baseData.isShowResultView = true
                return baseData
            }())
    }
}
