//
//  MusicSearchViewController.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import UIKit

/*
	Landing view in the app, provides the search bar for user to enter their terms into, and a table for displaying the results
*/

class MusicSearchViewController: AppViewController
{
	//********************
	// MARK:- OUTLETS AND VARIABLES
	//********************
	
	static let owningStoryboard:String = "Main"
	static let identifier:String = "MusicSearchViewController"
	
	@IBOutlet weak var SearchBar: UISearchBar!
	@IBOutlet weak var MusicTable: UITableView!
	
	let viewModel = MusicSearchViewModel()
	
	var searchTask: DispatchWorkItem? // Used to ensure we don't make too many calls to the getAlbums() function
	
	//********************
	// MARK:- VIEW CONTROLLER FUNCTIONS
	//********************
	
	// Things to do when the view loads
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
	
		self.viewModel.delegate = self
		self.viewModel.setupViewModel()
	
		self.configureView()
    }
	
	// Registers the custom AlbumCell, sets the delegate and data sources
	
	func configureView()
	{
		self.MusicTable.register(AlbumCell.nib, forCellReuseIdentifier: AlbumCell.identifier)
		
		self.MusicTable.delegate = self
		self.MusicTable.dataSource = self
		self.MusicTable.separatorStyle = .none
		
		self.SearchBar.delegate = self
	}
}

//********************
// MARK:- TABLE VIEW DELEGATE, DATA SOURCE FUNCTIONS
//********************

extension MusicSearchViewController:UITableViewDelegate, UITableViewDataSource
{
	// Determines the number of sections in the table
	// This is a simple project, so we can set it as one
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	// Determines how many rows are in the section. We only have 1 section, so this is the number of rows for the table
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		// If there are no rows because the album array is empty, draw the empty view
		
		if self.viewModel.albums.count == 0
		{
			let view = Bundle.main.loadNibNamed("MusicTableEmptyView", owner: self, options: nil)?[0] as? MusicTableEmptyView
			tableView.backgroundView = view
		}
		
		// Otherwise, we don't need the empty view
		
		else
		{
			DispatchQueue.main.async
			{
				tableView.backgroundView = nil
			}
		}
		
		return self.viewModel.albums.count
	}
	
	// Sets the height for a row
	// Since we want dynamic row heights (album titles can vary in length), we'll use automatic dimensions
	// Make sure the autolayout constraints are properly set in the AlbumCell, or the heights will not be calculated correctly
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return UITableView.automaticDimension
	}
	
	// Dequeues the cell specified and configures it
	// In this case, we use the custom AlbumCell to display the data for an album
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let cell = self.MusicTable.dequeueReusableCell(withIdentifier: AlbumCell.identifier) as? AlbumCell else {return UITableViewCell()}
		cell.album = self.viewModel.albums[indexPath.row]
		cell.configureCell()
		cell.selectionStyle = .none
		
		return cell
	}
	
	// Action to carry out when a row is selected
	// In this case, if the navigation controller exists, push the MusicDetailVC onto the navigation stack
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		guard let navigation = self.navigationController else {return}
		let album = self.viewModel.albums[indexPath.row]
		MusicDetailViewController.push(navigation: navigation, album: album)
	}
}

//********************
// MARK:- SEARCH BAR DELEGATE FUNCTIONS
//********************

extension MusicSearchViewController:UISearchBarDelegate
{
	// Search bar delegate function, called if the search bar text changes
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
	{
		// Cancel previous task, if any exists
		self.searchTask?.cancel()

		// Replace the previous task with the new one
		let task = DispatchWorkItem { [weak self] in
			self?.performSearch()
		}
		
		self.searchTask = task

		// Execute task in 0.5 seconds (if it is not cancelled)
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
	}
	
	// Performs the search by calling the getAlbum function in the view model
	
	func performSearch()
	{
		if let searchText = self.SearchBar.text
		{
			self.viewModel.getAlbum(by: searchText){}
		}
	}
}

//********************
// MARK:- VIEW MODEL DELEGATE FUNCTIONS
//********************

extension MusicSearchViewController:ViewModelDelegate
{
	// Display a loading overlay if called, used when loading something
	
	func willLoadData()
	{
		self.showLoadingOverlay(with: "Fetching...")
	}
	
	// Hides the loading overlay and forces the table to refresh, used when an async action is done
	
	func didLoadData()
	{
		self.dismissLoadingOverlay()
		self.MusicTable.reloadData()
	}
}
