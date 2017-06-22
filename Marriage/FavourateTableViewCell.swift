//
//  FavourateTableViewCell.swift
//  Marriage
//
//  Created by ZooZoo on 1/7/17.
//  Copyright © 2017 ZooZoo. All rights reserved.
//

import UIKit

class FavourateTableViewCell: UITableViewCell {

    @IBOutlet var imgFav :AsyncImageView!
    @IBOutlet var lblFav :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellWithDict(_ dict : [String : AnyObject])
    {
        self.lblFav.text = dict["ArtSubject2"] as? String
        let tempURL : String = URLArticleImages + (dict["ArtSubject"]! as! String) + " " + (dict["ArtImgName"]! as! String) + " " + (dict["ArtDetImgID_PK"]! as! String) + ".jpg"
        var imgURL = tempURL.replacingOccurrences(of: " ", with: "-")
        imgURL = imgURL.lowercased()
        self.imgFav.imageURL = Foundation.URL(string: imgURL)
    }

}
