//
//  TMBoardVC.swift
//  TicTacToe
//
//  Created by Тарас on 06.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation
import UIKit

class TMBoardVC: TMBaseVC, UICollectionViewDataSource, UICollectionViewDelegate {
	
	@IBOutlet weak var boardCV: TMBoardCV!
	@IBOutlet weak var playerStatus: UILabel!
	@IBOutlet weak var opponentStatus: UILabel!
	@IBOutlet weak var gameStats: UILabel!
	@IBOutlet weak var turnTimerProgress: UIProgressView!
	
	let settings: TMBoardSettings
	var boardBrain: TMBoardBrain
	
	init(withSettings settings: TMBoardSettings) {
		self.settings = settings
		self.boardBrain = TMBoardBrain(withBoardOfSize: settings.boardSize.rawValue)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		abort()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		boardCV.customizeForBoardSize(size: settings.boardSize.rawValue)
		boardCV.dataSource = self
		boardCV.delegate = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return boardBrain.rows
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return boardBrain.columns
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMBoardCVCell.reuseIdentifier(), for: indexPath) as? TMBoardCVCell else {
			return UICollectionViewCell()
		}
		
		switch boardBrain[indexPath.row, indexPath.section] {
		case .none:
			cell.sprite.image = nil
		case .player:
			cell.sprite.image = UIImage(named: settings.playerSprite.rawValue)
		case .opponent:
			cell.sprite.image = UIImage(named: settings.opponentSprite.rawValue)
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMBoardCVCell.reuseIdentifier(), for: indexPath) as? TMBoardCVCell else {
			return
		}
		
		if boardBrain[indexPath.row, indexPath.section] == .none {
			boardBrain[indexPath.row, indexPath.section] = .player
			cell.fillCell(withSprite: settings.playerSprite)
		} else {
			boardBrain[indexPath.row, indexPath.section] = .none
			cell.sprite.image = nil
		}
		collectionView.deselectItem(at: indexPath, animated: true)
		collectionView.reloadItems(at: [indexPath])
	}
	
	// MARK: - Actions
	
	@IBAction func optionsTouchUp(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	@IBAction func settigsTouchUp(_ sender: Any) {
		boardCV.reloadData()
	}
}
