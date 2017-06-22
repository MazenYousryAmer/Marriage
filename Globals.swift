//
//  Globals.swift
//  Marriage
//
//  Created by ZooZoo on 5/20/16.
//  Copyright © 2016 ZooZoo. All rights reserved.
//

import Foundation

var userFName : String = ""
var userLName : String = ""
var userPass : String = ""
var userImage : String = ""
var userID : String = ""
var Token : String = ""

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




