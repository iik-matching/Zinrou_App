import SwiftUI

struct CustomAlertView:View{
    
    @State var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    @FocusState var isFieldFocused: Bool
    
    var body: some View{
        if baseData.addPlayerAlert{
            ZStack{
                Color.brown.opacity(0.3).ignoresSafeArea()
                VStack{
                    Text("プレイヤーの追加")
                    TextField("名前",text:$inputText)
                        .background(Color.white).frame(width:200)
                        .focused($isFieldFocused, equals: true)
                    Divider()
                    HStack{
                        Button(action:{
                            withAnimation{
                                baseData.addPlayerAlert.toggle()
                            }
                        }){
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Button(action:{
                            baseData.addPlayer(playersName: inputText)
                            withAnimation{
                                baseData.addPlayerAlert.toggle()
                            }
                        }){
                            Spacer()
                            Text("OK")
                            Spacer()
                        }
                        Spacer()
                    }.overlay(HStack{Divider()})
                }.padding().fixedSize()
                    .background(Color.gray.brightness(0.5)).cornerRadius(20)
            }.onAppear{
                inputText = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {  /// Anything over 0.5 seems to work
                    isFieldFocused = true
                 }
            }
        }
    }
}

//
//struct CustomAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertView()
//            .environmentObject({ () -> BaseViewModel in
//                let baseData = BaseViewModel()
//                baseData.customAlert = true
//                return baseData
//            }())
//    }
//}
