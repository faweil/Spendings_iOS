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
        ZStack{
            
            // changing color from bottom right to top left
            LinearGradient(gradient: Gradient(colors: [Color(red: 189/255, green: 224/255, blue: 254/255), Color(red: 200/255, green: 210/255, blue: 255/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            VStack{
                
                Text("💸 Spendings 💸")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 40)
                    
                Spacer()
                
                VStack(spacing: 20){
                    Text(isRegistering ? "Register" : "Login")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    TextField("Username: ", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    SecureField("Password: ", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
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
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button(isRegistering ? "Already have an Account? Login here" : "No Account yet? Register here"){
                        isRegistering.toggle()
                        errorMessage = ""
                    }
                    .font(.footnote)
                    .foregroundColor(.blue)
                    
                    if !errorMessage.isEmpty{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                Spacer()
            }
        }
    }
}



struct LoginRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterView()
    }
}
