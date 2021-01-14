//
//  SDCollapseBounds+Testable.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import SwiftUI
@testable import SwiftUIDrag

extension SDGeometryEngine.SDCollapseBounds {
    /**
     Accessory function to simplify testing for the four basic SDCollapseOptions: top, bottom, leading, and trailing.
     
     - Parameters:
        - option: The *option* to be tested.
     
     - Returns: An instance of `SDCollapseBounds` to be tested based on the appropriate `option`.
     */
    static func test(_ option: SDCollapseOptions) -> SDGeometryEngine.SDCollapseBounds {
        let viewSize = CGSize(width: 300, height: 200)
        let collapseOptions: SDCollapseOptions = .all
        var contentLocation: CGPoint {
            switch option {
            case .top:
                return .init(x: 150, y: 0)
            case .bottom:
                return .init(x: 150, y: 200)
            case .leading:
                return .init(x: 0, y: 100)
            case .trailing:
                return .init(x: 300, y: 100)
            default:
                fatalError("Testing is only for the four basic SDCollapseOptions: top, bottom, leading, or trailing.")
            }
        }
        
        return SDGeometryEngine.SDCollapseBounds(viewSize: viewSize, contentLocation: contentLocation, collapse: collapseOptions)
    }
}
