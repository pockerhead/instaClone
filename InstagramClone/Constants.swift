//
//  constantst.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation

let redirectURI = "https://api.com"
let instagramURL = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=7556fb162bd24540a151959ad10ab045&redirect_uri=\(redirectURI)&response_type=token")!

var APItoken: String? {
    get {
        return UserDefaults.standard.string(forKey: "token")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "token")
    }
}
