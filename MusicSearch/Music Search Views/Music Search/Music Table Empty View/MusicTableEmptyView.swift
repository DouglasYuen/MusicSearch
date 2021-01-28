//
//  MusicTableEmptyView.swift
//  MusicSearch
//
//  Created by Douglas Yuen on 2021-01-28.
//

import UIKit

class MusicTableEmptyView: UIView
{
	@IBOutlet weak var EmptyImage: UIImageView!
	@IBOutlet weak var EmptyLabel: UILabel!

	override init(frame: CGRect)
	{
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder)
	{
		super.init(coder: coder)
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		self.configureView()
	}
	
	func configureView()
	{
		self.EmptyLabel.text = "Use the search bar to find your favourite albums. If searching returns nothing, please try other search terms!"
		self.EmptyImage.image = #imageLiteral(resourceName: "Search")
	}
}
