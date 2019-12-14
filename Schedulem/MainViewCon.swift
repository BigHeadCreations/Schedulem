//
//  MainViewCon.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class MainViewCon: NSViewController {

	@IBOutlet var studentsArrayCon : NSArrayController!
	@objc var students : NSMutableArray = NSMutableArray()

	override func viewDidLoad()
	{
		// init a few demo students
		let student1 = Student.init(name: "Timothy Pearson", sex: .male)
		let student2 = Student.init(name: "Jamie Pearson", sex: .female)
		let student3 = Student.init(name: "Daniel Bryant", sex: .male)
		
		students.add(student1)
		students.add(student2)
		students.add(student3)
		
		super.viewDidLoad()
		
		studentsArrayCon.bind(NSBindingName("contentArray"), to: self, withKeyPath: "students")

	}

	override var representedObject: Any?
	{
		didSet {
		// Update the view, if already loaded.
		}
	}

}

