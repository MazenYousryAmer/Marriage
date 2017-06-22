//
//  DetailedImageViewController.swift
//  Marriage
//
//  Created by ZooZoo on 1/8/17.
//  Copyright © 2017 ZooZoo. All rights reserved.
//

import UIKit

class DetailedImageViewController: ParentViewController {

    //MARK: - iboutlets
    @IBOutlet var imgDetail : AsyncImageView!
    
    //MARK: - variables
    var dictItem = [String : AnyObject]()
    var arrDetails = [[String : AnyObject]]()
    var selectedItem : Int?
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let tempDict = self.arrDetails[self.selectedItem!]
        let tempURL : String = URLArticleImages + (self.dictItem["ArtSubject"]! as! String) + " " + (tempDict["ArtImgName"]! as! String) + " " + (tempDict["ArtDetImgID_PK"]! as! String) + ".jpg"
        var imgURL = tempURL.replacingOccurrences(of: " ", with: "-")
        imgURL = imgURL.lowercased()
        self.imgDetail.imageURL = Foundation.URL(string: imgURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
