//
//  CustomFloatingPanelLayout.swift
//  MapApp
//
//  Created by yuta sasaki on 2020/01/25.
//  Copyright © 2020 rain-00-00-09. All rights reserved.
//

import Foundation
import FloatingPanel


class CustomFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom
    
    var initialState: FloatingPanelState = .half
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 262, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }

    // セミモーダルビューの背景Viewの透明度
    private func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}

