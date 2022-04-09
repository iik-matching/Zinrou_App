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
        PlayerSettingView()
            .environmentObject(baseData)
            .overlay(CustomAlertView().environmentObject(baseData))
            .overlay(DeletePlayerAlertView()
                .environmentObject(baseData))
            .overlay(GameView().environmentObject(baseData))
            .overlay(ResultView().environmentObject(baseData))
            .overlay(YakushokuSettingView().environmentObject(baseData))
            .overlay(MyAlertView().environmentObject(baseData))
            
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
