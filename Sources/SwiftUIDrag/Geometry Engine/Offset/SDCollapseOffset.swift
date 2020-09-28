import SwiftUI

// MARK: Collapse Offset Engine
internal extension SDGeometryEngine {
    /// The engine managing the collapsed offset calcluations for the content in the SDView.
    struct CollapseOffset: SDOffsets {
        /// The collapse offset for the content to translate *to the top* boundary of the SDView.
        let toTop: CGFloat
        
        /// The collapse offset for the content to translate *to the bottom* boundary of the SDView.
        let toBottom: CGFloat
        
        /// The collapse offset for the content to translate *to the leading* boundary of the SDView.
        let toLeading: CGFloat
        
        /// The collapse offset for the content to translate *to the trailing* boundary of the SDView.
        let toTrailing: CGFloat

        /**
         Instantiates a new engine managing all collapsed offset calculations.
         
         - Parameters:
            - distanceFrom: The distance of the content from the boundaries of the SDView.
            - visibleSize: The visible size of the content upon collapse.
         */
        init(distanceFrom content: SDDistance, visibleSize: CGSize) {
            self.toLeading = content.toLeading + visibleSize.width
            self.toTrailing = content.toTrailing - visibleSize.width
            self.toTop = content.toTop + visibleSize.height
            self.toBottom = content.toBottom - visibleSize.height
        }
    }
}
