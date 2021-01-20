//
//  StyleManageable.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

import UIKit

protocol StyleManageable {
	//Colors
	var colorClear: UIColor { get }
	var colorWhite: UIColor { get }
	var colorBlack: UIColor { get }
	var colorLightGray: UIColor { get }
	var colorDarkGray: UIColor { get }
	var colorRed: UIColor { get }
	var colorGreen: UIColor { get }
	
	//Fonts
	var labelTitleFontLarge: UIFont { get }
	var labelTitleFontMedium: UIFont { get }
	var labelTitleFontSmall: UIFont { get }
}
