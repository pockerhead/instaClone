//
//  InstaMedia.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation
import Marshal

struct InstaMedia: Unmarshaling {
    
    var images: Images?
    var comentsCount: Int?
    var likesCount: Int?
    var caption: Caption?
    
    init(object json: MarshaledObject) throws {
        images = try? json.value(for: "images")
        caption = try? json.value(for: "caption")
        let dict = json as! [String: Any]
        if let comments = dict["comments"] as? [String: Any] {
            comentsCount = try? comments.value(for: "count")
        }
        if let likes = dict["likes"] as? [String: Any] {
            likesCount = try? likes.value(for: "count")
        }
    }
    
    
}

struct Images: Unmarshaling {
    
    var lowRes: Image?
    var thumbnail: Image?
    var standardRes: Image?
    
    init(object json: MarshaledObject) throws {
        lowRes = try? json.value(for: "low_resolution")
        thumbnail = try? json.value(for: "thumbnail")
        standardRes = try? json.value(for: "standard_resolution")
        
    }
    
}

struct Image: Unmarshaling {
    
    var url: String?
    var width: Float?
    var height: Float?
    var ratio: Float?
    
    init(object json: MarshaledObject) throws {
        url = try? json.value(for: "url")
        width = try? json.value(for: "width")
        height = try? json.value(for: "height")
        if let width = width, let height = height {
            ratio = height / width
        }
    }
    
    
}

struct Caption: Unmarshaling {
    
    var text: String?
    var createdTime: TimeInterval?
    
    init(object json: MarshaledObject) throws {
        text = try? json.value(for: "text")
        let createdTimeInt: String? = try? json.value(for: "created_time")
        createdTime = TimeInterval(createdTimeInt ?? "")
    }
}
