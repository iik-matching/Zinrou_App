//
//  PositionExplanationView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/02.
//

import SwiftUI

struct PositionExplanationView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View {
        if baseData.isPositionExplanationView {
            ZStack {
                Image(decorative:"役職説明画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    VStack(){
                       Text("役職説明")
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
                                    Text("役職一覧（市民陣営）")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.red))
                                        .padding(3)
                                        .font(.system(size: 26, design: .serif))
                                      
                                    
                                    HStack{
                                         Text("【市民】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"市民画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("何も能力を持たない村人サイドのプレイヤーです。できることは、推理と吊る人を決める投票のみです。現在の情報を元に推理し、村を平和に導きましょう。").foregroundColor(Color(.black)).padding(8).background(Color(.white))
                                    
                                    HStack{
                                         Text("【占い師】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"占い師画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("夜のターンで、誰か1名を指定して人狼か否かを知ることができます。人狼ゲームで最も重要な役職の一つと言えます。知ることができるのは、人狼であるか、そうでないかの2択なので、占い先が役職持ちであったとしても、占い師は村人としかわかりません。").foregroundColor(Color(.black)).padding(8).background(Color(.white))
                                    
                                    HStack{
                                         Text("【騎士】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"騎士画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("夜のターンで、誰か一人を人狼の襲撃から守ることができます。騎士が守っている人を人狼が襲撃した場合、襲撃は失敗し、翌日犠牲者は発生しません。").foregroundColor(Color(.black)).padding(8).background(Color(.white))
                                    
                                    
                                    Text("役職一覧（人狼陣営）")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.red))
                                        .padding(3)
                                        .font(.system(size: 26, design: .serif))
                                      
                                        
                                    
                                    HStack{
                                         Text("【人狼】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"人狼画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("人の皮をかぶった狼です。夜のターンで村人を一人襲撃して食い殺します。人狼は人間に対し、1対1では力で勝てますが、相手が村人2名だと勝てません。よって、人狼の数と村人の数が同数になるまで、村人に人狼だと悟られないように、夜の間にこっそりと一人づつ殺していきます。").foregroundColor(Color(.black)).padding(8).background(Color(.white))
                                    
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

struct PositionExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        PositionExplanationView().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
              baseData.isPositionExplanationView = true
            return baseData
        }())
    }
}
