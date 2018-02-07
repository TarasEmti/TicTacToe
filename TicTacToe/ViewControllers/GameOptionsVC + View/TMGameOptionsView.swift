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
	
	override init(frame rect: CGRect) {
		
		firstSectionCV 	= TMHorizontalCV(frame: .zero)
		secondSectionCV = TMHorizontalCV(frame: .zero)
		thirdSectionCV 	= TMHorizontalCV(frame: .zero)
		
		super.init(frame: rect)
		
		addSubview(firstSectionCV)
		addSubview(secondSectionCV)
		addSubview(thirdSectionCV)
		
		firstSectionCV.setTitleText("Choose your opponent".localized, animated: false)
		secondSectionCV.setTitleText("Choose board size".localized, animated: false)
		thirdSectionCV.setTitleText("Choose your icon".localized, animated: false)
	}
	required init?(coder aDecoder: NSCoder) { abort() }
	
	override func layoutSubviews() {
		
		let sectionHeight: CGFloat 	= bounds.height/3
		var y: CGFloat = 0
		// Place three sections on the screen equaly
		let firstCollectionFrame 	= CGRect(x: 0, y: y, width: bounds.width, height: sectionHeight)
		y += sectionHeight
		let secondCollectionFrame	= CGRect(x: 0, y: y, width: bounds.width, height: sectionHeight)
		y += sectionHeight
		let thirdCollectionFrame	= CGRect(x: 0, y: y, width: bounds.width, height: sectionHeight)
		y += sectionHeight
		
		firstSectionCV.frame = firstCollectionFrame
		secondSectionCV.frame = secondCollectionFrame
		thirdSectionCV.frame = thirdCollectionFrame
	}
}
