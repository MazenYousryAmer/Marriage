//
//  InspirationDetailsViewController.swift
//  Marriage
//
//  Created by ZooZoo on 8/14/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class InspirationDetailsViewController: ParentViewController , UITableViewDataSource , UITableViewDelegate, DetailsProtocol {

    @IBOutlet var tableDetails: UITableView!
    
    var dictItem = [String : AnyObject]()
    var arrDetails = [[String : AnyObject]]()
    var isFromFav : Bool?
    var selectedItem : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // call service
        self.CallInspirationDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDetails.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InspireCell") as! InspirationTableViewCell
            cell.loadCellWithDict(self.dictItem,isDetails: true)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsTableViewCell!
//        cell.delegate = self
        cell?.loadCellWithDict(self.dictItem , detail: self.arrDetails[indexPath.row - 1])
//        cell.lblDetail.text = self.arrDetails[indexPath.row - 1]["ArtTxtValue"] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InspireCell") as! InspirationTableViewCell
            cell.loadCellWithDict(self.dictItem,isDetails: true)
            cell.lblDescription.sizeToFit()
            return cell.lblDescription.frame.height + 300
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsTableViewCell!
//        cell.delegate = self
//        cell.delegate = self
        cell?.loadCellWithDict(self.dictItem , detail: self.arrDetails[indexPath.row - 1])
        
//        let det = self.arrDetails[indexPath.row - 1]
//        let tempURL : String = URLArticleImages + (self.dictItem["ArtSubject"]! as! String) + " " + (det["ArtImgName"]! as! String) + " " + (det["ArtDetImgID_PK"]! as! String) + ".jpg"
//        var imgURL = tempURL.stringByReplacingOccurrencesOfString(" ", withString: "-")
//        imgURL = imgURL.lowercaseString
        let img = cell?.imgDetail.image
        if img != nil
        {
            let imgHeight = img?.size.height
            let imgWidth = img?.size.width
            cell?.imgDetail.frame = CGRect(x: (cell?.imgDetail.frame.origin.x)!, y: (cell?.imgDetail.frame.origin.y)!, width: (cell?.imgDetail.frame.size.width)!, height: CGFloat(Int((imgHeight! * (cell?.imgDetail.frame.size.width)!) / imgWidth!)))
            //            print(cell.imgDetail.frame.origin.x)
        }else {
            cell?.imgDetail.frame = CGRect(x: (cell?.imgDetail.frame.origin.x)!, y: (cell?.imgDetail.frame.origin.y)!, width: (cell?.imgDetail.frame.size.width)!, height: 0)
        }
        
        cell?.lblDetail.sizeToFit()
        cell?.web.sizeToFit()
        let tempDic = self.arrDetails[indexPath.row - 1]
        
        if tempDic["ArtLnTypID_FK"] as? String == "T"
        {
            if tempDic["ArtTxtTypID_FK"] as? String == "H"
            {
                return cell!.lblDetail.frame.height + cell!.imgDetail.frame.height
            }
            return cell!.lblDetail.frame.height + cell!.imgDetail.frame.height
        }
//        return cell.lblDetail.frame.height + cell.imgDetail.frame.size.height + 40
        return cell!.imgDetail.frame.size.height + 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        return self.arrDetails.count + 1
        let tempDict = self.arrDetails[indexPath.row + 1]
        if tempDict["ArtLnTypID_FK"] as? String != "T"
        {
            self.selectedItem = indexPath.row
            self.performSegue(withIdentifier: "DetailedImageViewController", sender: nil)
        }
    }
    
    func updateTableView() {
        self.tableDetails.beginUpdates()
        self.tableDetails.endUpdates()
//        self.tableDetails.reloadData()
    }
    
    //MARK: - Service Inspiration Listing
    func CallInspirationDetails()
    {
        if self.isFromFav == false
        {
            MyJSONParser.object(withUrlString: "\(URL)?case=ard&id=\(self.dictItem["ArtID_FK"]!)&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationDetailsViewController.InspirationDetailsCallbk(_:)))
        }
        else
        {
            MyJSONParser.object(withUrlString: "\(URL)?case=ard&id=\(self.dictItem["ArtID_PK"]!)&lng=\(languageID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationDetailsViewController.InspirationDetailsCallbk(_:)))
        }
    }
    
    func InspirationDetailsCallbk(_ dict : [String : AnyObject])
    {
        print(dict)
        if dict["Msg"] as? String == "0"
        {
            if let data = dict["Data"] as? [[String : AnyObject]]
            {
                self.arrDetails = data
                self.tableDetails.reloadData()
            }
        }
        else
        {
            //error
        }
    }
    
    //MARK: - ibaction
    @IBAction func shareBtnPressed(_ sender: AnyObject)
    {
        let firstActivityItem = self.dictItem["ArtSubject2"]
//        let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
//        // If you want to put an image
//        let image : UIImage = UIImage(named: "image.jpg")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func favourateBtnPressed()
    {
        MyJSONParser.object(withUrlString: "\(URL)?case=afa&ar=\(self.dictItem["ArtID_FK"]!)&id=\(userID)&si=\(Token)", responseDelegate: self, responseSelector: #selector(InspirationDetailsViewController.favourateCallbk(_:)))
    }
    
    //MARK: - favourate call back
    func favourateCallbk(_ dict : [String : AnyObject])
    {
        if let errorCode = dict["Msg"] as? String
        {
            if errorCode == "11"
            {
                print("added")
                let alert = UIAlertController(title: NSLocalizedString("success", comment: ""), message: NSLocalizedString("added", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else if errorCode == "-9"
            {
                print("already exists")
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("exist", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("added")
                let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("unknown", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DetailedImageViewController"
        {
            if let vc = segue.destination as? DetailedImageViewController
            {
                vc.dictItem = self.dictItem
                vc.arrDetails = self.arrDetails
                vc.selectedItem = self.selectedItem! - 1
            }
        }
    }

}
