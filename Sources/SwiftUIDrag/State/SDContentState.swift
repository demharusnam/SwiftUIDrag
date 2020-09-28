import SwiftUI

// MARK: Content State

/// The state of the content in the SDView.
public enum SDContentState {
    /// The state that indicates the dragged content is collapsed on the *leading* side of the SDView.
    case leading
    
    /// The state that indicates the dragged content is collapsed on the *trailing* side of the SDView.
    case trailing
    
    /// The state that indicates the dragged content is collapsed on the *top* side of the SDView.
    case top
    
    /// The state that indicates the dragged content is collapsed on the *bottom* side of the SDView.
    case bottom
    
    /// The state that indicates the dragged content is floating on the *top leading* side of the SDView.
    case topLeading
    
    /// The state that indicates the dragged content is floating on the *top trailing* side of the SDView.
    case topTrailing
    
    /// The state that indicates the dragged content is floating on the *bottom leading* side of the SDView.
    case bottomLeading
    
    /// The state that indicates the dragged content is floating on the *bottom trailing* side of the SDView.
    case bottomTrailing
    
    /// The state that indicates the dragged content is in its default state, neither floating nor collapsed.
    case expanded
    
    /// Determines whether the content is expanded.
    public var isExpanded: Bool {
        switch self {
        case .expanded:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is floating/collapsed on the trailing side of the SDView.
    public var isTrailing: Bool {
        switch self {
        case .trailing, .topTrailing, .bottomTrailing:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is floating/collapsed on the leading side of the SDView.
    public var isLeading: Bool {
        switch self {
        case .leading, .topLeading, .bottomLeading:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is floating/collapsed on the top side of the SDView.
    public var isTop: Bool {
        switch self {
        case .top, .topLeading, .topTrailing:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is floating/collapsed on the bottom side of the SDView.
    public var isBottom: Bool {
        switch self {
        case .bottom, .bottomLeading, .bottomTrailing:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is floating in the SDView.
    public var isFloating: Bool {
        switch self {
        case .topLeading, .topTrailing, .bottomLeading, .bottomTrailing:
            return true
        default:
            return false
        }
    }
    
    /// Determines whether the content is collapsed in the SDView.
    public var isCollapsed: Bool {
        switch self {
        case .top, .bottom, .leading, .trailing:
            return true
        default:
            return false
        }
    }
}
