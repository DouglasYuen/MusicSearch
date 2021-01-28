//
//  Environment.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation

/*
	Holds the PlistKeys for the xcconfig files that the app uses
*/

public enum PlistKey
{
	case ServerURL
	case ConnectionProtocol
	
	func value() -> String
	{
		switch self
		{
			case .ServerURL:
				return "SERVER_URL"
			case .ConnectionProtocol:
				return "PROTOCOL"
		}
	}
}

/*
	MusicSearch has a Debug and Release mode
*/

enum EnvironmentTypes: String
{
	case Debug
	case Release
}

/*
	Depending on the environment selected (either debug or release), point the app to the right resources
	This is used if the Debug and Release URLs are different, or if the app needs any API keys that differ depending on the environment
*/

class Environment
{
	
	static let shared = Environment()

	fileprivate var infoDictionary:[String:Any]
	{
		get
		{
			if let dictionary = Bundle.main.infoDictionary
			{
				return dictionary
			}
				
			else
			{
				fatalError("No plist file found")
			}
		}
	}
	
	public func configuration(_ key:PlistKey) -> String
	{
		switch key
		{
			case .ServerURL:
				return infoDictionary[PlistKey.ServerURL.value()] as! String
			case .ConnectionProtocol:
				return infoDictionary[PlistKey.ConnectionProtocol.value()] as! String
		}
	}
}
