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
    var body: some View {
        if baseData.meetingAlert{
            if baseData.timeCount > 0{
                ZStack{
                    Color.brown.opacity(1).ignoresSafeArea()
                    VStack{
                        Text("\(baseData.timeCount)")
                            .onReceive(timer) { input in
                                baseData.timeCount -= 1
                                    print(baseData.timeCount)
                            }
                        
                        Button(action: {
                            baseData.timeCount = 0
                        }){
                            Text("会議を飛ばす")
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
