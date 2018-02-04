//
//  TMHorizontalCV.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMHorizontalCV: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		
		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = false
	}
	required init?(coder aDecoder: NSCoder) { abort() }
}
