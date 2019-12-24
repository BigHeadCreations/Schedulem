//
//  MainViewCon.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class MainViewCon: NSViewController, NSTableViewDataSource
{
	@IBOutlet var studentsArrayCon : NSArrayController!
	@IBOutlet var studentsTable : NSTableView!
	@objc var students : [Student] = []

	override func viewDidLoad()
	{
		studentsTable.dataSource = self
		
		// init a few demo students
		let student1 = Student.init(name: "Timothy Pearson", sex: .male)
		let student2 = Student.init(name: "Jamie Pearson", sex: .female)
		let student3 = Student.init(name: "Daniel Bryant", sex: .male)
		
		students.append(student1)
		students.append(student2)
		students.append(student3)
		
		super.viewDidLoad()
		
		studentsArrayCon.bind(NSBindingName("contentArray"), to: self, withKeyPath: "students")

	}

	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		guard let column = tableColumn else { return nil }
		switch column.identifier.rawValue
		{
		case "name":
			return students[row].name
			
		case "sex":
			return students[row].sex
		
		case "points":
			return students[row].points
			
		default:
			return nil
			
		}
	}

	func numberOfRows(in tableView: NSTableView) -> Int
	{
		return students.count
	}

	override var representedObject: Any?
	{
		didSet 
		{
			// Update the view, if already loaded.
		}
	}

}

