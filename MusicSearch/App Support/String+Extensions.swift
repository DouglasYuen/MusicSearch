//
//  Date+Extensions.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation

extension String
{
	// Uses the date formatter to convert the server date string to a readable date
	
	func readableDate() -> String
	{
		let dateFormatterServer = DateFormatter()
		dateFormatterServer.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
		
		let tempDate = dateFormatterServer.date(from: self) ?? Date()
		
		let dateFormatterReadable = DateFormatter()
		dateFormatterReadable.dateFormat = "MMM dd, yyyy"
		
		let readableDate = dateFormatterReadable.string(from: tempDate)
		return readableDate
	}
}
