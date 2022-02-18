//
//  Data.swift
//  AddContact
//
//  Created by Coditas on 14/02/22.
//

import Foundation

struct Contact {
    var basicDetails : [basicDetails]
    //var addPhone : [String]
    //var addEmail : [String]
    //var addAddress : [String]
}

struct basicDetails {
    var firstName : String = ""
    var lastName : String = ""
    var Gender : String = ""
    var Age : String = ""
    var height : String = ""
}


struct buttonCategories {
    var index : String
}
var phoneNumberOf = ["mobile","home","work","school","iPhone","main","home fax","work fax","pager","other"]
var emailIdOf = ["home","Work","School","iCloud","other"]
var addressOf = ["home","work","school","other"]
var insertData = ["Add custom Label"]


var placeHolderForTxtF = ["First name","Last Name","Gender","Age","Height"]
var addPhone = ["add Phone"]
var addEmail = ["add Email"]
var addAddress = ["add Address"]

var sectionsToprint = [buttonCategories]()



