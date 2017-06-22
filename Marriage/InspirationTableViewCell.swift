//
//  InspirationTableViewCell.swift
//  Marriage
//
//  Created by ZooZoo on 7/25/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit

class InspirationTableViewCell: UITableViewCell {

    @IBOutlet var lblNumberViews: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgPhoto: AsyncImageView!
    @IBOutlet var imgFavourate: UIImageView!
    @IBOutlet var lblDate: UILabel!
//    @IBOutlet var lblNumberLikes: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadCellWithDict(_ dict : [String : AnyObject] , isDetails: Bool)
    {
        if isDetails == false
        {
            self.lblTitle.text = dict["ArtSubject2"] as? String
            self.lblNumberViews.text = (dict["ArtViewCount"] as? String)! + " " + "Views"
            self.lblDate.text = dict["ArtEnt_Dt"] as? String
            self.lblDescription.text = dict["ArtDesc2"] as? String
            let tempURL : String = URLArticleImages + (dict["ArtSubject"]! as! String) + " " + (dict["ArtImgName"]! as! String) + " " + (dict["ArtDetImgID_PK"]! as! String) + ".jpg"
            var imgURL = tempURL.replacingOccurrences(of: " ", with: "-")
            imgURL = imgURL.lowercased()
            self.imgPhoto.imageURL = Foundation.URL(string: imgURL)
        }
        else
        {
            self.lblTitle.text = dict["ArtSubject2"] as? String
//            self.lblNumberViews.text = (dict["ArtViewCount"] as? String)! + " " + "Views"
            self.lblDate.text = dict["ArtEnt_Dt"] as? String
            self.lblDescription.text = dict["ArtDesc2"] as? String
            let tempURL : String = URLArticleImages + (dict["ArtSubject"]! as! String) + " " + (dict["ArtImgName"]! as! String) + " " + (dict["ArtDetImgID_PK"]! as! String) + ".jpg"
            var imgURL = tempURL.replacingOccurrences(of: " ", with: "-")
            imgURL = imgURL.lowercased()
            self.imgPhoto.imageURL = Foundation.URL(string: imgURL)
        }
        // return is favourated or not
        // return number of likes
        
    }
}
