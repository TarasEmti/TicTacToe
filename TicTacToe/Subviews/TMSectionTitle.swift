//
//  TMSectionTitle.swift
//  TicTacToe
//
//  Created by Тарас on 06.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMSectionTitle: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = TMGameLib.genericLabelColor
		layer.borderWidth = 3
		layer.borderColor = TMGameLib.genericLabelBorderColor.cgColor
		textColor = .black
		textAlignment = .center
		font = TMGameLib.commonOptionsFont
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
