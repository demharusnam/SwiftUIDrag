import SwiftUI

// MARK: Offset Engine

/// The requirements for all offset configurations.
internal protocol SDOffsets {
    var toTop: CGFloat { get }
    var toBottom: CGFloat { get }
    var toLeading: CGFloat { get }
    var toTrailing: CGFloat { get }
}

internal extension SDGeometryEngine {
    /// The engine that manages all offset calculations upon drag end of the content.
    struct SDOffset: SDOffsets {
        /// The computed floating/collapse offset for the content to translate *to the top* boundary of the SDView.
        var toTop: CGFloat {
            print("tT 1")
            if inFloatingBounds.topLeading || inFloatingBounds.topTrailing {
                print("tT 2")
                return floatingOffset.toTop
            } else if inCollapseBounds.top {
                print("tT 3")
                return collapseOffset.toTop
            }
            
            return 0
        }
        
        /// The computed floating/collapse offset for the content to translate *to the bottom* boundary of the SDView.
        var toBottom: CGFloat {
            if inFloatingBounds.bottomLeading || inFloatingBounds.bottomTrailing {
                return floatingOffset.toBottom
            } else if inCollapseBounds.bottom {
                return collapseOffset.toBottom
            }
            
            return 0
        }
        
        /// The computed floating/collapse offset for the content to translate *to the leading* boundary of the SDView.
        var toLeading: CGFloat {
            if inFloatingBounds.topLeading || inFloatingBounds.bottomLeading {
                return floatingOffset.toLeading
            } else if inCollapseBounds.leading {
                return collapseOffset.toLeading
            }
            
            return 0
        }
        
        /// The computed floating/collapse offset for the content to translate *to the trailing* boundary of the SDView.
        var toTrailing: CGFloat {
            if inFloatingBounds.topTrailing || inFloatingBounds.bottomTrailing {
                return floatingOffset.toTrailing
            } else if inCollapseBounds.trailing {
                return collapseOffset.toTrailing
            }
            
            return 0
        }
        
        /// The computed y-value offset of the content upon drag end.
        var y: CGFloat {
            if inFloatingBounds.inBounds {
                switch inFloatingBounds.state {
                case .topLeading, .topTrailing:
                    return floatingOffset.toTop
                case .bottomLeading, .bottomTrailing:
                    return floatingOffset.toBottom
                default:
                    break
                }
            } else if inCollapseBounds.inBounds {
                switch inCollapseBounds.state {
                case .top:
                    return collapseOffset.toTop
                case .bottom:
                    return collapseOffset.toBottom
                default:
                    return drag.translation.height
                }
            }
            
            return 0
        }
        
        /// The computed x-value offset of the content upon drag end.
        var x: CGFloat {
            if inFloatingBounds.inBounds {
                switch inFloatingBounds.state {
                case .topLeading, .bottomLeading:
                    return floatingOffset.toLeading
                case .topTrailing, .bottomTrailing:
                    return floatingOffset.toTrailing
                default:
                    break
                }
            } else if inCollapseBounds.inBounds {
                switch inCollapseBounds.state {
                case .leading:
                    return collapseOffset.toLeading
                case .trailing:
                    return collapseOffset.toTrailing
                default:
                    return drag.translation.width
                }
            }
            
            return 0
        }
        
        /// The  offset configuration for out-of-bounds content drag.
        var unsafe: SDFloatingOffset { floatingOffset }
        
        /// The engine determining whether the content has ended drag *within floating boundaries*.
        private let inFloatingBounds: SDFloatingBounds
        
        /// The engine determining whether the content has ended drag *within collapse boundaries*.
        private let inCollapseBounds: SDCollapseBounds
        
        /// The engine that manages floating offset calculations upon drag end of the content.
        private let floatingOffset: SDFloatingOffset
        
        /// The engine that manages collapse offset calculations upon drag end of the content.
        private let collapseOffset: CollapseOffset
        
        /// The drag gesture value upon content drag end.
        private let drag: DragGesture.Value
        
        /**
         Instantiates a new engine to determine and calculate all applicable offsets for the content in the SDView.
         
         - Parameters:
            - distanceFrom: The distance of the content from the frame boundaries of the SDView.
            - visibleSize: The visible size of the content once collapsed.
            - contentLocation: The location of the content in the SDView.
            - viewSize: The size of the SDView.
            - floatingOptions: The set of all valid floating options for the content.
            - collapseOptions: The set of all valid collapse options for the content.
         */
        init(
            distanceFrom content: SDDistance,
            visibleSize: CGSize,
            contentLocation: CGPoint,
            viewSize: CGSize,
            floatingOptions: SDFloatingOptions,
            collapseOptions: SDCollapseOptions,
            drag: DragGesture.Value
        ) {
            self.inFloatingBounds = SDFloatingBounds(viewSize: viewSize, contentLocation: contentLocation, floating: floatingOptions, collapse: collapseOptions)
            self.inCollapseBounds = SDCollapseBounds(viewSize: viewSize, contentLocation: contentLocation, collapse: collapseOptions)
            self.floatingOffset = SDFloatingOffset(distanceFrom: content)
            self.collapseOffset = CollapseOffset(distanceFrom: content, visibleSize: visibleSize)
            self.drag = drag
        }
    }
}
