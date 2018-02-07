//
//  TMBoardCVCell.swift
//  TicTacToe
//
//  Created by Тарас on 07.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMBoardCVCell: UICollectionViewCell {
	
	var sprite: UIImageView!
	
	override init(frame: CGRect) {
		let spriteFrame = CGRect(x: frame.width*0.1, y: frame.height*0.1, width: frame.width*0.8, height: frame.height*0.8)
		sprite = UIImageView(frame: spriteFrame)
		super.init(frame: frame)
		customizeCell()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override var isSelected: Bool {
		didSet {
			backgroundColor = isSelected ? TMGameLib.boardCellHighlighted : TMGameLib.boardCell
		}
	}
	
	private func customizeCell() {
		sprite.backgroundColor = .clear
		sprite.tintColor = .black
		sprite.contentMode = .scaleAspectFit
		
		self.addSubview(sprite)
		backgroundColor = TMGameLib.boardCell
	}
	
	func fillCell(withSprite sprite: SpriteImage) {
		self.sprite.image = UIImage(named: sprite.rawValue)
	}
}
