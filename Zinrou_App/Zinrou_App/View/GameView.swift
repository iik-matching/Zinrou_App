//
//  GameView.swift
//  Zinrou_App
//
//  Created by 入江健太 on 2022/03/12.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var baseData: BaseViewModel
    
    @State private var showingAlert = false
    @State private var selectIndex = 0
    
    var body: some View {
        if baseData.isShowGameView && baseData.isKakuninFrag {
            ZStack{
                //背景画像
                if(baseData.getasaOryoru() == GameConst.ASA){
                    Image(decorative:"朝画像")     // 画像指定
                        .resizable()    // 画像サイズをフレームサイズに合わせる
                        .ignoresSafeArea()
                }else{
                    Color.black.ignoresSafeArea()
                }
                
                VStack{
                    //朝のアクション or 夜のアクション
                    Text(baseData.game.players[baseData.nowIndex].name+" "+baseData.getasaOryoru()+"のアクション").padding()
                        .foregroundColor(Color(.white))
                        .font(.system(size: 28, design: .rounded))
                    
                    //その他説明
                    if(baseData.getasaOryoru() == GameConst.ASA){
                        Text(ExtentionMessageConst.SIMIN).frame(maxWidth:350, maxHeight:50)
                            .font(.system(size: 16, design: .serif))
                            .background(Color(.white))
                    }else{
                        //役職ごとに画像を切り替える
                        Image(decorative:"\(baseData.game.players[baseData.nowIndex].yakushoku!.name)画像")     // 画像指定
                            .resizable()
                            .frame(width: 300.0, height: 300.0)
                        
                        Text("貴方は「"+baseData.game.players[baseData.nowIndex].yakushoku!.name+"」です。").font(.title).padding()
                            .foregroundColor(Color(.white))
                            .font(.system(size: 28, design: .rounded))
                        //夜のアクション説明欄
                        if(baseData.CheckShoya()){
                            Text(ExtentionMessageConst.SIMIN)
                                .frame(maxWidth:350, maxHeight:50)
                                .font(.system(size: 12, design: .serif))
                                .background(Color(.white))
                        }else{
                            Text(baseData.game.players[baseData.nowIndex].yakushoku!.extentionMessage)
                                .frame(maxWidth:350, maxHeight:50)
                                .font(.system(size: 12, design: .serif))
                                .background(Color(.white))
                        }
                    }
                    //プレイヤー選択エリア
                    ScrollView {
                        VStack(spacing:15){
                            ForEach(0..<baseData.game.players.count, id: \.self) { index in
                                if(baseData.nowIndex != index){
                                    if(baseData.getasaOryoru() == GameConst.ASA){
                                        HStack{
                                            Text(baseData.game.players[index].name).font(.system(size: 24, design: .serif)).foregroundColor(Color(.black))
                                                .fontWeight(.semibold)
                                            
                                            if(baseData.game.players[index].isDeath==false){
                                                Button(action: {
                                                    self.showingAlert = true
                                                    selectIndex = index
                                                }) {
                                                    Text("投票する")
                                                        .font(.system(size: 22, design: .serif))
                                                        .fontWeight(.semibold)
                                                        .frame(width: 120, height: 32)
                                                        .foregroundColor(Color(.white))
                                                        .background(
                                                            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .bottom, endPoint: .top)
                                                        )
                                                        .cornerRadius(18)
                                                }.alert("アクション確認", isPresented: $showingAlert){
                                                    Button("キャンセル"){
                                                        //何もしない
                                                    }
                                                    Button("OK"){
                                                        //アクション実行
                                                        baseData.game.players[baseData.nowIndex].yakushoku!.action1(name:baseData.game.players[selectIndex].name, delegate:baseData )
                                                        
                                                        //次の人物へ
                                                        baseData.isKakuninFrag.toggle()
                                                        baseData.next()
                                                        baseData.selectindex = nil
                                                    }
                                                } message: {
                                                    Text(baseData.game.players[selectIndex].name+"さんに投票しますか？")
                                                }
                                            }else{
                                                Text("死亡").font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 120, height: 32)
                                                    .foregroundColor(Color(.red))
                                            }
                                        }
                                    }else if(baseData.getasaOryoru() == GameConst.YORU && baseData.game.turnCount != 1){
                                        HStack{
                                            Text(baseData.game.players[index].name).font(.system(size: 24, design: .serif)).foregroundColor(Color(.white))
                                                .fontWeight(.semibold)
                                            
                                            if(baseData.game.players[index].isDeath==false){
                                                Button(action: {
                                                    self.showingAlert = true
                                                    selectIndex = index
                                                }) {
                                                    Text(baseData.game.players[baseData.nowIndex].yakushoku!.actionText)
                                                        .font(.system(size: 22, design: .serif))
                                                        .fontWeight(.semibold)
                                                        .frame(width: 120, height: 32)
                                                        .foregroundColor(Color(.white))
                                                        .background(
                                                            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .bottom, endPoint: .top)
                                                        )
                                                        .cornerRadius(18)
                                                }.alert("アクション確認", isPresented: $showingAlert){
                                                    Button("キャンセル"){
                                                        //何もしない
                                                    }
                                                    Button("OK"){
                                                        //アクション実行
                                                        baseData.game.players[baseData.nowIndex].yakushoku!.action2(name:baseData.game.players[selectIndex].name, delegate:baseData )
                                                        
                                                        
                                                        //次の人物へ
                                                        baseData.isKakuninFrag.toggle()
                                                        baseData.next()
                                                        baseData.selectindex = nil
                                                    }
                                                } message: {
                                                    Text("\(baseData.game.players[selectIndex].name)\(baseData.game.players[baseData.nowIndex].yakushoku!.yoruActionMessage)")
                                                }
                                            }else{
                                                Text("死亡").font(.system(size: 22, design: .serif))
                                                    .fontWeight(.semibold)
                                                    .frame(width: 120, height: 32)
                                                    .foregroundColor(Color(.red))
                                            }
                                        }
                                    }else if(baseData.getasaOryoru() == GameConst.YORU && baseData.game.turnCount == 1){
                                        HStack{
                                            Text(baseData.game.players[index].name).font(.system(size: 24, design: .serif)).foregroundColor(Color(.white))
                                                .fontWeight(.semibold)
                                            
                                            if(baseData.game.players[index].isDeath==false){
                                                Button(action: {
                                                    self.showingAlert = true
                                                    selectIndex = index
                                                }) {
                                                    Text(ActionTextConst.SIMIN)
                                                        .font(.system(size: 22, design: .serif))
                                                        .fontWeight(.semibold)
                                                        .frame(width: 120, height: 32)
                                                        .foregroundColor(Color(.white))
                                                        .background(
                                                            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .bottom, endPoint: .top)
                                                        )
                                                        .cornerRadius(18)
                                                }.alert("アクション確認", isPresented: $showingAlert){
                                                    Button("キャンセル"){
                                                        //何もしない
                                                    }
                                                    Button("OK"){
                                                        //アクション実行
                                                        baseData.game.players[baseData.nowIndex].yakushoku!.action3(name:baseData.game.players[selectIndex].name, delegate:baseData )
                                                        
                                                        
                                                        //次の人物へ
                                                        baseData.isKakuninFrag.toggle()
                                                        baseData.next()
                                                        baseData.selectindex = nil
                                                    }
                                                } message: {
                                                    Text("\(baseData.game.players[selectIndex].name)\(YoruActionMessageConst.SIMIN)")
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
                            }
                        }.padding()
                    }
                    
                }
            }
            //ゲームビュー表示状態　かつ　未確認の場合
        }else if baseData.isShowGameView && baseData.isKakuninFrag == false{
            //確認画面を表示
            KakuninView(inputText:"貴方は「\(baseData.game.players[baseData.nowIndex].name)」ですか？")
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


//ボタンを押している間ボタンの色を変更する
struct TapButtonStyle:ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.4 : 1)
        
    }
}

