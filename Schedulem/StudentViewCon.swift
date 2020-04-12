//
//  StudentViewCon.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/4/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class StudentViewCon: NSViewController
{
	@IBOutlet var maleBtn : NSButton!
	@IBOutlet var femaleBtn : NSButton!
	@IBOutlet var name : NSTextField!
	var student : Student?


	override func viewDidLoad()
	{
		super.viewDidLoad()
		student = Student.init(name: "TESTING", sex: .male)
		maleBtn.state = NSControl.StateValue.on
		femaleBtn.state = NSControl.StateValue.off
	}
	
	@IBAction func sexBtnPressed(_ sender: NSButton)
	{
		if sender.tag == 0  // male
		{
			maleBtn.state = NSControl.StateValue.on
			femaleBtn.state = NSControl.StateValue.off
			
			student?.sex = .male
		}
		
		if sender.tag == 1 // female
		{
			femaleBtn.state = NSControl.StateValue.on
			maleBtn.state = NSControl.StateValue.off
			
			student?.sex = .female
		}
	}
	
	
	@IBAction func save(_ sender: AnyObject)
	{
		if let vc = self.presentingViewController as? MainViewCon, let student = student
		{
			if name.cell!.stringValue.count > 0  
			{
				student.name = name.cell!.stringValue
			}
			else
			{
				if let window = winCon.window
				{
					let alert : NSAlert = NSAlert.init()
					alert.alertStyle = NSAlert.Style.critical
					alert.messageText = "Name can't be empty"
					alert.addButton(withTitle: "Ok")
					alert.beginSheetModal(for: window, completionHandler: nil)
				}
				return
			}
			
			vc.students.append(student)
			vc.studentsTable.reloadData()
		}
		
		student = nil
		dismiss(self)
	}
	
	@IBAction func cancel(_ sender: AnyObject)
	{
		student = nil
		dismiss(self)		
	}
}
