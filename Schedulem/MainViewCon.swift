//
//  MainViewCon.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa
import SQLite

class MainViewCon: NSViewController, NSTableViewDataSource
{
	@IBOutlet var studentsArrayCon : NSArrayController!
	@IBOutlet var studentsTable : NSTableView!
	@objc var students : [Student] = []

	override func viewDidLoad()
	{
		studentsTable.dataSource = self
		
		addDummyData(true)
		
		super.viewDidLoad()
		
		studentsArrayCon.bind(NSBindingName("contentArray"), to: self, withKeyPath: "students")
		
		var fm : FileManager = FileManager.default
		
		do
		{
			let docsDirURL : URL = try fm.url(for: FileManager.SearchPathDirectory.documentDirectory,
												in: FileManager.SearchPathDomainMask.userDomainMask,
												appropriateFor: nil,
												create: true)
												
			let sqlURL : URL = docsDirURL.appendingPathComponent("db.sqlite3", isDirectory: false)
			let db = try Connection(sqlURL.absoluteString)
			print("docs dir: \(docsDirURL)")
			print("sqlURL location: \(sqlURL)")
			
			
			// testing
			let users = Table("users")
			let id = Expression<Int64>("id")
			let name = Expression<String?>("name")
			let email = Expression<String>("email")

			try db.run(users.create { t in
				t.column(id, primaryKey: true)
				t.column(name)
				t.column(email, unique: true)
			})

			

		}
		catch
		{
			print("oops")
		}
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
		print("edit clicked")
		
		// TODO: load edit window
	}
	

	override var representedObject: Any?
	{
		didSet 
		{
			// Update the view, if already loaded.
		}
	}

}

