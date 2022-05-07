import SwiftUI

struct KakuninView:View{
    
    @State var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    
    @State var delegate : NextPageProtocol? = nil
    
    var body: some View{
        ZStack{
            if(baseData.getasaOryoru() == GameConst.ASA){
                Image(decorative:"確認画面_朝")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
            }else{
                Image(decorative:"人狼確認画面背景画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
            }
            VStack(alignment: .center){
                Text(inputText)
                    .foregroundColor(Color(.white))
                    .font(.system(size: 22, design: .rounded))
                    .fontWeight(.semibold)
                    .background(Color.black)
                    .padding()


                Button(action:{
                    baseData.isKakuninFrag.toggle()
                    print("isKakuninFrag", baseData.isKakuninFrag)
                    if delegate != nil {
                        delegate!.nextPage()
                        if baseData.finalVoteFlg==false {
                            baseData.isActionResultView1.toggle()
                            print("isActionResultView1", baseData.isActionResultView1)
                        }
                            baseData.isActionResultView2.toggle()
                            print("isActionResultView2", baseData.isActionResultView2)
                        
                        baseData.finalVoteFlg = false
                        
                       if baseData.finalVoteFlg==true {
                         baseData.game.asaOrYoru = GameConst.YORU
                       }
                    }
                    
                }){
                    Spacer()
                    Text("OK")
                        .font(.system(size: 26, design: .serif))
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 36)
                        .foregroundColor(Color(.white))
                        .background(
                            // 線形グラデーション（青→黒）を生成
                            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                        )
                        .cornerRadius(18)
                    Spacer()
                }
            }
        }
    }
}



//struct KakuninView_Previews: PreviewProvider {
//    static var previews: some View {
//        KakuninView()
//            .environmentObject({ () -> BaseViewModel in
//                let baseData = BaseViewModel()
//
//                baseData.allocateJobTitle()
//                return baseData
//            }())
//    }
//}

