//
//  InspirationViewController.swift
//  Marriage
//
//  Created by ZooZoo on 7/25/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class InspirationViewController: ParentViewController , UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate , UICollectionViewDelegate , UICollectionViewDataSource{

    //MARK: - iboutlets
    @IBOutlet var tableInspire : UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var CollectionSections: UICollectionView!
    @IBOutlet var lblError: UILabel!
    
    //MARK: - variables
    var arrInspire = [[String : AnyObject]]()
    var filterInspire = [[String : AnyObject]]()
    var arrSections = [[String : AnyObject]]()
    var arrFavourate = [String]()
    var selectedItem : Int?
    var canShowSearch : Bool = false
    var isSearching : Bool = false
    var selectedSectionID = "1"
    
    //MARK: - view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.menuContainerViewController.panMode = MFSideMenuPanModeNone
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(InspirationViewController.searchBtnPressed))
        
        //side search bar
        self.canShowSearch = false
//        self.searchBar.alpha = 0.0
        self.tableInspire.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
        self.isSearching = false
        
        if Token != ""
        {
            CallInspirationSections()
//            CallInspirationListing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - ibactions
    @IBAction func MenuBtnPressed()
    {
//        self.menuContainerViewController .toggleLeftSideMenuCompletion(nil)
        self.performSegue(withIdentifier: "FavourateViewController", sender: nil)
    }
    
    @IBAction func SignOutBtnPressed()
    {
        userFName = ""
        userLName = ""
        userPass = ""
        userID = ""
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let landingVC = self.storyboard?.instantiateInitialViewController()
        delegate?.window?.rootViewController = landingVC
    }
    
    @IBAction func searchBtnPressed()
    {
        if self.canShowSearch
        {
            self.tableInspire.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
        }
        else
        {
            self.tableInspire.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        self.canShowSearch = !self.canShowSearch
    }
    
    //MARK: - Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionItem", for: indexPath) as! InspirationCollectionViewCell
        let tempDict = self.arrSections[indexPath.row]
        item.lblSection.text = tempDict["ArtCatName"] as? String
        item.SectionID = tempDict["ArtCatID_PK"] as? String
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let tempDict = self.arrSections[indexPath.row]
        self.selectedSectionID = tempDict["ArtCatID_PK"] as! String
        CallInspirationListing()
    }
    
    //MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.isSearching
        {
            return self.filterInspire.count
        }
       return self.arrInspire.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InspireCell") as! InspirationTableViewCell
        if self.isSearching
        {
            cell.loadCellWithDict(self.filterInspire[indexPath.row],isDetails: false)
            let tempDic = self.filterInspire[indexPath.row]
            if let strID = tempDic["ArtID_FK"] as? String
            {
                if self.arrFavourate.contains(strID)
                {
                    cell.imgFavourate.image = UIImage(named:"IconFavourateFill")
                }
                else
                {
                    cell.imgFavourate.image = UIImage(named:"IconFavorate")
                }
            }
            return cell
        }
        cell.loadCellWithDict(self.arrInspire[indexPath.row],isDetails: false)
        
        let tempDic = self.arrInspire[indexPath.row]
        if let strID = tempDic["ArtID_FK"] as? String
        {
            if self.arrFavourate.contains(strID)
            {
                cell.imgFavourate.image = UIImage(named:"IconFavourateFill")
            }
            else
            {
                cell.imgFavourate.image = UIImage(named:"IconFavorate")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 380
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selectedItem = indexPath.row
        self.performSegue(withIdentifier: "InspirationDetailsViewController", sender: nil)
    }
    
    //MARK: - Service Inspiration Horizontal Listing
    func CallInspirationSections()
    {
        showLoading()
        MyJSONParser.object(withUrlString: "\(URL)?case=gamc&sec=1&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationViewController.InspirationSectionsCallbk(_:)))
    }
    func InspirationSectionsCallbk(_ dict : [String : AnyObject])
    {
        print(dict)
        if let data = dict["Data"] as? [[String : AnyObject]]
        {
            self.arrSections = data
            self.CollectionSections.reloadData()

            callFavourateList()
        }
    }
    
    //MARK: - call Favourate service
    func callFavourateList()
    {
        MyJSONParser.object(withUrlString: "\(URL)?case=lfa&sec=1&id=\(userID)&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationViewController.favouratelistCallbk(_:)))
        //        http://164.160.104.7/ma2z_php/shop/rest/get_data_app.php?case=lfa&id=1&sec=1&lng=1&si=606401b11f54e8d67c460c3096bfec21
    }
    
    func favouratelistCallbk(_ dict : [String : AnyObject])
    {
        print(dict)
        if let errorCode = dict["Msg"] as? String
        {
            if errorCode == "0"
            {
                let arrFav = dict["Data"] as? [[String : AnyObject]]
                if arrFav?.count != 0 && arrFav?.count != nil
                {
                    for entry in arrFav!
                    {
                        if let strID = entry["ArtID_PK"] as? String
                        {
                            self.arrFavourate.append(strID)
                        }
                    }
                }
//                self.tableFavourate.reloadData()
            }
        }
        CallInspirationListing()
    }
    
    //MARK: - Service Inspiration Listing
    func CallInspirationListing()
    {
        MyJSONParser.object(withUrlString: "\(URL)?case=apl&sec=\(self.selectedSectionID)&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationViewController.InspirationListingCallbk(_:)))
    }
    
    func InspirationListingCallbk(_ dict : [String : AnyObject])
    {
        print(dict)
        hideLoading()
        if let data = dict["Data"] as? [[String : AnyObject]]
        {
            self.arrInspire = data
            self.lblError.isHidden = true
            self.tableInspire.reloadData()
        }
        else
        {
            self.tableInspire.isHidden = true
            self.lblError.isHidden = false
        }
    }
    
    //MARK: - search
    func filterContentForSearchText(_ searchText: String)
    {
        if searchText == ""
        {
            self.isSearching = false
        }
        else
        {
            self.filterInspire = self.arrInspire.filter { article in
                return article["ArtSubject2"]!.lowercased.contains(searchText.lowercased())
            }
        }
        
        self.tableInspire.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        self.isSearching = false
        self.searchBar.text = ""
        self.tableInspire.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == ""
        {
            self.isSearching = false
            self.tableInspire.reloadData()
        }
        else
        {
            self.isSearching = true
            self.filterContentForSearchText(searchText)
        }
    }
    
//    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
//    {
//        self.isSearching = true
//        self.filterContentForSearchText(text)
//        return true
//    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "InspirationDetailsViewController"
        {
            if let vc = segue.destination as? InspirationDetailsViewController
            {
                if self.isSearching
                {
                    vc.dictItem = self.filterInspire[self.selectedItem!]
                }
                else
                {
                    vc.dictItem = self.arrInspire[self.selectedItem!]
                }
                vc.isFromFav = false
            }
        }
    }
}
