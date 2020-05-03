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
	var editClicked : Bool = false

	override func viewDidLoad()
	{
		_ = DBMgr()
		
		studentsTable.dataSource = self
		addDummyData(true)
		super.viewDidLoad()
		studentsArrayCon.bind(NSBindingName("contentArray"), to: self, withKeyPath: "students")
		
	}

	@IBAction func addDummyData(_ sender: Any)
	{
		// init a few demo students
		let student1 = Student.init(name: "Timothy Pearson", sex: .male)
		let student2 = Student.init(name: "Jamie Pearson", sex: .female)
		let student3 = Student.init(name: "Daniel Bryant", sex: .male)
		let student4 = Student.init(name: "Jose Maria", sex: .male)
		
		students.append(student1)
		students.append(student2)
		students.append(student3)
		students.append(student4)
		
		studentsTable.reloadData()

	}
	
	// TODO: pull this out into its own Model
	// TODO: pull out this and the students array and access it like DataMgr.students
	func removeStudent(_ toRemove: Student)
	{
		for student in students
		{
			if(toRemove.uuid == student.uuid)
			{
				students.removeAll(where: { $0.uuid == toRemove.uuid })
			}
		}
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
	
	@IBAction func deleteClicked(_ sender: Any)
	{
		let student = students[studentsTable.clickedRow]
		removeStudent(student)
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
			let student = students[studentsTable.clickedRow]
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

