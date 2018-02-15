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
		
		// First we check main diagonal
		if let winner = checkMainDiagonal() {
			return winner
			// Then we check sub diagonal
		} else if let winner = checkSubDiagonal() {
			return winner
			// Then we check both lines horizontal & vertical
		} else if let winner = checkLines() {
			return winner
			// If we still don't have a winner, check if game is over
		} else if checkDraw() {
			return BoardCellStatus.none
		} else {
			// Return nil because game is not over yet
			return nil
		}
	}
	
	// Algorythm to check winner
	private func checkMainDiagonal() -> BoardCellStatus? {
		let symb = self[0, 0]
		// skip iterations if cell is empty
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
		// skip iterations if cell is empty
		if symb == .none {
			return nil
		}
		var isWin = true
		for i in 0 ..< boardSize {
			isWin = self[boardSize - i - 1, i] == symb && isWin
		}
		return isWin ? symb : nil
	}
	
	private func checkLines() -> BoardCellStatus? {
		for row in 0 ..< boardSize {
			// skip iterations if cell is empty
			if self[row, 0] == .none {
				continue
			}
			let symb = self[row, 0]
			var cols = true
			var rows = true
			for col in 0 ..< boardSize {
				rows = rows && (self[row, col] == symb)
				cols = cols && (self[col, row] == symb)
			}
			if cols || rows {
				return symb
			}
		}
		return nil
	}
	
	private func checkDraw() -> Bool {
		for cell in board where cell == .none {
			return false
		}
		return true
	}
	
	mutating func resetGame() {
		board = Array(repeating: .none, count: boardSize * boardSize)
	}
}
