//
//  Album.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation
import SwiftyJSON

/*
	Representation of an album from the iTunes API
	Contains properties for album name, album art, release date, genre, currency, price and copyright owner
*/

public struct Album
{
	var collectionName:String
	var artworkUrl100:String
	var releaseDate:String
		
	var primaryGenreName:String
	var collectionPrice:Float?
	var currency:String
	var copyright:String?
	
	// Initialises an Album object from the JSON passed in using Swifty JSON
	
	init(_ json:JSON)
	{
		self.collectionName = json["collectionName"].stringValue
		self.artworkUrl100 = json["artworkUrl100"].stringValue
		self.releaseDate = json["releaseDate"].stringValue
		
		self.primaryGenreName = json["primaryGenreName"].stringValue
		self.collectionPrice = json["collectionPrice"].float
		self.currency = json["currency"].stringValue
		self.copyright = json["copyright"].string
	}
}
