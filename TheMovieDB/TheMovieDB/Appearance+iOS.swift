//
//  Appearance+iOS.swift
//  TheMovieDB
//
//  Created by Santex on 11/27/16.
//  Copyright © 2016 coderpug. All rights reserved.
//

import Foundation
import UIKit

func globalAppearance() {
    
    let navigationBarAppearace = UINavigationBar.appearance()
    navigationBarAppearace.tintColor = Appearance.Colors.first
    navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: Appearance.Colors.first,
                                                  NSFontAttributeName: Appearance.Fonts.h1]
}
