//
//  TMBoardBrain.swift
//  TicTacToe
//
//  Created by Тарас on 07.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import Foundation

struct TMBoardBrain {
	
	let boardSize: Int
	// How many marks should be putted in a row to win
	var inARow: Int {
		return min(boardSize, 5)
	}
	private var board: [BoardCellStatus]
	
	init(withBoardOfSize size: Int) {
		self.boardSize = size
		self.board = Array(repeating: .none, count: size * size)
	}
	
	private func indexIsValid(row: Int, column: Int) -> Bool {
		return row >= 0 && row < boardSize && column >= 0 && column < boardSize
	}
	
	subscript(row: Int, column: Int) -> BoardCellStatus {
		
		get {
			assert(indexIsValid(row: row, column: column), "Index is out of board bounds")
			return board[row*boardSize + column]
		}
		set {
			assert(indexIsValid(row: row, column: column), "Index is out of board bounds")
			board[row*boardSize + column] = newValue
		}
	}
	
	func isGameOver() -> BoardCellStatus? {
		if let winner = checkMainDiagonal() {
			return winner
		} else if let winner = checkSubDiagonal() {
			return winner
		} else {
			return nil
		}
	}
	
	// Algorythm to check winner
	private func checkMainDiagonal() -> BoardCellStatus? {
		let symb = self[0, 0]
		if symb == .none {
			return nil
		}
		var isWin = true
		for i in 0 ..< boardSize {
			isWin = self[i, i] == symb && isWin
		}
		return isWin ? symb : nil
	}
	
	private func checkSubDiagonal() -> BoardCellStatus? {
		let symb = self[boardSize - 1, 0]
		if symb == .none {
			return nil
		}
		var isWin = true
		for i in 0 ..< boardSize {
			isWin = self[boardSize - i - 1, i] == symb && isWin
		}
		return isWin ? symb : nil
	}
	
	mutating func resetGame() {
		board = Array(repeating: .none, count: boardSize * boardSize)
	}
}
