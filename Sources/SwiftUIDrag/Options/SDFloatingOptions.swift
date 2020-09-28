// MARK: Floating Options

/// Determines corner-floating options for content in the SDView.
public struct SDFloatingOptions: OptionSet {
    /// The raw value of all floating options.
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// Allow  content to float on top leading side in the SDView.
    public static let topLeading: SDFloatingOptions = SDFloatingOptions(rawValue: 1 << 0)
    
    /// Allow content to float on top trailing side in the SDView.
    public static let topTrailing: SDFloatingOptions = SDFloatingOptions(rawValue: 1 << 1)
    
    /// Allow content to float on bottom leading side in the SDView.
    public static let bottomLeading: SDFloatingOptions = SDFloatingOptions(rawValue: 1 << 2)
    
    /// Allow content to float on bottom trailing side in the SDView.
    public static let bottomTrailing: SDFloatingOptions = SDFloatingOptions(rawValue: 1 << 3)
    
    /// Allow content to float on bottom trailing and leading sides in the SDView.
    public static let bottom: SDFloatingOptions = [.bottomLeading, .bottomTrailing]
    
    /// Allow content to float on top trailing and leading sides in the SDView.
    public static let top: SDFloatingOptions = [.topLeading, .topTrailing]
    
    /// Allow content to float on leading top and bottom sides in the SDView.
    public static let leading: SDFloatingOptions = [.topLeading, .bottomLeading]
    
    /// Allow content to float on trailing top and bottom sides in the SDView.
    public static let trailing: SDFloatingOptions = [.topTrailing, .bottomTrailing]
    
    /// Allow content to float on all sides in the SDView.
    public static let all: SDFloatingOptions = [.leading, .trailing] // can be configured in various ways
}
