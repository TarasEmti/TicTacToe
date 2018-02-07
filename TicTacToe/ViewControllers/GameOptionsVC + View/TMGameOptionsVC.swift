//
//  TMGameOptionsVC.swift
//  TicTacToe
//
//  Created by Тарас on 03.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMGameOptionsVC: TMBaseVC, UICollectionViewDataSource, UICollectionViewDelegate {
	
	private var goView: TMGameOptionsView!
	private var opponentsCV: UICollectionView!
	private var boardSizesCV: UICollectionView!
	private var spritesCV: UICollectionView!
	
	private let gameOptions = TMBoardVariables()
	private var gameSettings = TMBoardSettings()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) { abort() }

    override func viewDidLoad() {
        super.viewDidLoad()
		
		goView = TMGameOptionsView()
		view.addSubview(goView)
		
		// Bind outlets
		opponentsCV 	= goView.firstSectionCV.collectionView
		boardSizesCV 	= goView.secondSectionCV.collectionView
		spritesCV 		= goView.thirdSectionCV.collectionView
		
		// Sections appearence
		opponentsCV.backgroundColor 	= TMGameLib.opponentSectionColor
		boardSizesCV.backgroundColor 	= TMGameLib.boardSectionColor
		spritesCV.backgroundColor 		= TMGameLib.spriteSectionColor
		
		opponentsCV.dataSource = self
		opponentsCV.delegate = self
		
		boardSizesCV.dataSource = self
		boardSizesCV.delegate = self
		
		spritesCV.dataSource = self
		spritesCV.delegate = self
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		goView.frame = view.bounds
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	// MARK: - UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		switch collectionView {
		case opponentsCV:
			return gameOptions.boards.count
		case boardSizesCV:
			return gameOptions.opponents.count
		case spritesCV:
			return gameOptions.sprites.count
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMGameOptionCVCell.reuseIdentifier(), for: indexPath) as? TMGameOptionCVCell else {
			return UICollectionViewCell()
		}
		// Fill our static cells on each section
		switch collectionView {
		case opponentsCV:
			let opponent = gameOptions.opponents[indexPath.row]
			switch opponent {
			case .computer:
				cell.imageView.image = UIImage(named: "opponent_ai")
				cell.titleLabel.text = "AI".localized
			case .player:
				cell.imageView.image = UIImage(named: "opponent_player")
				cell.titleLabel.text = "Player".localized
			case .wifi:
				cell.imageView.image = UIImage(named: "opponent_wifi")
				cell.titleLabel.text = "Wi-Fi".localized
			}
			// Cell cutomization
			cell.imageView.tintColor = .black
			cell.titleLabel.font 	= TMGameLib.commonOptionsFont
			cell.backgroundColor 	= TMGameLib.opponentSectionColor
			cell.stateDeselectColor = TMGameLib.opponentSectionColor
			cell.stateSelectColor 	= TMGameLib.opponentCellSelected
			cell.layer.borderColor 	= TMGameLib.opponentCellBorderColor.cgColor
			return cell
			
		case boardSizesCV:
			let boardSize = gameOptions.boards[indexPath.row]
			cell.imageView.isHidden = true
			cell.titleLabel.textColor = .white
			cell.titleLabel.text = String(format: "%d✕%d", boardSize.rawValue, boardSize.rawValue)
			cell.titleLabel.font = TMGameLib.headerOptionsFont
			cell.backgroundColor 	= TMGameLib.boardSectionColor
			cell.stateDeselectColor = TMGameLib.boardSectionColor
			cell.stateSelectColor 	= TMGameLib.boardCellSelected
			cell.layer.borderColor = TMGameLib.boardCellBorderColor.cgColor
			return cell
			
		case spritesCV:
			let sprite = gameOptions.sprites[indexPath.row]
			cell.titleLabel.isHidden = true
			switch sprite {
			case .circle:
				cell.imageView.image = UIImage(named: "sprite_circle")
			case .cross:
				cell.imageView.image = UIImage(named: "sprite_cross")
			case .triangle:
				cell.imageView.image = UIImage(named: "sprite_triangle")
			}
			cell.imageView.tintColor = .black
			cell.backgroundColor 	= TMGameLib.spriteSectionColor
			cell.stateDeselectColor = TMGameLib.spriteSectionColor
			cell.stateSelectColor 	= TMGameLib.spriteCellSelected
			cell.layer.borderColor 	= TMGameLib.spriteCellBorderColor.cgColor
			return cell
			
		default:
			return UICollectionViewCell()
		}
	}
	
	// MARK: - UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		switch collectionView {
		case opponentsCV:
			gameSettings.opponent 	= gameOptions.opponents[indexPath.row]
		case boardSizesCV:
			gameSettings.board = gameOptions.boards[indexPath.row]
		case spritesCV:
			if gameSettings.playerSprite == nil {
				gameSettings.playerSprite = gameOptions.sprites[indexPath.row]
				goView.thirdSectionCV.setTitleText("Choose opponent icon".localized, animated: true)
			} else {
				gameSettings.opponentSprite = gameOptions.sprites[indexPath.row]
			}
		default:
			return
		}
		checkIsGameReady()
	}
	
	private func checkIsGameReady() {
		
		// Check if all settings are set
		guard
			gameSettings.board != nil,
			gameSettings.opponent != nil,
			gameSettings.playerSprite != nil,
			gameSettings.opponentSprite != nil else {
			return
		}
		// Let's play the game!
		let board = TMBoardVC()
		board.settings = gameSettings
		navigationController?.show(board, sender: self)
	}
}
