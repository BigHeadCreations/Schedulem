//
//  Sex.swift
//  Schedulem
//
//  Created by Timothy Pearson on 6/21/20.
//  Copyright © 2020 Timothy Pearson. All rights reserved.
//


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
