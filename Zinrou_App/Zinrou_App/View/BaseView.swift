//
//  BaseView.swift
//  Zinrou_App
//
//  Created by 糸島光 on 2022/01/22.
//

import SwiftUI

struct BaseView: View {
    @StateObject var baseData = BaseViewModel()
    
    var body: some View {
        HomeView(stories: stories)
            .environmentObject(baseData)
            .overlay(PlayerSettingView().environmentObject(baseData))
            .overlay(GameExplanationView().environmentObject(baseData))
            .overlay(PositionExplanationView().environmentObject(baseData))
            .overlay(AppInfoView().environmentObject(baseData))
            .overlay(DeveloperView().environmentObject(baseData))
            .overlay(CustomAlertView().environmentObject(baseData))
            .overlay(DeletePlayerAlertView()
                .environmentObject(baseData))
            .overlay(YakusyokuSettingView().environmentObject(baseData))
            .overlay(GameView().environmentObject(baseData))
            .overlay(MeetingAlertView().environmentObject(baseData))
            .overlay(ResultView().environmentObject(baseData))
            .overlay(YakushokuConfirmationView().environmentObject(baseData))
            .overlay(MyAlertView().environmentObject(baseData))
           
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
