//
//  DetailsTableViewCell.swift
//  Marriage
//
//  Created by ZooZoo on 8/14/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import UIKit
import CoreText

class DetailsTableViewCell: UITableViewCell , UIWebViewDelegate {
    
    @IBOutlet var lblDetail: UILabel!
    @IBOutlet var imgDetail: AsyncImageView!
    @IBOutlet var web : UIWebView!
    var delegate : DetailsProtocol?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellWithDict(_ dict : [String : AnyObject] , detail : [String : AnyObject])
    {
        self.lblDetail.text = detail["ArtTxtValue"] as? String
        self.lblDetail.sizeToFit()
        self.web.isHidden = true
        self.web.scrollView.isScrollEnabled = false
        self.web.scrollView.bounces = false
        if let caseStr = detail["ArtLnTypID_FK"] as? String
        {
            if caseStr == "I"
            {
                let tempURL : String = URLArticleImages + (dict["ArtSubject"]! as! String) + " " + (detail["ArtImgName"]! as! String) + " " + (detail["ArtDetImgID_PK"]! as! String) + ".jpg"
                var imgURL = tempURL.replacingOccurrences(of: " ", with: "-")
                imgURL = imgURL.lowercased()
                self.imgDetail.imageURL = Foundation.URL(string: imgURL)
                self.web.isHidden = true
            }
            else if caseStr == "T"
            {
//                self.imgDetail.removeFromSuperview()
                if detail["ArtTxtTypID_FK"] as? String == "H"
                {
                    self.web.isHidden = false
                    self.lblDetail.isHidden = true
                    self.web.loadHTMLString((detail["ArtTxtValue"] as? String)!, baseURL: nil)
//                    self.web.sizeToFit()
                    
                }
                else
                {
                    self.web.isHidden = true
                    self.lblDetail.isHidden = false
                }
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.isScrollEnabled = false
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
//        self.reloadInputViews()
//        delegate!.updateTableView()
    }

}
