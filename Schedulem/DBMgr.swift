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
		
		// set up tables (will error out if already exist, which is fine)
		createTable(named: "users")

		dbMgr = self
		
	}
	
	public func createTable(named tableName : String)
	{
		print("trying to create table named \(tableName)")
		do
		{
			// testing
			let users = Table(tableName)
			let id = Expression<Int64>("id")
			let name = Expression<String?>("name")
			let email = Expression<String>("email")
			
			try connection.run(users.create { t in
				t.column(id, primaryKey: true)
				t.column(name)
				t.column(email, unique: true)
			})
		}
		catch
		{
			print("\(tableName) table already exists")
		}

	}
}


// might not need to do this. Maybe can just make static methods instead
public var dbMgr : DBMgr! = nil
