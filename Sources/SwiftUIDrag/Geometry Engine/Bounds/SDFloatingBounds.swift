import SwiftUI

// MARK: Floating Bounds
internal extension SDGeometryEngine {
    /// An engine determining whether the dragged content is within any set floating boundaries of the SDView.
    struct SDFloatingBounds {
        /// The determinant of whether the dragged content is within the *top leading* floating boundary.
        let topLeading: Bool
        
        /// The determinant of whether the dragged content is within the *top trailing* floating boundary.
        let topTrailing: Bool
        
        /// The determinant of whether the dragged content is within the *bottom leading* floating boundary.
        let bottomLeading: Bool
        
        /// The determinant of whether the dragged content is within the *bottom trailing* floating boundary.
        let bottomTrailing: Bool
        
        /// The enumerated semantic value of the content state.
        var state: SDContentState {
            if topLeading {
                return .topLeading
            } else if topTrailing {
                return .topTrailing
            } else if bottomLeading {
                return .bottomLeading
            } else if bottomTrailing {
                return .bottomTrailing
            }
            
            return .expanded
        }
        
        /// The determinant of whether the dragged content is within any floating boundaries at all..
        var inBounds: Bool {
            return topLeading || topTrailing || bottomLeading || bottomTrailing
        }
        
        /**
         Instantiates an engine to determine whether the dragged content is in any floating boundaries.
         
         - Parameters:
                - viewSize: The size of the SDView containing the content.
                - contentLocation: The *location of the content* in the SDView.
                - floating: The floating configuration of the content in the SDView.
                - collapse: The collapse configuration of the content in the SDView.
         */
        init(viewSize: CGSize, contentLocation: CGPoint, floating: SDFloatingOptions, collapse: SDCollapseOptions) {
            let upperBoundTop: CGFloat = viewSize.height * (collapse.contains(.top) ? 0.15 : -1.5)
            let lowerBoundTop: CGFloat = viewSize.height * 0.35
            let upperBoundBottom: CGFloat = viewSize.height * (collapse.contains(.bottom) ? 0.85 : 1.5)
            let lowerBoundBottom: CGFloat = viewSize.height * 0.65
            
            let upperBoundLeading: CGFloat = viewSize.width * (collapse.contains(.leading) ? 0.15 : -1.5)
            let lowerBoundLeading: CGFloat = viewSize.width * 0.35
            let upperBoundTrailing: CGFloat = viewSize.width * (collapse.contains(.trailing) ? 0.85 : 1.5)
            let lowerBoundTrailing: CGFloat = viewSize.width * 0.65
            
            let trailing: Bool = contentLocation.x >= lowerBoundTrailing && contentLocation.x < upperBoundTrailing
            let leading: Bool = contentLocation.x <= lowerBoundLeading && contentLocation.x > upperBoundLeading
            let top: Bool = contentLocation.y <= lowerBoundTop && contentLocation.y > upperBoundTop
            let bottom: Bool = contentLocation.y >= lowerBoundBottom && contentLocation.y < upperBoundBottom
            
            let topLeading = top && leading
            let topTrailing = top && trailing
            let bottomLeading = bottom && leading
            let bottomTrailing = bottom && trailing
            
            self.topLeading = topLeading && floating.contains(.topLeading)
            self.topTrailing = topTrailing && floating.contains(.topTrailing)
            self.bottomLeading = bottomLeading && floating.contains(.bottomLeading)
            self.bottomTrailing = bottomTrailing && floating.contains(.bottomTrailing)
        }
    }
}
