//
//  NSView.swift
//  DLab
//
//  Created by Rodney Dyer on 11/12/18.
//  Copyright © 2018 Rodney Dyer. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
    
    static func loadFromNib(nibName: String, owner: Any?) -> NSView? {
        
        var arrayWithObjects: NSArray?
        
        let nibLoaded = Bundle.main.loadNibNamed(nibName, owner: owner, topLevelObjects: &arrayWithObjects)
        
        if nibLoaded {
            guard let unwrappedObjectArray = arrayWithObjects else { return nil }
            for object in unwrappedObjectArray {
                if object is NSView {
                    return object as? NSView
                }
            }
            return nil
        } else {
            return nil
        }
    }
}
