import SwiftUI

struct PlayerSettingView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    @State var inputText = ""
    
    var body: some View {
        if baseData.isPlayerSettingView {
            // Created by 北里優宜    2022/2/26
            ZStack {
                Image(decorative:"人狼背景画像")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                VStack{
                        Text("【 プレイヤー追加画面 】")
                            .font(.largeTitle)
                            .frame(width: 500)
                            .foregroundColor(Color(.white))
                            .background(
                                // 線形グラデーション（青→黒）を生成
                                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                             ).padding(.top, 20)
                    
                    ScrollView {
                            VStack(spacing:8){
                                ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                    VStack{
                                        if (baseData.playerEditAlert &&  index == baseData.getEditPlayerIndex()){
                                            TextField("",text:$inputText,onCommit:{
                                                if inputText != ""{
                                                    baseData.game.players[index].name = inputText
                                                }
                                                baseData.playerEditAlert.toggle()
                                            })
                                                .background(Color.white).frame(width:200)
                                                .keyboardType(UIKeyboardType.default)
    //                                            .focused($isFieldFocused, equals: true)
                                            Divider()
                                        }else{
                                            Text(baseData.game.players[index].name)
                                                .font(.system(size: 34, design: .serif))
                                                .foregroundColor(Color(.white))
                                        }
                                        HStack{
                                            Button(action: {
                                                withAnimation {
                                                    baseData.playerEditAlert.toggle()
                                                }
                                                baseData.setEditPlayerIndex(index: index)
                                                inputText = baseData.game.players[index].name
    //                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {  /// Anything over 0.5 seems to work
    //                                                isFieldFocused = true
    //                                             }
                                            }){
                                                Text("編集")
                                                    .font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 80, height: 32)
                                                    .foregroundColor(Color(.white))
                                                    .background(Color(.black))
                                                    .cornerRadius(18)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color(.green), lineWidth: 2.0)
                                                    )
                                            }
                                            Button(action: {
                                                if(baseData.game.players.count <= 4){
                                                    withAnimation {
                                                        baseData.MyAlertMessage = "４人以下にはできません"
                                                        baseData.isMyAlertView.toggle()
                                                    }
                                                }else{
                                                    withAnimation {
                                                        baseData.playerDeleteAlert.toggle()
                                                    }
                                                    print("削除")
                                                    baseData.deletePlayerIndex = index
                                                }

                                            }){
                                                Text("削除")
                                                    .font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 80, height: 32)
                                                    .foregroundColor(Color(.black))
                                                    .background(Color(.white))
                                                    .cornerRadius(18)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color(.orange), lineWidth: 2.0)
                                                    )

                                            }
                                        }
                                    }.padding()
                                }
                            }.padding()
                            .frame(width: 350.0)
                            .background(   //放射状グラデーション（赤→黒）を生成
                                   RadialGradient(gradient: Gradient(colors: [.red, .black]), center: .center, startRadius: 1, endRadius: 300)
                               )
                    }
                    
                    VStack(spacing:10){
                        Button(action: {
                            withAnimation{
                                baseData.addPlayerAlert.toggle()
                            }
                        }){
                            Text("プレイヤー追加")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 48)
                                .foregroundColor(Color(.white))
                                .background(Color(.blue))
                                .cornerRadius(24)
                            
                        }
                        Button(action: {
                            baseData.allocateJobTitle()

                            withAnimation{
                                //ゲーム画面へ
                                baseData.isShowGameView.toggle()
                            }
                        }){
                            Text("GAME START")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 48)
                                .foregroundColor(Color(.white))
                                .background(Color(.purple))
                                .cornerRadius(24)
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
                                .foregroundColor(Color(.black))
                                .background(Color(.white))
                                .cornerRadius(24)
                        }
                    }
                }
          }
      }
    }
}

struct PlayerSettingView_Previews: PreviewProvider {
   
    static var previews: some View {
        PlayerSettingView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                
                baseData.isPlayerSettingView = true
                baseData.allocateJobTitle()
                baseData.playerEditAlert = false
                return baseData
            }())
    }
}
