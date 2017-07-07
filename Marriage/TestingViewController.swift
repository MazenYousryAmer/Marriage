//
//  TestingViewController.swift
//  Marriage
//
//  Created by Mazen on 7/7/17.
//  Copyright © 2017 ZooZoo. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class TestingViewController: ParentViewController {

    @IBOutlet var testBtnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.testBtnLogin = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        FBbtn = FBSDKLoginButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        self.testBtnLogin.readPermissions = ["public_profile", "email"];
//        self.view.addSubview(FBbtn)
        
        self.testBtnLogin.addTarget(self, action: #selector(self.loginButtonClicked), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
                    switch result {
                    case .success(let response):
                        print("Graph Request Succeeded: \(response)")
                    case .failed(let error):
                        print("Graph Request Failed: \(error)")
                    }
                }
                connection.start()
            }
        }
//        loginManager.logIn([.publicProfile], viewController: self, completion: { loginResult in
//        
//            switch loginResult{
//                            case .Failed(let error):
//                                print(error)
//                            case .Cancelled:
//                                print("User cancelled login.")
//                            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
//                                print("Logged in!")
//                            }
//            }
//        )
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
