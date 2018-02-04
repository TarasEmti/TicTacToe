//
//  TMGameOptionsVC.swift
//  TicTacToe
//
//  Created by Тарас on 03.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

enum OpponentType {
	case player
	case computer
	case wifi
}

enum BoardSize: Int {
	case small 	= 3
	case medium = 6
	case large 	= 9
}

enum SpriteImage {
	case cross
	case circle
	case triangle
}

struct TMGameOptions {
	let opponents: [OpponentType] = [.player, .computer, .wifi]
	let boards: [BoardSize] = [.small, .medium, .large]
	let sprites: [SpriteImage] = [.cross, .circle, .triangle]
}

struct TMGameSettings {
	var opponent: OpponentType?
	var board: BoardSize?
	var playerSprite: SpriteImage?
	var opponentSprite: SpriteImage?
}

class TMGameOptionsVC: TMBaseVC, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var optionsView: TMGameOptionsView!
	var chooseOpponentCV: TMHorizontalCV!
	var chooseBoardCV: TMHorizontalCV!
	var chooseSpriteCV: TMHorizontalCV!
	let gameOptions = TMGameOptions()
	var gameSettings = TMGameSettings(opponent: nil, board: nil, playerSprite: nil, opponentSprite: nil)
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) { abort() }

    override func viewDidLoad() {
        super.viewDidLoad()
		
		optionsView = TMGameOptionsView()
		view.addSubview(optionsView)
		
		chooseOpponentCV = optionsView.firstSectionCV
		chooseBoardCV = optionsView.secondSectionCV
		chooseSpriteCV = optionsView.thirdSectionCV
		
		chooseOpponentCV.backgroundColor 	= TMGameLib.opponentSectionColor
		chooseBoardCV.backgroundColor 		= TMGameLib.boardSectionColor
		chooseSpriteCV.backgroundColor 		= TMGameLib.spriteSectionColor
		
		chooseOpponentCV.dataSource = self
		chooseOpponentCV.delegate = self
		chooseBoardCV.dataSource = self
		chooseBoardCV.delegate = self
		chooseSpriteCV.dataSource = self
		chooseSpriteCV.delegate = self
		
		chooseOpponentCV.register(TMGameOptionCVCell.nib(), forCellWithReuseIdentifier: TMGameOptionCVCell.reuseIdentifier())
		chooseBoardCV.register(TMGameOptionCVCell.nib(), forCellWithReuseIdentifier: TMGameOptionCVCell.reuseIdentifier())
		chooseSpriteCV.register(TMGameOptionCVCell.nib(), forCellWithReuseIdentifier: TMGameOptionCVCell.reuseIdentifier())
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		optionsView.frame = view.bounds
		optionsView.setNeedsLayout()
		optionsView.layoutIfNeeded()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	// MARK: - UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		switch collectionView {
		case chooseBoardCV:
			return gameOptions.boards.count
		case chooseOpponentCV:
			return gameOptions.opponents.count
		case chooseSpriteCV:
			return gameOptions.sprites.count
		default:
			return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMGameOptionCVCell.reuseIdentifier(), for: indexPath) as? TMGameOptionCVCell else {
			return UICollectionViewCell()
		}
		switch collectionView {
		case chooseOpponentCV:
			
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
		case chooseBoardCV:
			
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
			
		case chooseSpriteCV:
			
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
		case chooseOpponentCV:
			gameSettings.opponent 	= gameOptions.opponents[indexPath.row]
		case chooseBoardCV:
			gameSettings.board = gameOptions.boards[indexPath.row]
		case chooseSpriteCV:
			
			if gameSettings.playerSprite == nil {
				gameSettings.playerSprite = gameOptions.sprites[indexPath.row]
				optionsView.thirdSectionLabel.text = "Choose opponent icon".localized
			} else {
				gameSettings.opponentSprite = gameOptions.sprites[indexPath.row]
			}
		default:
			return
		}
	}
}
