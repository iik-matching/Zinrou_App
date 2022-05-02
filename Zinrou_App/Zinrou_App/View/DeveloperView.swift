//
//  DeveloperView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/02.
//

import SwiftUI

struct DeveloperView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View {
        if baseData.isDeveloperView {
            ZStack {
                Image(decorative:"開発者画面画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    VStack(){
                       Text("開発者")
                            .fontWeight(.semibold)
                            .font(.largeTitle)
                            .frame(width: 400)
                            .foregroundColor(Color(.white))
                            .background(
                                // 線形グラデーション（青→黒）を生成
                                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                            ).padding(.top, 20)
                        
                        
                        
                        ScrollView {
                                VStack(spacing:8){
                                    Text("IRIE").foregroundColor(Color(.white)).padding(3).font(.largeTitle)
                                    Text("ITOSHIMA").foregroundColor(Color(.white)).padding(3).font(.largeTitle)
                                    Text("KITAZATO").foregroundColor(Color(.white)).padding(3).font(.largeTitle)
                                }.padding()
                                .frame(width: 350.0)
                        }
                        
                        Button(action: {
                            withAnimation{
                                baseData.initializeGame()
                            }
                        }){
                            Text("ホーム画面へ")
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
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
              baseData.isDeveloperView = true
            return baseData
        }())
    }
}