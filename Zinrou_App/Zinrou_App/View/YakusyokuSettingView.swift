//
//  YakusyokuSettingView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/04.
//

import SwiftUI

struct YakusyokuSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    @State var shiminNum:Int = 0
    @State var uranaishiNum:Int = 0
    @State var kishiNum:Int = 0
    @State var zinrouNum:Int = 0
    
    var body: some View {
        if baseData.isShowYakusyokuSettingView {
            ZStack {
                Image(decorative:"役職説明画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    VStack(){
                       Text("役職設定")
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
                                    Text("村人陣営")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.red))
                                        .padding(3)
                                        .font(.system(size: 26, design: .serif))
                                      
                                    
                                    HStack{
                                        VStack{
                                             Text("【市民】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                             Stepper(value: $shiminNum, in: 0...9) { //Stepper1
                                             Text("\(self.shiminNum) 人")
                                                     .background(Color(.white))
                                                     .font(.system(size: 26, design: .serif))
                                                     
                                                }
                                             .frame(width:150)
                                          }
                                         Image(decorative:"市民画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                                                        
                                    HStack{
                                        VStack{
                                         Text("【占い師】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Stepper(value: $uranaishiNum, in: 0...9) { //Stepper1
                                         Text("\(self.uranaishiNum) 人")
                                                 .background(Color(.white))
                                                 .font(.system(size: 26, design: .serif))
                                            }
                                         .frame(width:150)
                                        }
                                        
                                         Image(decorative:"占い師画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                  
                                    HStack{
                                        VStack{
                                             Text("【騎士】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                             Stepper(value: $kishiNum, in: 0...9) { //Stepper1
                                             Text("\(self.kishiNum) 人")
                                                     .background(Color(.white))
                                                     .font(.system(size: 26, design: .serif))
                                                }
                                             .frame(width:150)
                                        }
                                         Image(decorative:"騎士画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                   
                                    Spacer()
                                    Text("人狼陣営")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.red))
                                        .padding(3)
                                        .font(.system(size: 26, design: .serif))
                                      
                                    HStack{
                                        VStack{
                                             Text("【人狼】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                             Stepper(value: $zinrouNum, in: 0...9) { //Stepper1
                                             Text("\(self.zinrouNum) 人")
                                                     .background(Color(.white))
                                                     .font(.system(size: 26, design: .serif))
                                                }
                                             .frame(width:150)
                                        }
                                         Image(decorative:"人狼画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                }.padding()
                                .frame(width: 350.0)
                        }
                        
                        Button(action: {
                            withAnimation{
                                baseData.isShowYakusyokuSettingView.toggle()
                            }
                        }){
                            Text("プレイヤー設定画面へ")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 48)
                                .foregroundColor(Color(.white))
                                .background(Color(.black))
                                .cornerRadius(24)
                        }
                        Button(action: {
                                baseData.allocateJobTitle()
                          withAnimation{
                              //ゲーム画面へ
                                baseData.isShowGameView.toggle()
                          }
                        }){
                            Text("GAME START")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 48)
                                .foregroundColor(Color(.white))
                                .background(Color(.red))
                                .cornerRadius(24)
                        }
                        
                    }
                }
            }
        }
    }
}

struct YakusyokuSettingView_Previews: PreviewProvider {
    static var previews: some View {
        YakusyokuSettingView().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
            baseData.isShowYakusyokuSettingView = true
            baseData.allocateJobTitle()
            return baseData
        }())
    }
}
