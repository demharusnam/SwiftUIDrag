//
//  SDDistance+Testable.swift
//  
//
//  Created by Mansur Ahmed on 2021-01-14.
//

import SwiftUI
@testable import SwiftUIDrag

extension SDGeometryEngine.SDDistance {
    /**
    Accessory function to simplify testing for the four basic SDCollapseOptions: top, bottom, leading, and trailing.
     
     - Parameters:
        - content: Rect of content to be tested.
        - container: Size of content's parent view.
     
     - Returns: An instance of `SDDistance` to be tested based on the inputted `content` and `container` parameters.
     */
    static func test(
        _ content: CGRect = .init(x: 150, y: 100, width: 100, height: 50),
        in container: CGSize = .init(width: 300, height: 200)
    ) -> SDGeometryEngine.SDDistance {
        .init(content, fromBoundsIn: container)
    }
}
