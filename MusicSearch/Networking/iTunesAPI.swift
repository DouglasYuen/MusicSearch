//
//  iTunesAPI.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation
import SwiftyJSON

/*
	This class holds the endpoint calls the Music Search App needs to make in order to retrieve album data
*/

public class iTunesAPI
{
	/**
		GET Request, returns a list of JSON objects representing iTunes albums
	
		- Parameter term: The search terms the user passes in
		- Parameter completionHandler: The callback called after retrieval, containing the call's JSON response and when applicable, an NSError
	 */
	
	// Note: the "entity" and "country" parameters are hard-coded in for simplicity's sake
	// In a more versatile setup, the country code can be retrieved from the device using NSLocale, and the entity can be passed in
	
	static func getAlbums(for term:String, onFinish: @escaping (JSON, NSError?) -> Void)
	{
		let route = RequestHelper.route("search")
		
		let params = [
			"term": term,
			"entity" : "album",
			"country" : "ca"
		] as [String: AnyObject]
		
		RequestHelper.requestGET(route, params: params, onFinish: onFinish)
	}
}
