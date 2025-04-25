//
//  ManageUser.swift
//  Spendings
//
//  Created by Fabian Weiland on 4/24/25.
//

import Foundation

class ManageUser: ObservableObject{
    @Published var currentUser: User? = nil
    @Published var users: [User] = []
    
    private let userFileName = "user.json"

    
    init(){
        loadUsers()
    }
    
    private func loadUsers(){
        let path = getDirectory().appendingPathComponent(userFileName)
        do {
            let data = try Data(contentsOf: path)
            users = try JSONDecoder().decode([User].self, from: data)
        } catch{
            print("no saved users or error loading users!")
        }
        
    }
    
    func getDirectory() -> URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func saveUsers(){
        let path = getDirectory().appendingPathComponent(userFileName)
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: path)
        } catch{
            print("error saving users")
        }
    }
    
    func register(username: String, password: String) -> Bool{
        // check if username already exist
        if users.contains(where: {$0.username == username}){
            print("username already exist")
            return false
        }
        // if username not exist, save it
        let newUser = User(username: username, password: password)
        users.append(newUser)
        saveUsers()
        return true
    }
    
    func logIn(username: String, password: String) -> Bool{
        // check if username and password are correct
        if let user = users.first(where: {$0.username == username && $0.password == password}){
            currentUser = user
            return true
        }
        print("Wrong username or password")
        return false
    }
    
    func logOut(){
        currentUser = nil
    }
}
