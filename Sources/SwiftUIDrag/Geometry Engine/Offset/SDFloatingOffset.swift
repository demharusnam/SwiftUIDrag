import SwiftUI

// MARK: Floating Offset Engine
internal extension SDGeometryEngine {
    /// The engine managing the floating offset calcluations for the content in the SDView.
    struct SDFloatingOffset: SDOffsets {
        /// The floating offset for the content to translate *to the top* boundary of the SDView.
        let toTop: CGFloat
        
        /// The floating offset for the content to translate *to the bottom* boundary of the SDView.
        let toBottom: CGFloat
        
        /// The floating offset for the content to translate *to the leading* boundary of the SDView.
        let toLeading: CGFloat
        
        /// The floating offset for the content to translate *to the trailing* boundary of the SDView.
        let toTrailing: CGFloat
        
        /**
         Instantiates a new engine managing all floating offset calculations.
         
         - Parameters:
            - distanceFrom: The distance of the content from the boundaries of the SDView.
         */
        init(distanceFrom content: SDDistance) {
            let contentHeight: CGFloat = content.contentSize.height
            let contentWidth: CGFloat = content.contentSize.width
            
            self.toTop = content.toTop + contentHeight
            self.toBottom = content.toBottom - contentHeight
            self.toLeading = content.toLeading + contentWidth
            self.toTrailing = content.toTrailing - contentWidth
        }
    }
}
