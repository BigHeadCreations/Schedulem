//
//  DBMgr.swift
//  Schedulem
//
//  Created by Timothy Pearson on 5/3/20.
//  Copyright © 2020 Timothy Pearson. All rights reserved.
//

import Foundation
import SQLite

public class DBMgr : NSObject
{
	@objc var students : [Student] = []
	var connection : Connection! = nil
	var assignments : [Assignment] = []
	
	// Student table columns
	struct SCols
	{
		static let id = Expression<Int64>("id")
		static let name = Expression<String>("name")
		static let uuid = Expression<String>("uuid")
		static let sex = Expression<String>("sex")
		static let bibleStudyOk = Expression<Bool>("bible_study_ok")
		static let talkOk = Expression<Bool>("talk_ok")
	}


	public override init()
	{
		super.init()
		
		do
		{
			let fm : FileManager = FileManager.default
			let docsDirURL : URL = try fm.url(for: FileManager.SearchPathDirectory.documentDirectory,
											  in: FileManager.SearchPathDomainMask.userDomainMask,
											  appropriateFor: nil,
											  create: true)
			
			let sqlURL : URL = docsDirURL.appendingPathComponent("db.sqlite3", isDirectory: false)
			connection = try Connection(sqlURL.absoluteString)
		}
		catch
		{
			print("failed getting docs URL")
		}
		
		// set up tables
		createStudentsTable()
//		createAssignmentsTable()

		// set up data
		refreshStudents()

		dbMgr = self
		
	}
	
	func createStudentsTable()
	{
		print("trying to create users table")
		do
		{
			let students = Table("Students")
			
			try connection.run(students.create(ifNotExists: true) { t in
				t.column(SCols.id, primaryKey: true)
				t.column(SCols.name)
				t.column(SCols.uuid)
				t.column(SCols.sex)
				t.column(SCols.bibleStudyOk)
				t.column(SCols.talkOk)
			})
		}
		catch
		{
			print("Error when trying to create users table")
		}
	}

	func createAssignmentsTable()
	{
		print("trying to create assignments table")
		do
		{
			let users = Table("assignments")
			let id = Expression<Int64>("id")
			let name = Expression<String?>("name")
			let email = Expression<String>("email")
			
			try connection.run(users.create(ifNotExists: true) { t in
				t.column(id, primaryKey: true)
				t.column(name)
				t.column(email, unique: true)
			})
		}
		catch
		{
			print("Error when trying to create users table")
		}
	}
	
	// MARK: Students
	
	/// Add a student to the students table
	func addStudent(_ student: Student)
	{
		let sTable = Table("Students")
		do
		{
			try connection.run(sTable.insert(
								SCols.name <- student.name,
								SCols.uuid <- student.uuid.description,
								SCols.sex <- student.sex.description,
								SCols.bibleStudyOk <- student.bibleStudyOK,
								SCols.talkOk <- student.talkOK))
								
			// Is it best to add the student to my array manually, or remake the array by reading from DB?
			// prob is best to manually add it to the array.
			students.append(student)

		}
		catch
		{
			print("error adding a student: \(student)")
		}
	}
	
	func updateStudent(_ toEdit: Student)
	{
		let sTable = Table("Students")
		do
		{
			let student = sTable.filter(SCols.uuid == toEdit.uuid.uuidString)
			try connection.run(student.update(
							SCols.name <- toEdit.name,
							SCols.uuid <- toEdit.uuid.description,
							SCols.sex <- toEdit.sex.description,
							SCols.bibleStudyOk <- toEdit.bibleStudyOK,
							SCols.talkOk <- toEdit.talkOK))

		} catch
		{
			print("oops")
		}
	}
	
	func removeStudent(_ toRemove: Student)
	{
		var numRemoved = 0
		
		// remove from students array
		for student in students
		{
			if(toRemove.uuid == student.uuid)
			{
				students.removeAll(where: { $0.uuid == toRemove.uuid })
				numRemoved += 1
			}
		}
		
		if(numRemoved != 1)
		{
			print("ERROR: Didn't remove a single student from students array. numRemoved: \(numRemoved)")
			return
		}
		
		// remove from DB
		let sTable = Table("Students")

		let student = sTable.filter(SCols.uuid == toRemove.uuid.uuidString)
		do
		{
			try connection.run(student.delete())
		} catch
		{
			print("error deleting student: \(toRemove.name)")
		}
	}
	
	func refreshStudents()
	{
		// get all students from DB
		let sTable = Table("Students")
		var refreshedStudents : [Student] = []
		do
		{
			for s in try connection.prepare(sTable)
			{
				var mf = Sex.male
				switch s[SCols.sex] {
				case "male":
					mf = Sex.male
				case "female":
					mf = Sex.female
				default:
					print("error in determing sex of Student in refreshStudents()")
					return
				}
				
				guard let studentUUID = UUID.init(uuidString: s[SCols.uuid]) else
				{
					// TODO: add a throw statement here later
					print("can't convert uuid string from DB into UUID")
					return
				}
				
				// create student
				let student = Student(name: s[SCols.name],
								uuid: studentUUID,
								sex: mf,
								bibleStudyOk: s[SCols.bibleStudyOk],
								talkOk: s[SCols.talkOk])
								
				refreshedStudents.append(student)
			}
		
			students.removeAll(keepingCapacity: false)
			students = refreshedStudents
			
		}
		catch
		{
			print("error adding a student")
		}
		
		
	}
	
	
	// MARK: Assignments
	
	
	/// Add an assignment to the assignments table
	func addAssignment()
	{
	
	}
	
	func removeAssignment()
	{
	
	}
	
}


// might not need to do this. Maybe can just make static methods instead
public var dbMgr : DBMgr! = nil
