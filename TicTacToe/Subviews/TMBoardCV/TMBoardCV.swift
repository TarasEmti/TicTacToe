//
//  TMBoardCV.swift
//  TicTacToe
//
//  Created by Тарас on 06.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation
import UIKit

class TMBoardCV: UICollectionView {
	
	func customizeForBoardSize(size: Int) {
		
		backgroundColor = TMGameLib.backgroundColor
		
		let minimumSide: CGFloat 	= min(bounds.width, bounds.height)
		let element: CGFloat 		= minimumSide/CGFloat(size)
		let spacing: CGFloat		= element*0.1
		let itemSize: CGSize		= CGSize(width: element*0.9, height: element*0.9)
		
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = itemSize
		layout.minimumLineSpacing 		= spacing
		layout.minimumInteritemSpacing 	= spacing
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
		
		self.collectionViewLayout = layout
		self.register(TMBoardCVCell.self, forCellWithReuseIdentifier: TMBoardCVCell.reuseIdentifier())
	}
}
