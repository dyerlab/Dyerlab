//
//  MainWindowController.swift
//  popgraphs
//
//  Created by Rodney Dyer on 1/3/19.
//  Copyright © 2019 Rodney Dyer. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        windowFrameAutosaveName = "PopgraphsMainWindowAutosaveName"
        print("Window is \(window?.frame.size ?? CGSize(width: 0, height:0) )" )
        
        
        
        
    }

    
    
}
