
import Foundation

class Credential {
    static var userIsAuthorized: Bool {
        if (token != nil) {
            return true
        }
        return false
    }
    static var token: String? {
        get {
            return UserDefaults.standard.value(forKey: "token") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
}
