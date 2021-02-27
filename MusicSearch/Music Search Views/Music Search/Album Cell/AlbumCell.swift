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

	static let cellHeight:CGFloat = 100.0 // Height of cell, set for 100 points
	let cellCornerRadius:CGFloat = 10.0 // Preferred corner radius
	let largeFontSize:CGFloat = 20.0 // Font size for text
	
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
		return cellHeight
	}
	
	func configureCell()
	{
		self.ContainerView.backgroundColor = .customGrey()
		self.ContainerView.layer.cornerRadius = cellCornerRadius
		self.ContainerView.layer.masksToBounds = true
		
		self.AlbumImageView.layer.cornerRadius = cellCornerRadius
		self.AlbumImageView.layer.masksToBounds = true
		
		self.AlbumTitleLabel.font = .boldSystemFont(ofSize: largeFontSize)
	}
}
