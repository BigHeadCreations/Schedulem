//
//  StudentViewCon.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/4/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class StudentViewCon: NSViewController {
	
	@IBOutlet var maleBtn : NSButton!
	@IBOutlet var femaleBtn : NSButton!
	@IBOutlet var name : NSTextField!
	
	@IBAction func maleBtnPressed(_ sender: AnyObject)
	{
		maleBtn.state = NSControl.StateValue.on
		
		if(femaleBtn.state == NSControl.StateValue.on)
		{
			femaleBtn.state = NSControl.StateValue.off
		}
	}

	@IBAction func femaleBtnPressed(_ sender: AnyObject)
	{
		femaleBtn.state = NSControl.StateValue.on

		if(maleBtn.state == NSControl.StateValue.on)
		{
			maleBtn.state = NSControl.StateValue.off
		}
	}
	
	@IBAction func save(_ sender: AnyObject)
	{
		// TIMO>> TODO: this is not a good way to pass data around. Don't use a singleton. Use the segue
		let student = Student.init(name: "TESTING", male: true)
		if let vc = viewController
		{
			vc.willChangeValue(forKey: "students")
			vc.students.add(student)
			vc.didChangeValue(forKey: "students")
		}
		
		dismiss(self)
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do view setup here.
	}



}
