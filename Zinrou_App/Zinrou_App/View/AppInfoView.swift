//
//  AppInfoView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/02.
//

import SwiftUI
import AVFoundation

struct AppInfoView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isAppInfoView {
            ZStack {
                Image(decorative:"開発者画面画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    VStack(){
                       Text("アプリ概要")
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
                                    Text("【アプリ情報】")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.white))
                                        .padding(3)
                                        .font(.largeTitle)
                                        
                      
                                    Text("2022/5/2 Version: 1.1.1")
                                        .foregroundColor(Color(.white))
                                        .padding(3)
                                    
                                    
                                }.padding()
                                .frame(width: 350.0)
                        }
                        
                        Button(action: {
                            withAnimation{
                                baseData.initializeGame()
                            }
                            if let soundURL = Bundle.main.url(forResource: "シーン切り替え", withExtension: "mp3") {
                                do {
                                    player = try AVAudioPlayer(contentsOf: soundURL)
                                    player?.play()
                                } catch {
                                    print("error")
                                }
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

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
              baseData.isAppInfoView = true
            return baseData
        }())
    }
}
