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
	var editClicked : Bool = false

	override func viewDidLoad()
	{
		_ = DBMgr()
		
		studentsTable.dataSource = self
		super.viewDidLoad()
		studentsArrayCon.bind(NSBindingName("contentArray"), to: dbMgr as Any, withKeyPath: "students")
	}
	
	// NSTableView DataSource methods
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any?
	{
		guard let column = tableColumn else { return nil }
		switch column.identifier.rawValue
		{
		case "name":
			return dbMgr.students[row].name
			
		case "sex":
			return dbMgr.students[row].sex
					
		default:
			return nil
			
		}
	}

	func numberOfRows(in tableView: NSTableView) -> Int
	{
		return dbMgr.students.count
	}
	
	@IBAction func deleteClicked(_ sender: Any)
	{
		let student = dbMgr.students[studentsTable.clickedRow]
		dbMgr.removeStudent(student)
		studentsTable.reloadData()
	}
	
	@IBAction func editClicked(_ sender: Any)
	{
		editClicked = true // TODO: can I get rid of this bool and achieve this another way?
		self.performSegue(withIdentifier: "mainToStudentSegue", sender: self)
	}
	
	override func prepare(for segue: NSStoryboardSegue, sender: Any?)
	{
		if(segue.identifier == "mainToStudentSegue" && editClicked)
		{
			editClicked = false
			let student = dbMgr.students[studentsTable.clickedRow]
			let studentView : StudentViewCon = segue.destinationController as! StudentViewCon
			studentView.student = student
		}
	}

	

	override var representedObject: Any?
	{
		didSet 
		{
			// Update the view, if already loaded.
		}
	}

}

