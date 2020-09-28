import SwiftUI

/// A wrapper-view enabling drag, float and/or collapse behaviour for its content.
public struct SDView<Content: View>: View {
    /// The horizontal size class of the device in use.
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    /// The drag gesture state of the content.
    @GestureState private var dragState: SDDragState = SDDragState.inactive
    
    /// The state of the content as described by enumerated semantic values.
    @State internal var contentState: SDContentState = .expanded
    
    /// The content state after drag completion.
    @State internal var contentDrag: CGSize = .zero
    
    /// The geometry engine managing all geometric behaviour.
    @State private(set) var geometryEngine: SDGeometryEngine = .default
    
    /// The rect for the content.
    @State private(set) var contentRect: CGRect = .zero
    
    /// The content to inherit drag and collapse properties from the view.
    private let content: (GeometryProxy, SDContentState) -> Content
    
    /// Alignment of content in the view.
    private let alignment: Alignment
    
    /// The visible width of the content once collapsed.
    private let visibleSize: CGSize
    
    /// The configuration of collapsible sides for content in view.
    private let collapseOptions: SDCollapseOptions
    
    /// The configuartion of floating corners for content in view.
    private let floatingOptions: SDFloatingOptions
    
    /**
     Initializes a new view instance to manage drag and collapse behaviour for its content.
     
     - Parameters:
        - alignment: The alignment of the content in the SDView.
        - floating: The floating configuration of the content in the SDView.
        - collapse: The collapse configuartion of the content in the SDView.
        - content: The content to inherit the SDView's properties. It takes an input of `GeometryProxy` and `ContentViewState` to dictate behaviour difference in the different physical properties and content states relative to the SDView, respectively.
     */
    public init(
        alignment: Alignment = .center,
        floating: SDFloatingOptions = [],
        collapse: SDCollapseOptions = .horizontal,
        visibleSize: CGSize = CGSize(width: 60, height: 60),
        @ViewBuilder content: @escaping (GeometryProxy, SDContentState) -> Content
    ) {
        self.alignment = alignment
        self.floatingOptions = floating
        self.collapseOptions = collapse
        self.visibleSize = visibleSize
        self.content = content
    }
    
    /// The body of the view.
    public var body: some View {
        GeometryReader { proxy in
            content(proxy, contentState)
                .readSize(SDViewGeometry.self)
                .position(SDGeometryEngine.location(of: contentRect, in: proxy.size, with: alignment))
                .offset(
                    x: contentDrag.width + dragState.translation.width,
                    y: contentDrag.height + dragState.translation.height
                )
                .gesture(
                    ExclusiveGesture(TapGesture(), DragGesture())
                        .updating($dragState) { value, state, _ in
                            switch value {
                            case .second(let drag):
                                state = .dragging(drag: drag.translation)
                            default:
                                break
                            }
                        }
                        .onEnded { value in
                            switch value {
                            case .first:
                                // reset content state
                                if contentState.isCollapsed || contentState.isFloating {
                                    contentState = .expanded
                                    contentDrag = .zero
                                }
                            case .second(let drag):
                                // update state for drag end calculations
                                geometryEngine = SDGeometryEngine(
                                    for: contentRect,
                                    dragging: drag,
                                    in: proxy.size,
                                    visibleSize: visibleSize,
                                    floatingOptions: floatingOptions,
                                    collapseOptions: collapseOptions
                                )
                                
                                contentState = geometryEngine.contentState
                                
                                boundToSafeArea(drag, viewSize: proxy.size)
                            }
                        }
                )
                .onChange(of: sizeClass) { value in
                    geometryEngine.update(rect: &contentRect, in: proxy.size, with: alignment)
                    
                    if contentState.isCollapsed || contentState.isFloating   {
                        contentDrag = CGSize(width: geometryEngine.offset.x, height: geometryEngine.offset.y)
                    }
                }
                .onPreferenceChange(SDViewGeometry.self) { rect in
                    var updatedRect: CGRect = rect
                    
                    geometryEngine.update(rect: &updatedRect, in: proxy.size, with: alignment)
                    
                    contentRect = updatedRect
                }
        }
        .animation(.default)
        .coordinateSpace(name: SDCoordinateSpaceNames.SDView)
    }
}

/// SDView Previews
#if DEBUG
struct DragAndCollapse_Previews: PreviewProvider {
    static var previews: some View {
        SDView { _, _ in
            Rectangle()
        }
    }
}
#endif
