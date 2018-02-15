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
	
	private var playerWinCount = 0 {
		didSet {
			updatePlayerScore(playerWinCount)
		}
	}
	private var opponentWinCount = 0 {
		didSet {
			updateOpponentScore(opponentWinCount)
		}
	}
	// Always true against computer or opponent
	var whoseTurn: BoardCellStatus = .player {
		didSet {
			updateWhoseTurn()
		}
	}
	
	let settings: TMBoardSettings
	var boardBrain: TMBoardBrain
	private let endGameAnimationTime = 2
	
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
		
		updatePlayerScore(0)
		updateOpponentScore(0)
		
		boardCV.customizeForBoardSize(size: settings.boardSize.rawValue)
		boardCV.dataSource = self
		boardCV.delegate = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return boardBrain.boardSize
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return boardBrain.boardSize
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
			boardBrain[indexPath.row, indexPath.section] = whoseTurn
			// Switch turn after a move
			whoseTurn = whoseTurn == .player ? .opponent : .player
			cell.fillCell(withSprite: settings.playerSprite)
		}
		collectionView.deselectItem(at: indexPath, animated: true)
		collectionView.reloadItems(at: [indexPath])
		
		if let winner = boardBrain.isGameOver() {
			endRound(winner: winner)
		}
	}
	
	private func endRound(winner: BoardCellStatus) {
		switch winner {
		case .player:
			playerWinCount += 1
		case .opponent:
			opponentWinCount += 1
		case .none:
			print("MATCH")
		}
		showResults(winner: winner)
		
		// Clear the board
		perform(#selector(clearBoard), with: nil, afterDelay: TimeInterval(endGameAnimationTime))
	}
	
	@objc func clearBoard() {
		boardBrain.resetGame()
		boardCV.reloadSections(IndexSet(integersIn: 0 ..< settings.boardSize.rawValue))
	}
	
	// MARK: - UI changes
	private func updatePlayerScore(_ score: Int) {
		let defaultColor = playerStatus.textColor
		UIView.transition(with: playerStatus, duration: 0.15, options: .transitionCrossDissolve, animations: {
			self.playerStatus.text = String(format: "Player: %d".localized, score)
			self.playerStatus.textColor = .green
		}) { (_) in
			UIView.transition(with: self.playerStatus, duration: 0.25, options: .transitionCrossDissolve, animations: {
				self.playerStatus.textColor = defaultColor
			})
		}
	}
	
	private func updateOpponentScore(_ score: Int) {
		let defaultColor = opponentStatus.textColor
		UIView.transition(with: opponentStatus, duration: 0.15, options: .transitionCrossDissolve, animations: {
			self.opponentStatus.text = String(format: "Opponent: %d".localized, score)
			self.opponentStatus.textColor = .red
		}) { (_) in
			UIView.transition(with: self.opponentStatus, duration: 0.25, options: .transitionCrossDissolve, animations: {
				self.opponentStatus.textColor = defaultColor
			})
		}
	}
	
	private func updateWhoseTurn() {
		switch whoseTurn {
		case .player:
			gameStats.text = "Player turn!".localized
		case .opponent:
			switch settings.opponent! {
			case .computer:
				gameStats.text = "Waiting for a computer".localized
			default:
				gameStats.text = "Opponent turn".localized
			}
		default:
			gameStats.text = "ERROR"
		}
	}
	
	private func showResults(winner: BoardCellStatus) {
		switch winner {
		case .player:
			gameStats.text = "You WIN!".localized
		case .opponent:
			gameStats.text = "You LOSE!".localized
		case .none:
			gameStats.text = "DRAW!".localized
		}
	}
	
	// MARK: - Actions
	@IBAction func optionsTouchUp(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	@IBAction func settigsTouchUp(_ sender: Any) {
		// Call a settings popup
	}
}
