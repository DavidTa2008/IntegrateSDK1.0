//
//  ViewController.swift
//  IntegrateSDK1.0
//
//  Created by Ta Minh Tu on 7/29/18.
//  Copyright © 2018 David Ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center;
        self.view.addSubview(loginButton)
        
        
        // sharing text:
        let content = FBSDKShareLinkContent();
        let webURL = URL(string: "https://www.hackingwithswift.com")
        content.contentURL = webURL;
        
//        let hashtag = FBSDKHashtag("#MadeWithHackbook");
//
//        content.hashtag = hashtag;
//        content.
        
        
        
        
        
        
        //        do {
        //            let shareDialog: FBSDKShareDialog = FBSDKShareDialog()
        //
        //            shareDialog.shareContent = content
        //            //shareDialog.delegate = self
        //            shareDialog.fromViewController = self
        //            shareDialog.show()
        //        } catch {
        //            print("Error opening share dialog")
        //        }
        
        // add share button
        let shareButton = FBSDKShareButton();
        shareButton.shareContent = content;
        shareButton.center = view.center
        self.view.addSubview(shareButton);
    }
    
    
    let pageID = {Get Your Page ID On Facebook}
    var pageAccessToken : AccessToken?
    
    func requestPublishPermissions() {
        let loginManager = LoginManager()
        loginManager.logIn(publishPermissions: [ .managePages, .publishPages], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("grantedPermissions = \(grantedPermissions) \n" +
                    "declinedPermissions = \(declinedPermissions) \n" +
                    "accessToken = \(accessToken)")
            }
        }
    }
    
    func getPageAccessToken() {
        

        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email"])
        //let graphRequest = FBSDKGraphRequest(graphPath: "/\(pageID)?fields=access_token")
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            
            if error != nil {
                
                //do something with error
                
            } else {
                
                //do something with result
                
            }
            
        })
        
        connection.start()
        
        connection.add() { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Success: \(response)")
                self.pageAccessToken = AccessToken.init(authenticationToken: response.dictionaryValue?["access_token"] as! String)
            case .failed(let error):
                print("Graph Request Fail: \(error)")
            }
        }
        connection.start()
    }
    
    func postMessage() {
        let requestPage : GraphRequest = GraphRequest(graphPath: "\(pageID)/feed", parameters: ["message" : "Hello Page!"], accessToken: self.pageAccessToken, httpMethod: .POST, apiVersion: .defaultVersion)
        
        requestPage.start({ (connection, result) -> Void in
            print("RESULT = \(result)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

