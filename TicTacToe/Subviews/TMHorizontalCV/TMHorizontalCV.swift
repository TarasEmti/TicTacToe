//
//  TMHorizontalCV.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMHorizontalCV: UIView {

	private let title: TMSectionTitle!
	let collectionView: UICollectionView!
	
	override init(frame rect: CGRect) {
		self.title = TMSectionTitle()
		let layout = UICollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		super.init(frame: rect)
		
		addSubview(title)
		addSubview(collectionView)
		
		collectionView.register(TMGameOptionCVCell.nib(), forCellWithReuseIdentifier: TMGameOptionCVCell.reuseIdentifier())
	}
	
	required init?(coder aDecoder: NSCoder) { abort() }
	
	override func layoutSubviews() {
		
		let titleHeight = bounds.height/5
		let collectionViewHeight = bounds.height - titleHeight
		
		self.title.frame = CGRect(x: 0, y: 0, width: bounds.width, height: titleHeight)
		self.collectionView.frame = CGRect(x: 0, y: titleHeight, width: bounds.width, height: collectionViewHeight)
		
		// Customize layout
		let cellWidth: CGFloat 		= bounds.width/3
		let cellHeight: CGFloat 	= collectionViewHeight
		let itemSize				= CGSize(width: cellWidth, height: cellHeight)
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = itemSize
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		self.collectionView.collectionViewLayout = layout
	}
	
	func setTitleText(_ text: String, animated: Bool) {
		if animated {
			UIView.animate(withDuration: 0.25, animations: {
				self.title.alpha = 0
				UIView.animate(withDuration: 0.25, animations: {
					self.title.text = text
					self.title.alpha = 1
				})
			})
		} else {
			self.title.text = text
		}
	}
}
