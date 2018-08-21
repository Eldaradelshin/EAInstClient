
import Foundation
import UIKit

protocol AuthorizationViewControllerDelegate: class {
    func authorizationViewController(_ viewController: UIViewController, authorizedWith token: String?)
}
