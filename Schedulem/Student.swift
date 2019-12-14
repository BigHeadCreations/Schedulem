//
//  Student.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class Student : NSObject
{
	enum Sex
	{
		case male
		case female
	}
	
	@objc var name : String
	var sex : Sex = .male
	var bibleStudyOK : Bool = false
	var talkOK : Bool = false
	var lastAssignment : Date? = nil
	var nextAssignment : Date? = nil
	var lastHH : Date? = nil
	var nextHH : Date? = nil
	@objc var points : Int = 0
	
	// TIMO>> TODO: implement this later
//	var blacklist : [Student?] = []
//	var family : [Student?] = []

	init(name: String, sex: Sex)
	{
		self.name = name
		self.sex = sex
		
	}
	
}
