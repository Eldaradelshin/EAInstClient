
import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    weak var delegate: AuthorizationViewControllerDelegate?
    
    let clientId = "7d2ffdc498e84aef838b36d260eb3496"
    let redirectUri = "https://instagram.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=token")
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        webView.navigationDelegate = self
        removeCache()
        webView.load(request)
    }
    
    func removeCache() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) {
            (records) in
            for record in records {
                dataStore.removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

}

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let urlString = navigationAction.request.url?.absoluteString else {
            decisionHandler(.allow)
            return
        }
        
        guard  urlString.range(of: "#access_token") != nil else {
            decisionHandler(.allow)
            return
        }
        
        let accessToken = urlString.components(separatedBy: "#access_token=").last!
        self.delegate?.authorizationViewController(self, authorizedWith: accessToken)
        print("TOKEN:\(accessToken)")
        decisionHandler(.cancel)
      //  print("TOKEN:\(accessToken)")
    }
}
