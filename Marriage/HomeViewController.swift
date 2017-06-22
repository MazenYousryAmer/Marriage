//
//  HomeViewController.swift
//  Marriage
//
//  Created by ZooZoo on 6/15/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet var tableHome : UITableView!
    var arrCategories : Array<Dictionary<String,String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if Token != ""
        {
            CallCategoryListing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ibactions
    @IBAction func MenuBtnPressed()
    {
        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
    }
    
    //MARKL - service Category Listing
    func CallCategoryListing()
    {
        MyJSONParser.object(withUrlString: "\(URL)?case=ctl&sec=1&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(HomeViewController.CategoryListingCallbk(_:)))
    }
    
    func CategoryListingCallbk(_ dict : [String : AnyObject])
    {
        if let dataObjects = dict["Data"] as? [AnyObject]
        {
            var tempDic = [String : String]()
            for object in dataObjects
            {
                tempDic["CategoryName"] = object["ItmCatName2"] as? String
                tempDic["CatgoryID"] = object["ItmCatID_PK"] as? String
                self.arrCategories.append(tempDic)
                tempDic = [:]
            }
            self.tableHome.reloadData()
        }
        else
        {
            // error in connection
            print("no internet")
            let alert = UIAlertController(title: NSLocalizedString("connectionError", comment: ""), message: NSLocalizedString("internetError", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                // call service again
                self.CallCategoryListing()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        print(indexPath.row)
        let cell = tableView .dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        let dataObject = self.arrCategories[indexPath.row]
        print(dataObject["CategoryName"])
        print(dataObject["CategoryID"])
        cell.lblHome.text = dataObject["CategoryName"]
        let tempURL : String = "http://41.128.145.121/ma2z_php/shop/wedding/images/items-categories/\(dataObject["CategoryName"]!)-\(dataObject["CatgoryID"]!).jpg"
        var catURL = tempURL.replacingOccurrences(of: " ", with: "-")
        catURL = catURL.lowercased()
        cell.imgHome.imageURL = Foundation.URL(string: catURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
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
