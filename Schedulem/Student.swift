//
//  Student.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class Student
{
	var name : String
	var male : Bool
	var lastAssignment : Date? = nil
	var nextAssignment : Date? = nil
	var lastHH : Date? = nil
	var nextHH : Date? = nil
	var points : Int = 0
	
	// TIMO>> todo: implement this later
//	var blacklist : Array? = [nil]
//	var family : Array? = [nil]

	init(name: String, male: Bool)
	{
		self.name = name
		self.male = male
	}
	
}
