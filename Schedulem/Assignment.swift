//
//  Assignment.swift
//  Schedulem
//
//  Created by Timothy Pearson on 3/3/19.
//  Copyright © 2019 Timothy Pearson. All rights reserved.
//

import Cocoa

class Assignment
{
	var date : Date
	var assignedStudent : Student
	var assignedHH : Student
	var duration : Int = 0
	var broOnly : Bool = false
	var counselPoint : Int = 0
	
	
	init(date: Date, assignedStudent: Student, assignedHH: Student)
	{
		self.date = date
		self.assignedStudent = assignedStudent
		self.assignedHH = assignedHH
	}

}
