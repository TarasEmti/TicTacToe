//
//  TMGame.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation

enum BoardCellStatus {
	case player
	case opponent
	case none
}

struct TMGame {
	let settings: TMBoardSettings
}

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

enum SpriteImage: String {
	case cross 		= "sprite_cross"
	case circle 	= "sprite_circle"
	case triangle 	= "sprite_triangle"
}

struct TMBoardVariables {
	let opponents: [OpponentType] = [.player, .computer, .wifi]
	let boards: [BoardSize] = [.small, .medium, .large]
	let sprites: [SpriteImage] = [.cross, .circle, .triangle]
}

struct TMBoardSettings {
	var opponent: OpponentType!
	var boardSize: BoardSize!
	var playerSprite: SpriteImage!
	var opponentSprite: SpriteImage!
	
	init(opponent: OpponentType? = nil, boardSize: BoardSize? = nil, playerSprite: SpriteImage? = nil, opponentSprite: SpriteImage? = nil) {
		
		self.opponent = opponent
		self.boardSize = boardSize
		self.playerSprite = playerSprite
		self.opponentSprite = opponentSprite
	}
}
