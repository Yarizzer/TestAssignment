//
//  StyleManager.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

import UIKit

class StyleManager {
	//MARK: - Style
	private enum StyleColors {
		case clear
		case white
		case black
		case lightGray
		case darkGray
		case red
		case green
		
		var color: UIColor {
			switch self {
			case .clear:        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
			case .white:        return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			case .black:        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			case .lightGray:    return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)      // hex: CDCDCD
			case .darkGray:     return #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)      // hex: 3C3C3C
			case .red:          return #colorLiteral(red: 1, green: 0.3137254902, blue: 0, alpha: 1)      // hex: FF5000
			case .green:        return #colorLiteral(red: 0, green: 0.6666666667, blue: 0.3137254902, alpha: 1)      // hex: 00AA50
			}
		}
	}
}

extension StyleManager: StyleManageable {
	//Colors
	var colorClear: UIColor { return StyleColors.clear.color }
	
	var colorWhite: UIColor { return StyleColors.white.color }
	
	var colorBlack: UIColor { return StyleColors.black.color }
	
	var colorLightGray: UIColor { return StyleColors.lightGray.color }
	
	var colorDarkGray: UIColor { return StyleColors.darkGray.color }
	
	var colorRed: UIColor { return StyleColors.red.color }
	
	var colorGreen: UIColor { return StyleColors.green.color }
	
	//Fonts
	var labelTitleFontLarge: UIFont { return UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)! }
	
	var labelTitleFontMedium: UIFont { return UIFont(name: "AppleSDGothicNeo-UltraLight", size: 15)! }
	
	var labelTitleFontSmall: UIFont { return UIFont(name: "AppleSDGothicNeo-UltraLight", size: 12)! }
}
