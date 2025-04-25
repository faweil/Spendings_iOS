//
//  SpendingsApp.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/19/25.
//

import SwiftUI

@main
struct SpendingsApp: App {
    @StateObject var manageUser = ManageUser()
    
    var body: some Scene {
        WindowGroup {
            // if a current user is logged in
            if manageUser.currentUser != nil {
                MainPageView().environmentObject(manageUser)
            }else{
                LoginRegisterView().environmentObject(manageUser)
            }
            
        }
    }
}
