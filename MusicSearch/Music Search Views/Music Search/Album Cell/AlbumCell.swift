//
//  AlbumCell.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-27.
//

import UIKit
import SDWebImage

class AlbumCell: UITableViewCell
{
	@IBOutlet weak var ContainerView: UIView!
	@IBOutlet weak var AlbumImageView: UIImageView!
	@IBOutlet weak var AlbumTitleLabel: UILabel!
	@IBOutlet weak var AlbumDateLabel: UILabel!

	// Holds the album information for the cell.
	// When set, update all of the other attributes inside the cell.
	
	var album:Album?
	{
		didSet
		{
			self.AlbumTitleLabel.text = album?.collectionName
			self.AlbumDateLabel.text = album?.releaseDate.readableDate()
			if let imageURLString = album?.artworkUrl100
			{
				if let imageURL:URL = URL(string: imageURLString)
				{
					
					AlbumImageView.sd_setImage(with: imageURL, completed: {(image, error, cacheType, imageURL) in
					})
				}
				
				else
				{
					AlbumImageView.image = #imageLiteral(resourceName: "Default")
				}
			}
			
			else
			{
				AlbumImageView.image = #imageLiteral(resourceName: "Default")
			}
		}
	}
	
	static var nib:UINib
	{
		return UINib(nibName: identifier, bundle: nil)
	}
	
	static var identifier:String
	{
		return String(describing: self)
	}
	
	static var height:CGFloat
	{
		return 100
	}
	
	func configureCell()
	{
		self.ContainerView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
		self.ContainerView.layer.cornerRadius = 10.0
		self.ContainerView.layer.masksToBounds = true
		
		self.AlbumImageView.layer.cornerRadius = 10.0
		self.AlbumImageView.layer.masksToBounds = true
		
		self.AlbumTitleLabel.font = .boldSystemFont(ofSize: 20)
	}
}
