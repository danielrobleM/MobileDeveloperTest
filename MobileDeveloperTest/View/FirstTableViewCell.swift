//
//  FirstTableViewCell.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 21-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

	@IBOutlet weak var articleTitle: UILabel!
	@IBOutlet weak var subtitle: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

}
