//
//  WindowController.swift
//  Tool
//
//  Created by apple on 2020/3/3.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        let color = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        super.window?.backgroundColor = color
    }
    
}
