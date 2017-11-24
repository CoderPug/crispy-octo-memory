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
    navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Appearance.Colors.first,
                                                  NSAttributedStringKey.font: Appearance.Fonts.h1]
}
