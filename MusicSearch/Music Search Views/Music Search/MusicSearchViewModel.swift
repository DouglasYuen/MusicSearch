//
//  MusicSearchViewModel.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import Foundation

/*
	View model for the MusicSearchViewController, holds logic pertaining to album retrieval
*/

class MusicSearchViewModel:ViewModelType
{
	var albums:[Album] = [] // List of albums to show in the table
	
	var delegate: ViewModelDelegate?
	
	func setupViewModel()
	{

	}
	
	// Asynchronously retrieves the albums by a search term passed in
	
	func getAlbum(by searchTerm:String, onFinish: @escaping () -> ())
	{
		self.albums.removeAll() // Clear the album out first for every new search
		iTunesAPI.getAlbums(for: searchTerm){ (response, error) in
			if error == nil
			{
				if let albums = response["results"].array
				{
					for album in albums
					{
						self.albums.append(Album(album))
					}
					
					self.delegate?.didLoadData()
					
					onFinish()
				}
				
				else
				{
					onFinish()
				}
			}
			
			else
			{
				onFinish()
			}
		}
	}
}
