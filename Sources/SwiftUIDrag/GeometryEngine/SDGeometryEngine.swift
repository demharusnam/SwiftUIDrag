import SwiftUI

// MARK: Geometry Engine
/// The geometry engine powering all SwiftUIDrag computations.
internal struct SDGeometryEngine {
    /// The *default* initialization of the `GeometryEngine`
    static let `default`: SDGeometryEngine = SDGeometryEngine(
        for: .zero,
        in: .zero,
        visibleSize: CGSize(width: 60, height: 60),
        floatingOptions: [],
        collapseOptions: .horizontal
    )
    
    /// The *offset* object that determines where the content should stick to once the drag has completed.
    var offset: SDOffset {
        if let drag = drag {
            let contentCenter = SDDistance(contentRect, fromBoundsIn: viewSize)
            return SDOffset(
                distanceFrom: contentCenter,
                visibleSize: visibleSize,
                contentLocation: drag.location,
                viewSize: viewSize,
                floatingOptions: floatingOptions,
                collapseOptions: collapseOptions,
                drag: drag
            )
        }
        
        fatalError("Invalid Drag Gesture Value")
    }
    
    /// The *state of the content* as described by enumeration cases.
    var contentState: SDContentState {
        if let location = drag?.location {
            let floatingBounds = SDFloatingBounds(viewSize: viewSize, contentLocation: location, floating: floatingOptions, collapse: collapseOptions)
            let collapseBounds = SDCollapseBounds(viewSize: viewSize, contentLocation: location, collapse: collapseOptions)
            
            if floatingBounds.inBounds {
                return floatingBounds.state
            } else if collapseBounds.inBounds {
                return collapseBounds.state
            }
            
            return .expanded
        }
        
        fatalError("Invalid Drag Gesture Value")
    }
    
    /// The *size of the content*.
    private var contentSize: CGSize { contentRect.size }
    
    /// The *visible size*of the content when collapsed.
    let visibleSize: CGSize
    
    /// The *size of the view* containing the content.
    internal var viewSize: CGSize
    
    /// The *rect of the content*.
    internal var contentRect: CGRect
    
    /// The floating options for the content.
    internal let floatingOptions: SDFloatingOptions
    
    /// The collapsing options for the content.
    internal let collapseOptions: SDCollapseOptions
    
    /// The drag data for the content.
    internal let drag: DragGesture.Value?
    
    /**
     Instantiates a *geometry engine* to manage the drag and collapse behaviour of the content.
     
     - Parameters:
        - content: The rect of the content to be managed by the engine.
        - dragging: The drag gesture value of the content upon drag completion.
        - container: The size of the view encapsulating the content.
        - visibleSize: The visible size of the content upon collapse.
        - floatingOptions: The configuration of all possible *floating options* for the content.
        - floatingOptions: The configuration of all possible *collapse options* for the content.
     */
    init(
        for content: CGRect,
        dragging: DragGesture.Value? = nil,
        in container: CGSize,
        visibleSize: CGSize,
        floatingOptions: SDFloatingOptions,
        collapseOptions: SDCollapseOptions
    ) {
        self.contentRect = content
        self.drag = dragging
        self.viewSize = container
        self.visibleSize = visibleSize
        self.floatingOptions = floatingOptions
        self.collapseOptions = collapseOptions
    }
    
    // MARK: Content Positioning Updates
    
    /**
     Updates the location of the content view's `rect` in its `container`.
     
     The location of the content `rect` is initially determined as a `CGPoint` which is anchored by the center of the content rect. Then, it is adjusted to match the top leading anchor of the `rect` being updated.
     
     - Parameters:
        - rect: The content *rect* to be updated.
        - container: The *size* of the view containing the content.
        - alignment: The *alignment* of the content in its container.
     */
    mutating func update(rect: inout CGRect, in container: CGSize, with alignment: Alignment) {
        var origin: CGPoint = .zero
        // returns mid coordinates of rect as min
        origin = SDGeometryEngine.location(of: rect, in: container, with: alignment)
        // adjust
        origin.x -= rect.size.width / 2
        origin.y -= rect.size.height / 2
        
        let updatedRect = CGRect(origin: origin, size: rect.size)
        
        self.contentRect = updatedRect
        self.viewSize = container
        
        rect = updatedRect
    }
    
    /**
     Determines the appropriate location of the content in the SDView.
     
     The `alignment` of the content in the SDView is used to determine the location of the content based on its `rect` and the size of the SDView.
     - Parameters:
        - rect: The *rect* of the content view.
        - container: The size of the *container* view.
        - alignment: The *alignment* of the content in the *container* view.
     
     - Returns: The location of the content in the `container` view.
     */
    static func location(of rect: CGRect, in container: CGSize, with alignment: Alignment) -> CGPoint {
        let trailingX: CGFloat = container.width - rect.width / 2
        let leadingX: CGFloat = rect.width / 2
        let bottomY: CGFloat = container.height - rect.height / 2
        let topY: CGFloat = rect.height / 2
        
        switch alignment {
        case .bottomLeading:
            return .init(x: leadingX, y:  bottomY)
        case .bottom:
            return .init(x: container.width / 2, y: bottomY)
        case .bottomTrailing:
            return .init(x: trailingX, y: bottomY)
        case .leading:
            return .init(x: leadingX, y: container.height / 2)
        case .trailing:
            return .init(x: trailingX, y: container.height / 2)
        case .topLeading:
            return .init(x: leadingX, y: topY)
        case .top:
            return .init(x: container.width / 2, y: topY)
        case .topTrailing:
            return .init(x: trailingX, y: topY)
        default:
            return .init(x: container.width / 2, y: container.height / 2)
        }
    }
}
