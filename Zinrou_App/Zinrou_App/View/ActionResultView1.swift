//
//  ActionReslutView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/07.
//

import SwiftUI

struct ActionResultView1: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isActionResultView1{
            Image(decorative:"ゲーム説明画面")     // 画像指定
                .resizable()    // 画像サイズをフレームサイズに合わせる
                .ignoresSafeArea()
          
            VStack{
                VStack(){
                       Text("The 1ST Morning")
                            .font(.largeTitle)
                            .frame(width: 400)
                            .foregroundColor(Color(.white))
                            .background(
                                // 線形グラデーション（青→黒）を生成
                                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                            ).padding(.top, 20)
                }
                
                ScrollView {
                        VStack(spacing:8){
                            Text("Game Masterからの報告").foregroundColor(Color(.black)).padding(3).font(.title2)
                            Text("夜のアクションを完了しました。ゲームマスターに端末を渡してください。").foregroundColor(Color(.black)).padding(8)
                            
                        }.padding()
                        .frame(width: 350.0)
                }
                
                Button(action: {
                    withAnimation{
                        baseData.isActionResultView2.toggle()
                    }
                }){
                    Text("OK")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(width: 320, height: 48)
                        .foregroundColor(Color(.white))
                        .background(Color(.black))
                        .cornerRadius(24)
                }
            }
        }
    }
}

struct ActionResultView1_Previews: PreviewProvider {
    static var previews: some View {
        ActionResultView1().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
            baseData.isActionResultView1 = true
            return baseData
        }())
    }
}
