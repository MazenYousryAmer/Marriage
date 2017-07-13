//
//  ViewController.swift
//  Marriage
//
//  Created by ZooZoo on 5/16/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LandingViewController: ParentViewController {
    
    //MARK:- IBOutlets
    @IBOutlet var lblError: UILabel!
    @IBOutlet var txtName: UITextField!  // This label name & value should be email as we enter our email not our name
    @IBOutlet var txtPass: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnForget: UIButton!
    @IBOutlet var btnFacebook: UIButton!
    @IBOutlet var lblForget : UILabel!
    @IBOutlet var lblErrorHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var viewLogin: UIView!
    @IBOutlet var txtLoginName: UITextField!
    @IBOutlet var txtLoginPass: UITextField!
    @IBOutlet var btnLoginSignin: UIButton!
    
    @IBOutlet var img: UIImageView!
    
    //MARK:- variables
//    var timer : NSTimer!
    
    //MARK:- View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = NSBundle.mainBundle().URLForResource("Lady", withExtension: "gif")
//        self.img.image = UIImage.animatedImageWithAnimatedGIFData(NSData.init(contentsOfURL: url!)!)
        
        self.btnFacebook.addTarget(self, action: #selector(self.loginButtonClicked), for: UIControlEvents.touchUpInside)

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // remove navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Re-shaping register btn
        self.btnRegister.layer.borderWidth = 1.0
        self.btnRegister.layer.borderColor = UIColor(red: 253.0/255.0, green: 114.0/255.0, blue: 174.0/255.0, alpha: 1.0).cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        self.btnLogin.transform = CGAffineTransform(translationX: 0, y: 0)
        self.btnRegister.transform = CGAffineTransform(translationX: 0, y: 0)
        self.btnFacebook.transform = CGAffineTransform(translationX: 0, y: 0)
        self.btnForget.transform = CGAffineTransform(translationX: 0, y: 0)
        self.lblForget.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    //MARK:- Functions
    func RemoveError()
    {
        UIView.animate(withDuration: 0.25, delay: 1.5, options: .curveEaseOut, animations:
            {
                self.lblErrorHeightConstraint.constant = 0.0
            }, completion:nil)
    }
    
    //MARK:- IBActions
    @IBAction func loginBtnPressed()
    {
//        UIView.animateKeyframesWithDuration(1.15, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear,animations: {
//            // each keyframe needs to be added here
//            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
//            UIView.addKeyframeWithRelativeStartTime(0 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
//                self.btnFacebook.transform = CGAffineTransformMakeTranslation(0, 350)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0.05 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
//                self.btnForget.transform = CGAffineTransformMakeTranslation(0, 350)
//                self.lblForget.transform = CGAffineTransformMakeTranslation(0, 350)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0.1 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
//                self.btnRegister.transform = CGAffineTransformMakeTranslation(0, 350)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0.15 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
//                self.btnLogin.transform = CGAffineTransformMakeTranslation(0, 350)
//            })
//            //            UIView.addKeyframeWithRelativeStartTime(1.0 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//            //                self.btnFacebook.alpha = 0.0
//            //                self.btnForget.alpha = 0.0
//            //            })
//            //            UIView.addKeyframeWithRelativeStartTime(1.1 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//            //                self.btnLogin.alpha = 0.0
//            //            })
//            //            UIView.addKeyframeWithRelativeStartTime(1.2 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//            //                self.btnRegister.alpha = 0.0
//            //            })
//            }, completion: {finished in
//                // any code entered here will be applied
//                // once the animation has completed
//                self.performSegueWithIdentifier("LoginViewController", sender: nil)
//        })
        if self.txtName.text == ""
        {
            let alert = UIAlertController(title: "Error", message: NSLocalizedString("nameError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if self.txtPass.text == ""
        {
            let alert = UIAlertController(title: "Error", message: NSLocalizedString("passError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            //            UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseOut, animations:
            //                {
            //                    self.lblError.text = "initializing session"
            //                    self.lblErrorHeightConstraint.constant = 20.0
            //                }, completion:{ finished in
            //                    self.RemoveError()
            //            })
            self.view.endEditing(true)
            if Token == ""
            {
                CallHandShake()
            }
            else
            {
                showLoading()
                CallLogin()
            }
        }

    }
    
    @IBAction func RegisterBtnPressed()
    {
        UIView.animateKeyframes(withDuration: 1.15, delay: 0.0, options: UIViewKeyframeAnimationOptions(),animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            UIView.addKeyframe(withRelativeStartTime: 0 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnFacebook.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.05 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnForget.transform = CGAffineTransform(translationX: 0, y: 350)
                self.lblForget.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnLogin.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.15 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnRegister.transform = CGAffineTransform(translationX: 0, y: 350)
            })
//            UIView.addKeyframeWithRelativeStartTime(1.0 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnFacebook.alpha = 0.0
//                self.btnForget.alpha = 0.0
//            })
//            UIView.addKeyframeWithRelativeStartTime(1.1 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnLogin.alpha = 0.0
//            })
//            UIView.addKeyframeWithRelativeStartTime(1.2 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnRegister.alpha = 0.0
//            })
            }, completion: {finished in
                // any code entered here will be applied
                // once the animation has completed
                self.performSegue(withIdentifier: "RegisterViewController", sender: nil)
        })
    }
    
    @IBAction func ForgotPasswordBtnPressed()
    {
        UIView.animateKeyframes(withDuration: 1.15, delay: 0.0, options: UIViewKeyframeAnimationOptions(),animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            UIView.addKeyframe(withRelativeStartTime: 0 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnFacebook.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.05 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnForget.transform = CGAffineTransform(translationX: 0, y: 350)
                self.lblForget.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnLogin.transform = CGAffineTransform(translationX: 0, y: 350)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.15 / 1.15, relativeDuration: 1.0 / 1.15, animations: {
                self.btnRegister.transform = CGAffineTransform(translationX: 0, y: 350)
            })
//            UIView.addKeyframeWithRelativeStartTime(1.0 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnFacebook.alpha = 0.0
//                self.btnForget.alpha = 0.0
//            })
//            UIView.addKeyframeWithRelativeStartTime(1.1 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnLogin.alpha = 0.0
//            })
//            UIView.addKeyframeWithRelativeStartTime(1.2 / 2.0, relativeDuration: 0.8 / 0.6, animations: {
//                self.btnRegister.alpha = 0.0
//            })
            }, completion: {finished in
                // any code entered here will be applied
                // once the animation has completed
                self.performSegue(withIdentifier: "ForgotPasswordViewController", sender: nil)
        })
        
    }
    
    //MARK:- service HandShake
    func CallHandShake()
    {
        showLoading()
        MyJSONParser.object(withUrlString: "\(URL)?case=hs&p1=mazinger5596&p2=CaptenMaged5_0&p3=Mazinger_1169&p4=Denam0_9987&p5=Dokfleed_3320", responseDelegate: self, responseSelector: #selector(LandingViewController.HandShakeCallbk(_:)))
    }
    
    func HandShakeCallbk(_ dict : [String : AnyObject])
    {
        if let errorStatus = dict["Msg"] as? String
        {
            if errorStatus == "0"
            {
                if let data = dict["Data"] as? [AnyObject]
                {
                    if let dataObject = data[0] as? [String : AnyObject]
                    {
                        Token = dataObject["si"] as! String
                        CallLogin()
                    }
                }
            }
            else if errorStatus == "-1"
            {
                print("Unauthorized access")
                let alert = UIAlertController(title: NSLocalizedString("denied", comment: ""), message: NSLocalizedString("unauthorizedAccess", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("error while making handshake")
                let alert = UIAlertController(title: "Error", message: NSLocalizedString("denied", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                    // call service again
                    self.CallHandShake()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            print("no internet")
            let alert = UIAlertController(title: NSLocalizedString("connectionError", comment: ""), message: NSLocalizedString("internetError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                // call service again
                self.CallHandShake()
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- service Login
    func CallLogin()
    {
//        MyJSONParser.objectWithUrlString("\(URL)?case=lg&usr=gketa_77@yahoo.com&pwd=open&si=\(Token)", responseDelegate: self, responseSelector: #selector(LoginViewController.LoginCallbk(_:)))
        MyJSONParser.object(withUrlString: "\(URL)?case=lg&usr=\(self.txtName.text!)&pwd=\(self.txtPass.text!)&si=\(Token)", responseDelegate: self, responseSelector: #selector(LandingViewController.LoginCallbk(_:)))
    }
    
    func LoginCallbk(_ dict : [String : AnyObject])
    {
        print("ok")
        hideLoading()
        if let errorStatus = dict["Msg"] as? String
        {
            if errorStatus == "0"
            {
                if let data = dict["Data"] as? [AnyObject]
                {
                    if let dataObject = data[0] as? [String : AnyObject]
                    {
                        // store credentials to Gloabals
                        userFName = dataObject["MFstName"] as! String
                        userLName = dataObject["MLstName"] as! String
                        userPass = dataObject["PWD"] as! String
                        userID = dataObject["MemberID_PK"] as! String
                        
                        // push main vc
                        //                        self.performSegueWithIdentifier("HomeViewController", sender: nil)
                        
                        // set homeNav and side menu as root to window
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        let homeNav = self.storyboard?.instantiateViewController(withIdentifier: "InspireNav")
                        let sideVc = self.storyboard?.instantiateViewController(withIdentifier: "SideViewController")
                        
                        let containerVC = MFSideMenuContainerViewController.container(withCenter: homeNav, leftMenuViewController: sideVc, rightMenuViewController: nil)
                        containerVC?.panMode = MFSideMenuPanModeNone;
                        delegate?.window?.rootViewController = containerVC
                        
                    }
                }
            }
            else if errorStatus == "-1"
            {
                print("wrong username or pass")
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("nameOrPassError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("error while login")
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("nameOrPassError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            print("no internet")
            let alert = UIAlertController(title: NSLocalizedString("connectionError", comment: ""), message: NSLocalizedString("internetError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                // call service again
                self.CallLogin()
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
                connection.add(GraphRequest(graphPath: "/me" , parameters: ["fields": "name,email,first_name,last_name,picture.type(small),gender"])) { httpResponse, result in
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


    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "RegisterViewController"
        {
            
        }
    }
}


