//
//  TMBoardBrain.swift
//  TicTacToe
//
//  Created by Тарас on 07.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation

struct TMBoardBrain {
	
	let rows: Int
	let columns: Int
	private var board: [BoardCellStatus]
	
	init(withBoardOfSize size: Int) {
		self.rows = size
		self.columns = size
		self.board = Array(repeating: .none, count: rows * columns)
	}
	
	private func indexIsValid(row: Int, column: Int) -> Bool {
		return row >= 0 && row < rows && column >= 0 && column < columns
	}
	
	subscript(row: Int, column: Int) -> BoardCellStatus {
		
		get {
			assert(indexIsValid(row: row, column: column), "Index is out of board bounds")
			return board[column*rows + row]
		}
		set {
			assert(indexIsValid(row: row, column: column), "Index is out of board bounds")
			board[column*rows + row] = newValue
		}
	}
	
	func isGameOver() -> BoardCellStatus {
		return .player
	}
}
