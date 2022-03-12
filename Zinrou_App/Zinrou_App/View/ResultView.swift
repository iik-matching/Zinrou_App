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
                Color.white.ignoresSafeArea()
                VStack(spacing:15){
                    
                    Text(baseData.resultMessage)
                    
                    Button(action: {
                        baseData.isShowResultView.toggle()
                    }){
                        Text("閉じる")
                            .font(.system(size: 22, design: .serif))
                            .fontWeight(.semibold)
                            .frame(width: 120, height: 32)
                            .foregroundColor(Color(.black))
                            .background(Color(.white))
                            .cornerRadius(18)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color(.orange), lineWidth: 2.0)
                            )
                        
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
