//
//  DBMgr.swift
//  Schedulem
//
//  Created by Timothy Pearson on 5/3/20.
//  Copyright © 2020 Timothy Pearson. All rights reserved.
//

import Foundation
import SQLite

public class DBMgr
{
	var connection : Connection! = nil
	var students : [Student] = []
	var assignments : [Assignment] = []
	
	// Student table columns
	struct SCols
	{
		static let id = Expression<Int64>("id")
		static let name = Expression<String>("name")
		static let uuid = Expression<String>("uuid")
		static let sex = Expression<Bool>("sex")
		static let bibleStudyOk = Expression<Bool>("bible_study_ok")
		static let talkOk = Expression<Bool?>("talk_ok")
	}


	public init()
	{
		print("dbmgr has been inited")
		
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
		let students = Table("Students")
		do
		{
			try connection.run(students.insert(
								SCols.name <- student.name,
								SCols.uuid <- student.uuid.description,
								SCols.sex <- true,
								SCols.bibleStudyOk <- student.bibleStudyOK,
								SCols.talkOk <- student.talkOK))
		
		}
		catch
		{
			print("error adding a student")
		}
	}
	
	func removeStudent(_ student: Student)
	{
	
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
