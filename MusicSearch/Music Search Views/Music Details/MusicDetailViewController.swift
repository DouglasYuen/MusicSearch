//
//  MusicDetailViewController.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-28.
//

import UIKit

class MusicDetailViewController: AppViewController
{
	//********************
	// MARK:- STRINGS
	//********************
	
	let genre = "Genre"
	let price = "Price"
	let copyright = "Copyright"
	
	//********************
	// MARK:- OUTLETS AND VARIABLES
	//********************
	
	static let owningStoryboard:String = "Main"
	static let identifier:String = "MusicDetailViewController"
	
	@IBOutlet weak var AlbumImageView: UIImageView!
	@IBOutlet weak var AlbumNameLabel: UILabel!
	@IBOutlet weak var AlbumGenreLabel: UILabel!
	@IBOutlet weak var AlbumPriceLabel: UILabel!
	@IBOutlet weak var AlbumCopyrightLabel: UILabel!
	
	let viewModel = MusicDetailViewModel()
	
	//********************
	// MARK:- VIEW FUNCTIONS
	//********************
	
    override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		self.configureView()
    }

	// From the album in the view model, set up the labels and images in the view
	
	func configureView()
	{
		guard let album = self.viewModel.album else {return}
		
		// Declare the different styles of attributed text
		
		let titleAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)]
		let boldAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .bold)]
		let normalAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular)]
		
		// Set up the name label
		
		let titleString = NSMutableAttributedString(string: album.collectionName, attributes: titleAttribute)
		self.AlbumNameLabel.attributedText = titleString
		
		// Set up the genre label
		
		let genreString = NSMutableAttributedString(string: "\(self.genre): ", attributes: normalAttribute)
		genreString.append(NSMutableAttributedString(string: album.primaryGenreName, attributes: boldAttribute))
		self.AlbumGenreLabel.attributedText = genreString
		
		// Set up the price string, if a price is found
		
		let priceString = NSMutableAttributedString(string: "\(self.price): ", attributes: normalAttribute)
		
		if let price = album.collectionPrice
		{
			priceString.append(NSMutableAttributedString(string: "\(price) \(album.currency)", attributes: boldAttribute))
		}
		
		else
		{
			priceString.append(NSMutableAttributedString(string: "N/A", attributes: boldAttribute))
		}
		
		self.AlbumPriceLabel.attributedText = priceString
		
		// Set up the copyright string, if copyright information is found
		
		let copyrightString = NSMutableAttributedString(string: "\(self.copyright): ", attributes: normalAttribute)
		
		if let copyright = album.copyright
		{
			copyrightString.append(NSMutableAttributedString(string: copyright, attributes: boldAttribute))
		}
		
		else
		{
			copyrightString.append(NSMutableAttributedString(string: "N/A", attributes: boldAttribute))
		}
		
		self.AlbumCopyrightLabel.attributedText = copyrightString

		// Get the album image using SDWebImage to load the image, otherwise, fall back on a default
		
		if let imageURL:URL = URL(string: album.artworkUrl100)
		{
			self.AlbumImageView.sd_setImage(with: imageURL, completed: {(image, error, cacheType, imageURL) in
				if error != nil
				{
					self.AlbumImageView.image = #imageLiteral(resourceName: "Default")
				}
			})
		}
		
		else
		{
			self.AlbumImageView.image = #imageLiteral(resourceName: "Default")
		}
		
		self.AlbumImageView.contentMode = .scaleAspectFill
		self.AlbumImageView.layer.cornerRadius = 10.0
		self.AlbumImageView.layer.masksToBounds = true
	}
	
	//********************
	// MARK:- NAVIGATION FUNCTION
	//********************
	
	// Allows this view to be instantiated and pushed onto the navigation stack with an album
	
	static func push(navigation:UINavigationController, album:Album)
	{
		let storyboard = UIStoryboard(name: owningStoryboard, bundle: nil)
		guard let musicDetailView = storyboard.instantiateViewController(withIdentifier: identifier) as? MusicDetailViewController else {return}
		musicDetailView.viewModel.album = album
		navigation.pushViewController(musicDetailView, animated: true)
	}
}
