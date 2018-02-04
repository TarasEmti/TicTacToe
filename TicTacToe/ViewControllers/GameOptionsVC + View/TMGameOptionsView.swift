//
//  TMGameOptionsView.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation
import UIKit

class TMGameOptionsView: UIView {
	
	// Here we have three horizontal collection views
	// Should be placed one after another
	var firstSectionCV: TMHorizontalCV!
	var secondSectionCV: TMHorizontalCV!
	var thirdSectionCV: TMHorizontalCV!
	
	var firstSectionLabel: UILabel!
	var secondSectionLabel: UILabel!
	var thirdSectionLabel: UILabel!
	
	private var sectionLabelHeight: CGFloat!
	private var sectionCVHeight: CGFloat!
	
	init() {
		firstSectionLabel = UILabel()
		secondSectionLabel = UILabel()
		thirdSectionLabel = UILabel()
		
		let layout = UICollectionViewFlowLayout()
		firstSectionCV 	= TMHorizontalCV(frame: .zero, collectionViewLayout: layout)
		secondSectionCV = TMHorizontalCV(frame: .zero, collectionViewLayout: layout)
		thirdSectionCV 	= TMHorizontalCV(frame: .zero, collectionViewLayout: layout)
		
		super.init(frame: .zero)
		
		addSubview(firstSectionLabel)
		addSubview(firstSectionCV)
		addSubview(secondSectionLabel)
		addSubview(secondSectionCV)
		addSubview(thirdSectionLabel)
		addSubview(thirdSectionCV)
		
		setupLabel(withTitle: "Choose your opponent".localized, label: firstSectionLabel)
		setupLabel(withTitle: "Choose board size".localized, label: secondSectionLabel)
		setupLabel(withTitle: "Choose your icon".localized, label: thirdSectionLabel)
	}
	
	required init?(coder aDecoder: NSCoder) { abort() }
	
	func setupLabel(withTitle title: String, label: UILabel) {
		
		label.backgroundColor = TMGameLib.genericLabelColor
		label.layer.borderWidth = 3
		label.layer.borderColor = TMGameLib.genericLabelBorderColor.cgColor
		label.textColor = .black
		label.textAlignment = .center
		label.font = TMGameLib.commonOptionsFont
		label.text = title
	}
	
	override func layoutSubviews() {
		
		let sectionHeight: CGFloat 	= bounds.height/3
		sectionLabelHeight 			= sectionHeight/5
		sectionCVHeight 			= sectionHeight - sectionLabelHeight
		
		let cellWidth: CGFloat 		= bounds.width/3
		let cellHeight: CGFloat 	= sectionCVHeight
		let itemSize				= CGSize(width: cellWidth, height: cellHeight)
		
		var y: CGFloat = 0
		
		// Place three sections on the screen equaly
		firstSectionLabel.frame 		= CGRect(x: 0, y: y, width: bounds.width, height: sectionLabelHeight)
		y += sectionLabelHeight
		let firstCollectionFrame 	= CGRect(x: 0, y: y, width: bounds.width, height: sectionCVHeight)
		y += sectionCVHeight
		
		secondSectionLabel.frame 	= CGRect(x: 0, y: y, width: bounds.width, height: sectionLabelHeight)
		y += sectionLabelHeight
		let secondCollectionFrame	= CGRect(x: 0, y: y, width: bounds.width, height: sectionCVHeight)
		y += sectionCVHeight
		
		thirdSectionLabel.frame 	= CGRect(x: 0, y: y, width: bounds.width, height: sectionLabelHeight)
		y += sectionLabelHeight
		let thirdCollectionFrame	= CGRect(x: 0, y: y, width: bounds.width, height: sectionCVHeight)
		y += sectionCVHeight
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = itemSize
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		firstSectionCV.collectionViewLayout = layout
		secondSectionCV.collectionViewLayout = layout
		thirdSectionCV.collectionViewLayout = layout
		
		firstSectionCV.frame = firstCollectionFrame
		secondSectionCV.frame = secondCollectionFrame
		thirdSectionCV.frame = thirdCollectionFrame
	}
}
