//
//  ActionResultView2.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/07.
//

import SwiftUI

struct ActionResultView2: View {
    @EnvironmentObject var baseData: BaseViewModel
    @State var delegate : NextPageProtocol? = nil
    
    var body: some View {
        if baseData.isActionResultView2{
            Image(decorative:"ゲーム説明画面")     // 画像指定
                .resizable()    // 画像サイズをフレームサイズに合わせる
                .ignoresSafeArea()
            
            VStack{
                VStack(){
                    Text("The \(baseData.game.turnCount)ST Morning")
                        .font(.largeTitle)
                        .frame(width: 400)
                        .foregroundColor(Color(.white))
                        .background(
                            // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                        ).padding(.top, 20)
                }
            
                
                if baseData.getasaOryoru() == GameConst.ASA {  //朝の場合
                    if baseData.finalVoteFlg == false{//通常投票である場合
                        ScrollView {
                            VStack(spacing:8){
                                Text("【Game Masterからの報告】").foregroundColor(Color(.black)).padding(3).font(.title2)
                                Text("投票の結果、本日処刑されるプレイヤーは、、、").foregroundColor(Color(.black)).padding(8)
                                Text(baseData.boteDeathMessage).foregroundColor(Color(.red)).padding(3).font(.title3)
                                
                            }.padding()
                                .frame(width: 350.0)
                        }
                    }else{//決戦投票である場合
                        ScrollView {
                            VStack(spacing:8){
                                Text("【Game Masterからの報告】").foregroundColor(Color(.black)).padding(3).font(.title2)
                                Text("決戦投票の結果、本日処刑されるプレイヤーは、、、").foregroundColor(Color(.black)).padding(8)
                                Text(baseData.boteDeathMessage).foregroundColor(Color(.red)).padding(3).font(.title3)
                                
                            }.padding()
                                .frame(width: 350.0)
                        }
                    }
                }else{ //夜の場合
                    ScrollView {
                        VStack(spacing:8){
                            Text("【Game Masterからの報告】").foregroundColor(Color(.black)).padding(3).font(.title2)
                            Text("恐ろしい夜が明け、朝が来ました。昨晩の犠牲者は、、、、").foregroundColor(Color(.black)).padding(8)
                            Text(baseData.attackDeathMessage).foregroundColor(Color(.red)).padding(3).font(.title3)
                            Text("それに加え、最も人狼だと疑われている方は、、、").foregroundColor(Color(.black)).padding(8)
                            ForEach(0..<baseData.suspectNameList.count,id: \.self){ index in
                                Text(baseData.suspectNameList[index]).foregroundColor(Color(.red)).padding(3).font(.title3)
                            }
                            
                        }.padding()
                            .frame(width: 350.0)
                    }
                }
                
                Button(action: {
                    withAnimation{
                        baseData.meetingAlert.toggle()
                        //朝夜チェンジ
                        baseData.game.switchAsaYoru()
                        
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

struct ActionResultView2_Previews: PreviewProvider {
    static var previews: some View {
        ActionResultView2().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
            baseData.isActionResultView2 = true
            return baseData
        }())
    }
}
