import Foundation

struct User {
    let id = UUID().uuidString
    var name: String = ""
    var password: String = ""
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {}
    
}
