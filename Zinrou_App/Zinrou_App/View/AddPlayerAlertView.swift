////
////  AddPlayerView.swift
////  Zinrou_App
////
////  Created by 糸島光 on 2021/11/22.
////
//
//import Foundation
//import SwiftUI
//
//struct AddPlayerAlertView: View {
//    @EnvironmentObject var settingData: SettingViewModel
//    @Environment(\.presentationMode) var presentationMode
//    @State private var playerName = ""
//    var body: some View {
//        if settingData.addPlayerAlert{
//            VStack{
//                TextField("プレイヤー名を入力してください。", text: $playerName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                HStack{
//                    Button(action: {
//                        withAnimation{
//                            settingData.addPlayerAlert.toggle()
//                        }
//                    }) {
//                        Spacer()
//                        Text("Cancel")
//                        Spacer()
//                    }
//                    Button(action: {
//                        settingData.addPlayerName(name:playerName)
//                        self.presentationMode.wrappedValue.dismiss()
//                        
//                    }) {
//                        Spacer()
//                        Text("OK")
//                        Spacer()
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct AddPlayerView_Previews: PreviewProvider {
//    @State var playersName = ["Hikaru"]
//    static var previews: some View {
//        AddPlayerAlertView()
//    }
//}
