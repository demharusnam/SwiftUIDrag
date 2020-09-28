import SwiftUI

// MARK: View Size Reader Modifier

/// The protocol defining the value type of the geometry preference key.
internal protocol SDGeometryPreferenceKey: PreferenceKey where Value == CGRect {}

/// The view modifier used to determine the rect of the content in the SDView.
internal struct SDSizeReader<Key: SDGeometryPreferenceKey>: ViewModifier {
    /// The horizontal size class of the device in use.
    @Environment(\.horizontalSizeClass) var sizeClass
    
    /// The rect of the content.
    @State private var rect: CGRect = .zero
    
    /// The body requirement of the ViewModifier protocol.
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            rect = geo.frame(in: .named(SDCoordinateSpaceNames.SDView))
                        }
                        .onChange(of: sizeClass) { value in
                            rect = geo.frame(in: .named(SDCoordinateSpaceNames.SDView))
                        }
                        .preference(key: Key.self, value: rect)
                }
            )
    }
}

internal extension View {
    /**
     The size-reader of a view encapsulated in another.
     
     - Parameters:
        - key: The accepted type of the preference key.
     */
    func readSize<Key: SDGeometryPreferenceKey>(_ key: Key.Type) -> some View {
        self.modifier(SDSizeReader<Key>())
    }
}

/// The definition of the geometry preference key.
internal struct SDViewGeometry: SDGeometryPreferenceKey {
    /// The default of the rect being read as defined by the PreferenceKey protocol.
    static var defaultValue: CGRect = .zero

    /**
     Captures any updates of the content rect as defined by the PreferenceKey protocol.
     
     - Parameters:
        - value: The new value of the content rect.
        - nextValue: The read value of the content rect.
     */
    static func reduce(value _: inout CGRect, nextValue: () -> CGRect) {
        _ = nextValue()
    }
}
