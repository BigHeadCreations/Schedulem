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
	enum Sex: CustomStringConvertible
	{
		case male
		case female
		
		var description: String
		{
			switch self
			{
			case .male: return "male"
			case .female: return "female"
			}
		}
	}
	
	var name : String
	var uuid : UUID
	var sex : Sex = .male
	var bibleStudyOK : Bool = false
	var talkOK : Bool = false
	var lastAssignment : Date? = nil
	var nextAssignment : Date? = nil
	var lastHH : Date? = nil
	var nextHH : Date? = nil
	var points : Int = 0
	
	// TIMO>> TODO: implement this later
//	var blacklist : [Student?] = []
//	var family : [Student?] = []

	init(name: String, sex: Sex)
	{
		self.name = name
		self.sex = sex
		
		self.uuid = UUID.init()
		
	}
	
}
