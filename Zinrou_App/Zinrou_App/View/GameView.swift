//
//  GameView.swift
//  Zinrou_App
//
//  Created by 入江健太 on 2022/03/12.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var baseData: BaseViewModel
    var body: some View {
        if baseData.isShowGameView{
            ZStack{
                if(baseData.getasaOryoru() == GameConst.ASA){
                    Color.green.ignoresSafeArea()
                }else{
                    Color.brown.ignoresSafeArea()
                }
                
                VStack{
                    Text(baseData.game.players[baseData.nowIndex].name+" "+baseData.getasaOryoru()+"のアクション").padding()
                    
                    if(baseData.getasaOryoru() == GameConst.ASA){
                        Text(/*@START_MENU_TOKEN@*/"人狼だと疑わしい人を選んでください。"/*@END_MENU_TOKEN@*/)
                        
                        VStack(spacing:15){
                            
                            ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                if(baseData.nowIndex != index){
                                    HStack{
                                        Text(baseData.game.players[index].name)
                                        if(baseData.game.players[index].isDeath==false){
                                            Button(action: {
                                                if baseData.didAction == false{
                                                    //選択した人を疑う
                                                    baseData.game.players[baseData.nowIndex].yakushoku!.action1(name:baseData.game.players[index].name, delegate:baseData )
                                                    //次にの人物へ
                                                    //baseData.next()
                                                    
                                                    baseData.didAction = true
                                                }
                                            }){
                                                Text("疑う")
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
                                        }else{
                                            Text("死亡")
                                        }
                                    }
                                }
                            }
                        }.padding()
                    }else{
                        Text("貴方は「"+baseData.game.players[baseData.nowIndex].yakushoku!.name+"」です。").font(.title).padding()
                        
                        Text(baseData.game.players[baseData.nowIndex].yakushoku!.actionText)
                        
                        VStack(spacing:15){
                            ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                if(baseData.nowIndex != index){
                                    HStack{
                                        
                                        Text(baseData.game.players[index].name)
                                        if(baseData.game.players[index].isDeath==false){
                                            
                                            Button(action: {
                                                if baseData.didAction == false{
                                                    baseData.game.players[baseData.nowIndex].yakushoku!.action2(name:baseData.game.players[index].name, delegate:baseData )
                                                    //次にの人物へ
                                                    //baseData.next()
                                                    
                                                    //baseData.selectPlayer = baseData.game.players[index].name
                                                    baseData.didAction = true
                                                }
                                            }){
                                                Text(baseData.game.players[baseData.nowIndex].yakushoku!.actionText)
                                                    .font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 120, height: 32)
                                                    .foregroundColor(Color(.black))
                                                    .background(Color(.white))
                                                    .cornerRadius(18)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color(.orange), lineWidth: 2.0)
                                                    )
                                                
                                            }
                                        }else{
                                            Text("死亡")
                                        }
                                        
                                    }
                                }
                            }
                        }.padding()
                        
                    }
                    if(baseData.didAction == true){
                        Button(action: {
                            
                            //次にの人物へ
                            baseData.next()
                            
                        }){
                            Text("次へ")
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
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    //@State static var base = BaseViewModel()
    static var previews: some View {
        GameView()
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                baseData.allocateJobTitle()
                baseData.isShowGameView = true
                return baseData
            }())
    }
}
