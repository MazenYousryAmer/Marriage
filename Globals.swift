//
//  Globals.swift
//  Marriage
//
//  Created by ZooZoo on 5/20/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import Foundation

// MARK: - user
var userFName : String = ""
var userLName : String = ""
var userPass : String = ""
var userImage : String = ""
var userID : String = ""
var Token : String = ""

//MARK: - colors
var pinkColor = UIColor(red: 253.0/255/0, green: 114.0/255.0, blue: 174.0/255.0, alpha: 0.7)

//MARK: - URL
//var URL : String = "http://41.128.145.121/ma2z_php/shop/rest/get_data_app.php"
var URL : String = "http://164.160.104.7/ma2z_php/shop/rest/get_data_app.php"
var URLArticleImages = "http://164.160.104.7/ma2z_php/shop/wedding/images/articles/"
//var URLArticleImages = "http://41.128.145.121/ma2z_php/shop/wedding/images/articles/"
var language : String = ""
var languageID : Int
{
   get {
    if language == "English"
    {
        return 1
    }
    else if language == "Arabic"
    {
        return 2
    }
    return 3
}
}




