//
//  GameExplanationView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/02.
//

import SwiftUI

struct GameExplanationView: View {
    @EnvironmentObject var baseData: BaseViewModel
   
    var body: some View {
        if baseData.isGameExplanationView {
            ZStack {
                Image(decorative:"ゲーム説明画面")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    VStack(){
                       Text("ゲーム説明")
                            .font(.largeTitle)
                            .frame(width: 400)
                            .foregroundColor(Color(.white))
                            .background(
                                // 線形グラデーション（青→黒）を生成
                                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                            ).padding(.top, 20)
                        
                        
                        
                        ScrollView {
                                VStack(spacing:8){
                                    Text("人狼ゲームとは").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                    Text("人狼ゲームとは、村人陣営と人狼陣営に分かれて、自分の陣営の勝利を目指すゲームです。村人陣営は議論を重ね、誰が人狼なのかを推理していきます。人狼陣営は正体を隠しながら、村人陣営の議論を引っ掻き回します。続いて、各陣営の勝利条件についてです。人狼ゲームには、大きく分けて「村人陣営」と「人狼陣営」2つの陣営があります。まずは、2つの陣営のやり方と、勝利条件について解説します。").foregroundColor(Color(.black)).padding(8)
                                    
                                    HStack{
                                         Text("【村人陣営】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"市民画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("「村人陣営」の勝利条件は、全ての人狼を処刑することです。役職ごとのやり方を覚え、村人陣営で相談し合いながら、人狼を探していきましょう。").foregroundColor(Color(.black)).padding(8)
                                    
                                    HStack{
                                         Text("【人狼陣営】").foregroundColor(Color(.black)).padding(3).font(.largeTitle)
                                         Image(decorative:"人狼画像")     // 画像指定
                                            .resizable()
                                            .frame(width: 100.0, height: 100.0)
                                    }
                                    Text("「人狼陣営」の勝利条件は、村人と人狼の人数が同じになること。村人を人狼だと勘違いさせ、処刑させることで、数を減らしていきましょう。").foregroundColor(Color(.black)).padding(3)
                                    
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

struct GameExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        GameExplanationView().environmentObject({ () -> BaseViewModel in
            let baseData = BaseViewModel()
            
              baseData.isGameExplanationView = true
            return baseData
        }())
    }
}
