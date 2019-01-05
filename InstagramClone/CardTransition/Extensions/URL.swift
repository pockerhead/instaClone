//
//  URL.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import Foundation

extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        if let queryItems = components.queryItems {
            var parameters = [String: String]()
            for item in queryItems {
                parameters[item.name] = item.value
            }
            return parameters

        } else if let fragment = components.fragment {
            var parameters = [String: String]()
            var fragmentSplitted = fragment.split(separator: "=")
            let endIndex = (fragmentSplitted.count / 2) % 2 == 0 ? fragmentSplitted.count / 2 : (fragmentSplitted.count / 2) - 1
            (0...endIndex).forEach { index in
                let neededIndex = index * 2
                parameters[String(fragmentSplitted[neededIndex])] = String(fragmentSplitted[neededIndex + 1])
            }
            return parameters
        } else {
            return nil
        }
    }
}
