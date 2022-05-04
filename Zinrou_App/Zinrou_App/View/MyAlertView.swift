import SwiftUI

struct MyAlertView:View{

    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View{
        if baseData.isMyAlertView{

            ZStack{
                Image(decorative:"ゲーム説明画面")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                    Text(baseData.MyAlertMessage)
                    Divider()
                    Button(action:{
                        withAnimation{
                            baseData.isMyAlertView.toggle()
                        }
                    }){
                        Spacer()
                        Text("OK").font(.system(size: 36, design: .serif))
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50)
                            .foregroundColor(Color(.blue))
                            .background(Color(.white))
                            .cornerRadius(36)
                            .transition(.move(edge: .leading))
                        
                        Spacer()
                    }.padding(.vertical,15)
                    
                }.padding().fixedSize()
                    .background(Color.gray.brightness(0.5)).cornerRadius(20)
            }
        }
    }
}


struct MyAlertViewView_Previews: PreviewProvider {
    static var previews: some View {
        MyAlertView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                return baseData
            }())
    }
}
