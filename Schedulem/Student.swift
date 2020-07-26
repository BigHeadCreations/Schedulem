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
	
	var name : String
	var uuid : UUID
	var sex : Sex = .male
	var bibleStudyOK : Bool = false
	var talkOK : Bool = false
	
	// TIMO>> TODO: implement this later
//	var blacklist : [Student?] = []
//	var family : [Student?] = []

	init(name: String, sex: Sex)
	{
		self.name = name
		self.sex = sex
		
		self.uuid = UUID.init()
		
	}
	
	init(name: String, uuid: UUID, sex: Sex, bibleStudyOk: Bool, talkOk: Bool)
	{
		self.name = name
		self.uuid = uuid
		self.sex = sex
		self.bibleStudyOK = bibleStudyOk
		self.talkOK = talkOk
	}
	
}
