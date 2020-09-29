import SwiftUI

// MARK: Collapse Bounds
internal extension SDGeometryEngine {
    /// An engine determining whether the dragged content is within any set collapse boundaries of the SDView.
    struct SDCollapseBounds {
        /// The determinant of whether the dragged content is within the *top* collapse boundary.
        let top: Bool
        
        /// The determinant of whether the dragged content is within the *bottom* collapse boundary.
        let bottom: Bool
        
        /// The determinant of whether the dragged content is within the *leading* collapse boundary.
        let leading: Bool
        
        /// The determinant of whether the dragged content is within the *trailing* collapse boundary.
        let trailing: Bool
        
        /// The determinant of whether the dragged content is within the top or bottom collapse boundaries.
        var vertical: Bool { top || bottom }
        
        /// The determinant of whether the dragged content is within the leading or trailing collapse boundaries.
        var horizontal: Bool { leading || trailing }
        
        /// The determinant of whether the dragged content is within any collapse boundaries at all..
        var inBounds: Bool { vertical || horizontal }
        
        /// The enumerated semantic value of the content state.
        var state: SDContentState {
            if top {
                return .top
            } else if bottom {
                return .bottom
            } else if leading {
                return .leading
            } else if trailing {
                return .trailing
            }
            
            return .expanded
        }
        
        /**
         Instantiates an engine to determine whether the dragged content is in any collapse boundaries.
         
         - Parameters:
                - viewSize: The size of the SDView containing the content.
                - contentLocation: The *location of the content* in the SDView.
                - collapse: The collapse configuration of the content in the SDView.
         */
        init(viewSize: CGSize, contentLocation: CGPoint, collapse: SDCollapseOptions) {
            let topBound: CGFloat = viewSize.height * 0.15
            let bottomBound: CGFloat = viewSize.height - topBound
            let trailingBound: CGFloat = viewSize.width * 0.85
            let leadingBound: CGFloat = viewSize.width - trailingBound
            
            let top: Bool = contentLocation.y <= topBound
            let bottom: Bool = contentLocation.y >= bottomBound
            let leading: Bool = contentLocation.x <= leadingBound
            let trailing: Bool = contentLocation.x >= trailingBound
            
            self.top = top && collapse.contains(.top)
            self.bottom = bottom && collapse.contains(.bottom)
            self.leading = leading && collapse.contains(.leading)
            self.trailing = trailing && collapse.contains(.trailing)
        }
    }
}
