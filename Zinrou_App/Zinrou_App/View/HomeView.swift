//
//  HomeView.swift
//  Zinrou_App
//
//  Created by kitazato hironobu  on 2022/05/01.
//

import SwiftUI
import AVFoundation


struct Story {
    let id: Int
    let name: String
    let image: String
}

let stories: [Story] = [
    Story(id: 0, name: "ゲーム説明", image: "人狼ゲーム画像"),
    Story(id: 1, name: "役職説明", image: "市民画像"),
    Story(id: 2, name: "開発者", image: "開発者画像"),
    Story(id: 3, name: "アプリ概要", image: "アプリ概要画像"),
]


struct HomeView: View {
    @EnvironmentObject var baseData: BaseViewModel
    @State var trigger = false
    @State private var isFavorite = false
    let stories: [Story]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(decorative:"ホーム画面")     // 画像指定
                    .resizable()    // 画像サイズをフレームサイズに合わせる
                    .ignoresSafeArea()
                
                VStack{
                        ScrollView(.horizontal, showsIndicators: false) {
                                   HStack() {
                                       // 順番にStoryを処理
                                       ForEach(stories, id: \.id) { (story) in
                                           VStack(spacing: 0) {
                                               ZStack {
                                                   Button(action: {
                                                       if let soundURL = Bundle.main.url(forResource: "シーン切り替え", withExtension: "mp3") {
                                                           do {
                                                               player = try AVAudioPlayer(contentsOf: soundURL)
                                                               player?.play()
                                                           } catch {
                                                               print("error")
                                                           }
                                                       }
                                                       
                                                         self.isFavorite.toggle()
                                                           switch story.id {
                                                                   case 0:
                                                                       //ゲーム説明画面へ
                                                                        baseData.isGameExplanationView.toggle()
                                                                   case 1:
                                                                       //役職説明画面へ
                                                                        baseData.isPositionExplanationView.toggle()
                                                                   case 2:
                                                                       //開発者画面へ
                                                                        baseData.isDeveloperView.toggle()
                                                                       print()
                                                                   case 3:
                                                                       //アプリ概要画面へ
                                                                        baseData.isAppInfoView.toggle()
                                                                       print()
                                                                   default: // .home
                                                                       //ゲーム説明画面へ
                                                                        baseData.isGameExplanationView.toggle()
                                                                }
                                                     }) {
                                                         Image(story.image)
                                                             .renderingMode(.original)
                                                             .resizable()
                                                             .overlay(
                                                                 // Instagramらしいグラデーション色に!!
                                                                 Circle().stroke(LinearGradient(gradient: Gradient(colors: [.black, .blue, .green]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 10))
                                                             .frame(width: 90, height: 80)
                                                             .clipShape(Circle())
                                                     }
                                                  }
                                               Text(story.name)
                                                   .foregroundColor(Color(.white))
                                                   
                                           }
                                       }
                                   }
                                       .padding(.top, 5)
                                       .padding(.leading, 5)
                               }
                            Spacer().frame(height: 90)
                            VStack(spacing: 50){
                                    Button(action: {
                                    withAnimation {
                                    self.trigger.toggle()
                                    }
                                        if let soundURL = Bundle.main.url(forResource: "シーン切り替え", withExtension: "mp3") {
                                            do {
                                                player = try AVAudioPlayer(contentsOf: soundURL)
                                                player?.play()
                                            } catch {
                                                print("error")
                                            }
                                        }
                                    }) {
                                      Text("人狼ゲームへようこそ")
                                          .font(.system(size: 30, design: .serif))
                                          .fontWeight(.semibold)
                                          .foregroundColor(Color(.white))
                                    }
                                    Spacer().frame(height: 100)
                                    if trigger {
                                        Button(action: {
                                            withAnimation{
                                                //プレイヤ設定画面へ
                                                baseData.isPlayerSettingView.toggle()
                                            }
                                            if let soundURL = Bundle.main.url(forResource: "レクイエム", withExtension: "mp3") {
                                                do {
                                                    player = try AVAudioPlayer(contentsOf: soundURL)
                                                    player?.play()
                                                } catch {
                                                    print("error")
                                                }
                                            }
                                        }){
                                           Text("ゲームを始める")
                                               .font(.system(size: 36, design: .serif))
                                               .fontWeight(.semibold)
                                               .frame(width: 300, height: 50)
                                               .foregroundColor(Color(.blue))
                                               .background(Color(.white))
                                               .cornerRadius(36)
                                               .transition(.move(edge: .leading))
                                        }.padding(.vertical,15)
                                     }
                               }.font(.title)
                        Spacer()
               }
         
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(stories: stories)
            .environmentObject({ () -> BaseViewModel in
                let baseData = BaseViewModel()
                baseData.allocateJobTitle()
                baseData.playerEditAlert = false
                return baseData
            }())
    }
}
