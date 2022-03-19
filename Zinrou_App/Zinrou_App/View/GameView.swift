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
                    Image(decorative:"朝画像")     // 画像指定
                        .resizable()    // 画像サイズをフレームサイズに合わせる
                      
                }else{
                    Color.black.ignoresSafeArea()
                }
                
                VStack{
                    Text(baseData.game.players[baseData.nowIndex].name+" "+baseData.getasaOryoru()+"のアクション").padding()
                        .foregroundColor(Color(.white))
                        .font(.system(size: 28, design: .rounded))
                    
                    //役職ごとに画像を切り替える
                    VStack{
                        switch baseData.game.players[baseData.nowIndex].yakushoku!.name {
                        case "市民":
                            Image(decorative:"市民画像")     // 画像指定
                                .resizable()
                                .frame(width: 300.0, height: 300.0)
                        case "人狼":
                            Image(decorative:"人狼画像")     // 画像指定
                                .resizable()
                                .frame(width: 300.0, height: 300.0)
                        case "占い師":
                            Image(decorative:"占い師画像")     // 画像指定
                                .resizable()
                                .frame(width: 300.0, height: 300.0)
                        case "騎士":
                            Image(decorative:"騎士画像")     // 画像指定
                                .resizable()
                                .frame(width: 300.0, height: 300.0)
                        default: // .home
                            Image(decorative:"無画像")     // 画像指定
                        }
                    }
                    
                    if(baseData.getasaOryoru() == GameConst.ASA){
                
                        Text(/*@START_MENU_TOKEN@*/"人狼だと疑わしい人を選んでください。"/*@END_MENU_TOKEN@*/).frame(maxWidth:350, maxHeight:50)
                            .font(.system(size: 16, design: .serif))
                            .background(Color(.white))
                        ScrollView {
                            VStack(spacing:15){
                                
                                ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                    if(baseData.nowIndex != index){
                                        HStack{
                                            Text(baseData.game.players[index].name).font(.system(size: 24, design: .serif)).foregroundColor(Color(.black))
                                                .fontWeight(.semibold)
                                            
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
                                                        .foregroundColor(Color(.white))
                                                        .cornerRadius(18)
                                                        .background(
                                                            // 線形グラデーション（緑→黒）を生成
                                                            LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .bottom, endPoint: .top)
                                                        )
                                                        .cornerRadius(18)
                                                    
                                                }
                                            }else{
                                                Text("死亡").font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 120, height: 32)
                                                    .foregroundColor(Color(.red))
                                            }
                                        }
                                    }
                                }
                            }.padding()
                        }
                    }else{
                        Text("貴方は「"+baseData.game.players[baseData.nowIndex].yakushoku!.name+"」です。").font(.title).padding()
                            .foregroundColor(Color(.white))
                            .font(.system(size: 28, design: .rounded))
                            
                        VStack{
                            //夜のアクション説明欄
                            switch baseData.game.players[baseData.nowIndex].yakushoku!.name {
                            case "市民":
                                Text("この中で人狼だと疑わしいプレイヤーを1人選んでください")
                            case "人狼":
                                Text("今夜殺害するプレイヤーを１人選んでください")
                            case "占い師":
                                Text("あなたが人狼か人間か、確認したいプレイヤーを1人選んでください")
                            case "騎士":
                                Text("あなたが人狼の襲撃から守りたいプレイヤーを1人選んでください")
                            default: // .home
                                Text("")
                            }
                        }.frame(maxWidth:350, maxHeight:50)
                            .font(.system(size: 12, design: .serif))
                            .background(Color(.white))
                     
                        ScrollView {
                            VStack(spacing:15){
                                ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                    if(baseData.nowIndex != index){
                                        HStack{
                                            
                                            Text(baseData.game.players[index].name).font(.system(size: 24, design: .serif)).foregroundColor(Color(.red))
                                                .fontWeight(.semibold)
                                            
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
                                                        .foregroundColor(Color(.white))
                                                        .background(
                                                            // 線形グラデーション（赤→黒）を生成
                                                            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .bottom, endPoint: .top)
                                                        )
                                                        .cornerRadius(18)
                                                }
                                            }else{
                                                Text("死亡")
                                                    .font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 120, height: 32)
                                                    .foregroundColor(Color(.white))
                                            }
                                            
                                        }
                                    }
                                }
                            }.padding()
                        }
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
                                .foregroundColor(Color(.white))
                                .background(
                                    // 線形グラデーション（青→黒）を生成
                                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .bottom, endPoint: .top)
                                )
                                .cornerRadius(18)
                            
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
