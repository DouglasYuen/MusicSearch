//
//  MusicDetailViewModel.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-28.
//

import Foundation

class MusicDetailViewModel: ViewModelType
{
	// Store the album that needs to be displayed in the MusicDetailViewController
	var album:Album!
	
	// ViewModelType  functions unimplemented for now
	
	var delegate: ViewModelDelegate?
	
	func setupViewModel()
	{
		
	}
}


