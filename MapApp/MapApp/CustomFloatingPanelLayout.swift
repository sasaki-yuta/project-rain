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
    // セミモーダルビューの初期位置
    var initialPosition: FloatingPanelPosition {
        return .half
    }

    var topInteractionBuffer: CGFloat {
        return 0.0
    }
    
    var bottomInteractionBuffer: CGFloat {
        return 0.0
    }

    // セミモーダルビューの各表示パターンの高さを決定するためのInset
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        var ret: CGFloat!
        switch position {
        case .full:
            ret = nil//56.0
        case .half:
            ret = 262.0
        case .tip:
            ret = 50.0
        default:
            ret = nil
        }
        return ret
    }

    // セミモーダルビューの背景Viewの透明度
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}

