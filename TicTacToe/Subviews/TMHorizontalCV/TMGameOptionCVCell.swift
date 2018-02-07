//
//  TMGameOptionCVCell.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMGameOptionCVCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	var stateSelectColor = UIColor.clear
	var stateDeselectColor = UIColor.clear
	
	override func awakeFromNib() {
        super.awakeFromNib()
		layer.borderWidth = 1.0
    }
	
	override var isSelected: Bool {
		didSet {
			self.backgroundColor = isSelected ? stateSelectColor : stateDeselectColor
		}
	}
}

extension UICollectionViewCell {
	
	static func nib() -> UINib {
		let fullName = NSStringFromClass(self.classForCoder())
		let name = fullName.components(separatedBy: ".").last!
		
		return UINib(nibName: name, bundle: Bundle.main)
	}
	
	static func reuseIdentifier() -> String {
		return NSStringFromClass(self)
	}
}
