//
//  TMBoardVC.swift
//  TicTacToe
//
//  Created by Тарас on 06.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation
import UIKit

class TMBoardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	@IBOutlet weak var boardCV: TMBoardCV!
	@IBOutlet weak var playerStatus: UILabel!
	@IBOutlet weak var opponentStatus: UILabel!
	@IBOutlet weak var gameStats: UILabel!
	@IBOutlet weak var turnTimerProgress: UIProgressView!
	
	var settings = TMBoardSettings()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		boardCV.customizeForBoardSize(size: settings.board.rawValue)
		boardCV.dataSource = self
		boardCV.delegate = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return settings.board.rawValue * settings.board.rawValue
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMBoardCVCell.reuseIdentifier(), for: indexPath)
		cell.backgroundColor = .yellow
		return cell
	}
	
	// MARK: - Actions
	
	@IBAction func optionsTouchUp(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
}
