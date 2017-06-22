//
//  FavourateViewController.swift
//  Marriage
//
//  Created by ZooZoo on 8/17/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class FavourateViewController: ParentViewController , UITableViewDelegate , UITableViewDataSource{

    //MARK: - iboutlets
    @IBOutlet var tableFavourate: UITableView!
    
    //MARK: - variable
    var arrFavourate = [[String : AnyObject]]()
    var selectedItem : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callFavourateList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - call Favourate service
    func callFavourateList()
    {
         MyJSONParser.object(withUrlString: "\(URL)?case=lfa&sec=1&id=\(userID)&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(FavourateViewController.favouratelistCallbk(_:)))
//        http://164.160.104.7/ma2z_php/shop/rest/get_data_app.php?case=lfa&id=1&sec=1&lng=1&si=606401b11f54e8d67c460c3096bfec21
    }
    
    func favouratelistCallbk(_ dict : [String : AnyObject])
    {
        print(dict)
        if let errorCode = dict["Msg"] as? String
        {
            if errorCode == "0"
            {
                self.arrFavourate = dict["Data"] as! [[String : AnyObject]]
                self.tableFavourate.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrFavourate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavourateCell") as! FavourateTableViewCell
        let tempDic = self.arrFavourate[indexPath.row]
        cell.loadCellWithDict(tempDic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectedItem = indexPath.row
        self.performSegue(withIdentifier: "InspirationDetailsViewController", sender: nil)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "InspirationDetailsViewController"
        {
            if let vc = segue.destination as? InspirationDetailsViewController
            {
                vc.dictItem = self.arrFavourate[self.selectedItem!]
                vc.isFromFav = true
            }
        }
    }

}
