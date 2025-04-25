//
//  LoginRegisterView.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/24/25.
//

import SwiftUI

struct LoginRegisterView: View {
    @EnvironmentObject var manageUser: ManageUser
    
    @State private var username = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("💸 Spendings 💸")
                .font(.title2.bold())
                .foregroundColor(.accentColor)
                
            
            Text(isRegistering ? "Register" : "Login")
                .font(.largeTitle)
            
            TextField("Username: ", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password: ", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(isRegistering ? "Register" : "Login"){
                
                if isRegistering{ // Register
                    if manageUser.register(username: username, password: password){
                        manageUser.logIn(username: username, password: password)
                    } else{
                        errorMessage = "Username already exists."
                    }
                    
    
                } else{ // Login
                    if !manageUser.logIn(username: username, password: password){
                        errorMessage = "Wrong Username or Password!"
                    }
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Button(isRegistering ? "Already have an Account? Login here" : "No Account yet? Register here"){
                isRegistering.toggle()
                //errorMessage = ""
            }
            
            if !errorMessage.isEmpty{
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}



struct LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterView()
    }
}
