//
//  RegisterViewController.swift
//  Marriage
//
//  Created by ZooZoo on 5/20/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class RegisterViewController: ParentViewController {

    //MARK:- IBOutlets
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBOutlet var txtMail: UITextField!
    
    //MARK:- view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // show navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- ibactions
    @IBAction func registerBtnPressed()
    {
        // name validation
        if txtName.text == ""
        {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("registerNameError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            // pass validation
        else if txtPass.text == ""
        {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("registerPassError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if txtMail.text == ""
        {
            let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("registerMailError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            // success
        else
        {
            // check if there is a token
            if Token == ""
            {
                CallHandShake()
            }
            else
            {
                self.showLoading()
                self.CallRegister()
            }
            
        }
    }
    
    //MARK:- service HandShake
    func CallHandShake()
    {
        showLoading()
        MyJSONParser.object(withUrlString: "\(URL)?case=hs&p1=mazinger5596&p2=CaptenMaged5_0&p3=Mazinger_1169&p4=Denam0_9987&p5=Dokfleed_3320", responseDelegate: self, responseSelector: #selector(RegisterViewController.HandShakeCallbk(_:)))
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
                        CallRegister()
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

    
    //MARK: - Service Register
    func CallRegister()
    {
//        MyJSONParser .objectWithUrlString("\(URL)?case=nrg&fname=goergy&em=gketa_77@yahoo.com&pwd=open&si=\(Token)", responseDelegate: self, responseSelector: #selector(RegisterViewController.RegisterCallbk(_:)))
         MyJSONParser .object(withUrlString: "\(URL)?case=nrg&fname=\(self.txtName.text!)&em=\(self.txtMail.text!)&pwd=\(self.txtPass.text!)&si=\(Token)", responseDelegate: self, responseSelector: #selector(RegisterViewController.RegisterCallbk(_:)))
    }
    
    func RegisterCallbk(_ dict : [String : AnyObject])
    {
        print("ok")
        if let errorStatus = dict["Msg"] as? String
        {
            if errorStatus == "5"
            {
                let alert = UIAlertController(title: NSLocalizedString("success", comment: ""), message: NSLocalizedString("registerSuccess", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: {_ in self.CallLogin() }))
                self.present(alert, animated: true, completion: nil)

            }
            else if errorStatus == "-4"
            {
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("existError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if errorStatus == "-6"
            {
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("unknownError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:- service Login
    func CallLogin()
    {
        //        MyJSONParser.objectWithUrlString("\(URL)?case=lg&usr=gketa_77@yahoo.com&pwd=open&si=\(Token)", responseDelegate: self, responseSelector: #selector(LoginViewController.LoginCallbk(_:)))
        MyJSONParser.object(withUrlString: "\(URL)?case=lg&usr=\(self.txtMail.text!)&pwd=\(self.txtPass.text!)&si=\(Token)", responseDelegate: self, responseSelector: #selector(RegisterViewController.LoginCallbk(_:)))
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
    

}
