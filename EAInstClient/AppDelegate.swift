

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        self.window = UIWindow()
        
        let firstViewController: UIViewController
        
        if Credential.isUserAuthenticated {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
            firstViewController = mainViewController
        } else {
            guard let authorizationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"AuthorizationViewController") as?
                AuthorizationViewController else {
                    return false
            }
            authorizationViewController.delegate = self
            firstViewController = authorizationViewController
            
        }
        self.window?.rootViewController = firstViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate:AuthorizationViewControllerDelegate {
    func authorizationViewController(_ viewController: UIViewController, authorizedWith token: String?) {
        Credential.token = token
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"MainViewController")
        viewController.present(mainViewController, animated: true, completion: nil)
    }
}


