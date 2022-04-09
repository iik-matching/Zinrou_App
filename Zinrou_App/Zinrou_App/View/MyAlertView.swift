import SwiftUI

struct MyAlertView:View{

    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View{
        if baseData.isMyAlertView{

            ZStack{
                Color.brown.opacity(0.3).ignoresSafeArea()
                VStack{
                    Text(baseData.MyAlertMessage)
                    Divider()
                    Button(action:{
                        withAnimation{
                            baseData.isMyAlertView.toggle()
                        }
                    }){
                        Spacer()
                        Text("OK")
                        Spacer()
                    }
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
