//
//  TMGame.swift
//  TicTacToe
//
//  Created by Тарас on 04.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation

enum BoardCellStatus {
	case cross
	case circle
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

enum SpriteImage {
	case cross
	case circle
	case triangle
}

struct TMBoardVariables {
	let opponents: [OpponentType] = [.player, .computer, .wifi]
	let boards: [BoardSize] = [.small, .medium, .large]
	let sprites: [SpriteImage] = [.cross, .circle, .triangle]
}

struct TMBoardSettings {
	var opponent: OpponentType!
	var board: BoardSize!
	var playerSprite: SpriteImage!
	var opponentSprite: SpriteImage!
	
	init(opponent: OpponentType? = nil, board: BoardSize? = nil, playerSprite: SpriteImage? = nil, opponentSprite: SpriteImage? = nil) {
		
		self.opponent = opponent
		self.board = board
		self.playerSprite = playerSprite
		self.opponentSprite = opponentSprite
	}
}
