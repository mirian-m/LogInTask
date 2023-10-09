//
//  UserDataManager.swift
//  LogInTask
//
//  Created by Admin on 10/8/23.
//

import Foundation
import UIKit

protocol Updateble {
    associatedtype T
    func update(data: T)
    func register(data: T)
}

class UserDataManager: Updateble {
    private (set) var users = [User]()
    
    func update(data: User) {
        let index = users.firstIndex { $0 == data }
        users[index!] = data
    }
    
    func register(data: User) {
        if users.filter({ $0 == data }).isEmpty {
            users.append(data)
        }
    }
    
    func search(_ user: User) -> User? {
        self.users.filter({ $0 == user }).first
    }
    
    func search(by userName: String, and password: String) -> User? {
        self.users.filter({ $0.name == userName && $0.password == password }).first
    }
}
