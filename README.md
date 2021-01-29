# MusicSearch

This is a sample iOS application that provides users with an interface for searching iTunes albums and displaying more information about these albums. Users type their query into a search bar, and albums matching the query string are returned into the app. Tapping on an album brings up more information (e.g. copyright and price).

The aim of this project is to provide a template for what a minimally-viable iOS app requires in terms functionality and design.

## Project setup

This project utilises the CocoaPods dependency manager. Before compiling **MusicSearch**, navigate to the project directory and run the following command in the terminal:

    pod install

Once the dependencies are installed, the .xcworkspace file can be opened, and the project can be compiled from here.

## iOS Principles Used

**MusicSearch** indicates how even a relatively simple app will require familiarity with the following principles:

 - Project structure
	 - MVVM and delegation design patterns
		 - Keep the application codebase clean and readable. 
		 - View Models only handle retrieval, storage and manipulation of data
		 - View only handles display of data and rendering of view elements.
		 - Uses delegation to update view from view model
	 - Xcode Build configurations and environment variables
		 - Allows the app to call staging and production endpoints more easily if needed
	 - Asynchronous functions, completion handlers
		 - Delay search call to prevent heavy network traffic if the user is still typing their query
		 - Refresh a view when information comes back
		 - Lazy image loading
	 - UINavigationController to manage view navigation
		 - AppDelegate extension allows app to determine which screen to start on. This is overkill for **MusicSearch**, but is useful for apps where there is an application state, like if the user is logged in
	 - Use of CocoaPods dependency manager
 - CocoaTouch
	 - Storyboarding and IBOutlets
	 - .xib + .swift for custom UIView and UITableViewCell elements
	 - Autolayout constraints and rules
	 - UITableView, UITableViewDelegate, UITableViewDataSource
		 - Custom table view cells to give app a distinct style
		 - Display an empty state if there are no albums
	 - UISearchController, UISearchControllerDelegate
 - RESTful API/JSON Parsing
	 - Call to iTunes API for album data response
	 - Parse response JSON file into data model
	 - Uses AlamoFire to handle creating network sessions
		 - Only GET requests are used in this app
 - Other functions
	 - Date parsing from ISO 8601 format
	 - Drawing code for a loading overlay to display to users for lengthy async calls

## Compatibility

Requires Xcode 14.3 or later, Swift 5.3 or later.