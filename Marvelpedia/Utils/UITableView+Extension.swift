//
//  UITableView+Extension.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 08/06/2022.
//

import Foundation
import UIKit

enum ScrollingDirection {
    case up
    case down
}

extension UITableView {
    func scrollingDirection() -> ScrollingDirection {
        panGestureRecognizer.translation(in: superview).y > 0 ? .up : .down
    }
}
