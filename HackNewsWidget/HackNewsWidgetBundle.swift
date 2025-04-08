//
//  HackNewsWidgetBundle.swift
//  HackNewsWidget
//
//  Created by Omer Cagri Sayir on 8.04.2025.
//

import WidgetKit
import SwiftUI

@main
struct HackNewsWidgetBundle: WidgetBundle {
    var body: some Widget {
        HackNewsWidget()
        HackNewsWidgetControl()
        HackNewsWidgetLiveActivity()
    }
}
