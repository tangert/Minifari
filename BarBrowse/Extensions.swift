//
//  Extensions.swift
//  BarBrowse
//
//  Created by Tyler Angert on 4/27/17.
//  Copyright © 2017 Tyler Angert. All rights reserved.
//

import Foundation
import Cocoa

extension String {
    
    //describes the string in URL format
    var URL_desc: URL {
        return URL(string: self)!
    }
    
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }

    //returns back a formatted URL
    var formattedURL: URL {
        if((self.contains("https://") ||
            self.contains("http://")) &&
            !self.contains(" ")) {
            return self.URL_desc
        }
            
        else if (self.contains(".") && !self.contains(" ")) {
            let formatted = "https://\(self)"
            return formatted.URL_desc
        }
            
        else {
            let query = self.replacingOccurrences(of: " ", with: "+")
            let search = "https://www.google.com/#q=\(query)"
            return search.URL_desc
        }
    }
}
