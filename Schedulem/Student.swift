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
	@objc var name : String
	var male : Bool
	var bibleStudyOK : Bool = false
	var talkOK : Bool = false
	var lastAssignment : Date? = nil
	var nextAssignment : Date? = nil
	var lastHH : Date? = nil
	var nextHH : Date? = nil
	var points : Int = 0
	
	// for bindings
	@objc var mf : NSString?
	
	// TIMO>> TODO: implement this later
//	var blacklist : Array? = [nil]
//	var family : Array? = [nil]

	init(name: String, male: Bool)
	{
		self.name = name
		self.male = male
		
		self.mf = (self.male == true) ? "male" : "female"
	}
	
}
