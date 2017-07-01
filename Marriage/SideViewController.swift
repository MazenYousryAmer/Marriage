//
//  SideViewController.swift
//  Marriage
//
//  Created by ZooZoo on 6/17/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class SideViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    //MARK: - iboutlets
    @IBOutlet var tableMenu : UITableView!
    @IBOutlet var lblWelcome : UILabel!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var imgProfile : UIImageView!
    
    //MARK: - variables
//    var arrMenuTxt : [String] = ["Home" , "Check List" , "Budget List" , "Guest List" , "Settings"]
//    var arrMenuImg : [String] = ["IconHome" , "IconCheckList" , "IconBudgetList" , "IconGuestList" , "IconSettings"]
    var arrMenuTxt : [String] = ["DRESSES" , "RINGS" , "WEDDING PLANNING" , "HONEY MOONS" , "INSPIRATIONS" , "MY FAVOURITES" , "SETTINGS"]
    var indexSelected : Int? = 0
    
    //MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set name
        self.lblWelcome.text = NSLocalizedString("welcome", comment: "")
        self.lblName.text = userFName + " " + userLName
        
        if userImage == ""
        {
            self.imgProfile.image = UIImage(named: "IconDefault")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrMenuTxt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! SideMenuTableViewCell
        cell.lblMenu.text = self.arrMenuTxt[indexPath.row]
//        cell.imgMenu.image = UIImage(named: self.arrMenuImg[indexPath.row])
        if (self.indexSelected == indexPath.row)
        {
            UIView.animate(withDuration: 0.5, animations: {
                cell.viewMenu.backgroundColor = pinkColor
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                cell.viewMenu.backgroundColor = UIColor.white
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexSelected = nil
        UIView.animate(withDuration: 0, animations: {
            self.tableMenu.reloadData()
        }, completion: {_ in
            self.indexSelected = indexPath.row
            self.tableMenu.reloadData()
        })    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
