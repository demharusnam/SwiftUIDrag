import SwiftUI

// MARK: Drag State
internal extension SDView {
    /// The drag-state of the content.
    enum SDDragState {
        /// A `DragState` describing an inactive drag.
        case inactive
        
        /// A `DragState` describing an active tap.
        case tap
        
        /// A `DragState` describing an active drag.
        case dragging(drag: CGSize)
        
        /// The translation of an active drag.
        var translation: CGSize {
            switch self {
            case .inactive, .tap:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        /// Determines whether a tap or drag is active.
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .tap, .dragging:
                return true
            }
        }
        
        /// Determines whether a drag is active.
        var isDragging: Bool {
            switch self {
            case .inactive, .tap:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    /**
     Adjusts drag of content  to remain within safe view bounds.
     
     The dragged content is offseted such that only the `visibleWidth` as determined by the user  is visible within the SDView. The vertical drag is offseted such that it remains within safe vertical bounds of the SDView. The `contentDrag` is updated as a result.
     
     - Parameters:
        - value: The `DragGesture` *value* of the content upon drag end.
        - viewSize: The *size of the view* containing the content drag.
     */
    func boundToSafeArea(_ value: DragGesture.Value, viewSize: CGSize) {
        let contentHeight = contentRect.size.height
        let contentWidth = contentRect.size.width
        let dragEndLocation: CGPoint = value.location
        let viewHeight: CGFloat = viewSize.height
        let viewWidth: CGFloat = viewSize.width
        
        let atUnsafeTop: Bool = dragEndLocation.y < contentHeight / 2
        let atUnsafeBottom: Bool = dragEndLocation.y  > viewHeight - contentHeight / 2
        let atUnsafeLeading: Bool = dragEndLocation.x - contentWidth / 2 < 0
        let atUnsafeTrailing: Bool = dragEndLocation.x > viewWidth - contentWidth / 2
        
        var offsetX: CGFloat {
            switch contentState {
            case .top, .bottom:
                if atUnsafeTrailing {
                    return geometryEngine.offset.unsafe.toTrailing
                } else if atUnsafeLeading {
                    return geometryEngine.offset.unsafe.toLeading
                }
                
                return value.translation.width + contentDrag.width
            case .expanded:
                return 0
            default:
                return geometryEngine.offset.x
            }
        }
        
        var offsetY: CGFloat {
            switch contentState {
            case .leading, .trailing:
                if atUnsafeTop {
                    return geometryEngine.offset.unsafe.toTop
                } else if atUnsafeBottom {
                    return geometryEngine.offset.unsafe.toBottom
                }
                
                return value.translation.height + contentDrag.height
            case .expanded:
                return 0
            default:
                return geometryEngine.offset.y
            }
        }
        
        contentDrag = CGSize(width: offsetX, height: offsetY)
    }
}
