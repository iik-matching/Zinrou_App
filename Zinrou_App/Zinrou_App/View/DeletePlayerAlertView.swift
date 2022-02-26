//
//  DeletePlayerAlertView.swift
//  Zinrou_App
//
//  Created by 糸島光 on 2022/02/26.
//

import SwiftUI

struct DeletePlayerAlertView:View{
    
    @State var inputText = ""
    @EnvironmentObject var baseData: BaseViewModel
    @FocusState var isFieldFocused: Bool
    
    var body: some View{
        if baseData.playerDeleteAlert{
            ZStack{
                Color.brown.opacity(0.3).ignoresSafeArea()
                VStack{
                    if let i = baseData.deletePlayerIndex{
                        Text("\(baseData.game.players[i].name)を削除しますか？")
                    }
                    Divider()
                    HStack{
                        Button(action:{
                            withAnimation{
                                baseData.playerDeleteAlert.toggle()
                            }
                        }){
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Button(action:{
                            baseData.deletePlayer()
                            withAnimation{
                                baseData.playerDeleteAlert.toggle()
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
