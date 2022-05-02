//
//  MeetingView.swift
//  Zinrou_App
//
//  Created by 糸島光 on 2022/04/09.
//

import SwiftUI

struct MeetingAlertView: View {
    @EnvironmentObject var baseData: BaseViewModel
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isAnimating = false
    
    // グラデーションの定義
       let gradient = LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        if baseData.meetingAlert{
            if baseData.timeCount > 0{
                ZStack{
                    Image(decorative:"会議時間画面")     // 画像指定
                        .resizable()    // 画像サイズをフレームサイズに合わせる
                        .ignoresSafeArea()
                    
                    VStack{
                        Text("会議時間").font(.largeTitle)
                            .frame(width: 350)
                            .foregroundColor(Color(.white))
                            .background(
                                // 線形グラデーション（青→黒）を生成
                                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                             )
                        Spacer().frame(height: 100)
                        
                        HStack{
                          Rectangle()
                                        .fill(gradient)
                                        .frame(width: 30, height: 30)
                                        .rotationEffect(isAnimating ? .degrees(150) : .zero)
                                        .animation(
                                            .spring(
                                            response: 2.0, //ばねの剛性
                                            dampingFraction: 0.9, //抗力の量
                                            blendDuration: 0.5 //補間する時間
                                          ))
                                        .onAppear {
                                            isAnimating = true
                                        }
                            
                            Text("\(baseData.timeCount)")
                                .font(.system(size: 50, design: .serif))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(.white))
                                .onReceive(timer) { input in
                                    baseData.timeCount -= 1
                                        print(baseData.timeCount)
                                }
                        }
                        
                        Button(action: {
                            baseData.timeCount = 0
                        }){
                            Text("会議を中止")
                                .font(.system(size: 36, design: .serif))
                                .fontWeight(.semibold)
                                .frame(width: 300, height: 50)
                                .foregroundColor(Color(.white))
                                .background(Color(.black))
                                .cornerRadius(36)
                                .transition(.move(edge: .leading))
                                .background(
                                    // 線形グラデーション（青→黒）を生成
                                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                                )
                                .cornerRadius(18)
                        }
                    }
                }
            }else{
                KakuninView(inputText: "追放会議を終了します",delegate: test(d: baseData))
            }
        }
        
    }
}

class test:NextPageProtocol{
    var baseData: BaseViewModel
    func nextPage() {
        baseData.meetingAlert.toggle()
    }
    
    init(d:BaseViewModel){
        baseData = d
    }
}

struct MeetingAlertView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingAlertView()
    }
}
