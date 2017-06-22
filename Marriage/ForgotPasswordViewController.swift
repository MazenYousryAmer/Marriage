//
//  ForgotPasswordViewController.swift
//  Marriage
//
//  Created by ZooZoo on 6/10/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: ParentViewController {

    @IBOutlet var txtMail :UITextField!
    
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
    @IBAction func forgotPassBtnPressed()
    {
        if self.txtMail.text == ""
        {
            print("no txt")
        }
        else
        {
            CallForgot()
        }
    }
    
    //MARK:- call forgot service
    func CallForgot()
    {
        MyJSONParser.object(withUrlString: "\(URL)?case=fgp&em=gketa_77@yahoo.com&si=\(Token)", responseDelegate: self, responseSelector: #selector(ForgotPasswordViewController.ForgotCallbk(_:)))
        
    }
    
    func ForgotCallbk(_ dict : [String : AnyObject])
    {
        if let errorStatus = dict["Msg"] as? String
        {
            if errorStatus == "8"
            {
                let alert = UIAlertController(title: "Success", message: "Email has been sent to the provided address", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                    // remove screen from navigation on click
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if errorStatus == "7"
            {
                let alert = UIAlertController(title: "Error", message: "The provided Email is not registered", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            // no connection
            let alert = UIAlertController(title: "Error", message: "no internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
