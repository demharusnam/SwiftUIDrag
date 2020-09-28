import SwiftUI

// MARK: Distance Engine
internal extension SDGeometryEngine {
    /// An engine determining the distance of the content from the SDView frame boundaries.
    struct SDDistance {
        /// The distance to travel from the content location *to the top* boundary of the SDView.
        let toTop: CGFloat
        
        /// The distance to travel from the content location *to the bottom* boundary of the SDView.
        let toBottom: CGFloat
        
        /// The distance to travel from the content location *to the leading* boundary of the SDView.
        let toLeading: CGFloat
        
        /// The distance to travel from the content location *to the trailing* boundary of the SDView.
        let toTrailing: CGFloat
        
        /// The *size of the content*.
        let contentSize: CGSize
        
        /**
         Instantiates a new engine determining the distance of the content from the SDView frame boundaries.
         
         - Parameters:
            - content: The rect of the content in the SDView.
            - fromBoundsIn: The size of the SDView.
         */
        init(_ content: CGRect, fromBoundsIn container: CGSize) {
            self.contentSize = content.size
            self.toLeading = -content.maxX
            self.toTrailing = container.width - content.minX
            self.toTop = -content.maxY
            self.toBottom = container.height - content.minY
        }
    }
}
