//
//  TabbedBarViewController.swift
//  Marriage
//
//  Created by ZooZoo on 12/20/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class TabbedBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = NSLocalizedString("inspire", comment: "")
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //AMRK: - tab bar
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        if item.title == "Inspire"
        {
            self.navigationItem.title = NSLocalizedString("inspire", comment: "")
//            self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: nil, action: nil)
        }
        else if item.title == "Favourate"
        {
            self.navigationItem.title = NSLocalizedString("favourate", comment: "")
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
