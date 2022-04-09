import SwiftUI

struct KakuninView:View{
    
    @State var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    
    var body: some View{
        ZStack{
            Color.brown.ignoresSafeArea()
            VStack{
                Text(inputText)

                Button(action:{
                    baseData.isKakuninFrag.toggle()
                }){
                    Spacer()
                    Text("OK")
                    Spacer()
                }
            }
        }
    }
}



struct KakuninView_Previews: PreviewProvider {
    static var previews: some View {
        KakuninView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()

                baseData.allocateJobTitle()
                return baseData
            }())
    }
}

