//
//  WindowController.swift
//  Schedulem
//
//  Created by Timothy Pearson on 4/12/20.
//  Copyright © 2020 Timothy Pearson. All rights reserved.
//

import Cocoa

public class WindowController: NSWindowController
{
	
	public required init?(coder: NSCoder)
	{
		super.init(coder: coder)
		winCon = self
	}

    public override func windowDidLoad()
    {
        super.windowDidLoad()
        
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}

public var winCon : NSWindowController!
