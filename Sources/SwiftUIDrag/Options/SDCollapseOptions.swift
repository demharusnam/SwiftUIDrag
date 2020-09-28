// MARK: Collapse Options

/// Defines all collapse options for content in the SDView.
public struct SDCollapseOptions: OptionSet {
    /// The raw value of all collapse options.
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// Allow content to collapse on leading side of the SDView.
    public static let leading: SDCollapseOptions = SDCollapseOptions(rawValue: 1 << 0)
    
    /// Allow content to collapse on trailing side of the SDView.
    public static let trailing: SDCollapseOptions = SDCollapseOptions(rawValue: 1 << 1)
    
    /// Allow content to collapse on top side of the SDView.
    public static let top: SDCollapseOptions = SDCollapseOptions(rawValue: 1 << 2)
    
    /// Allow content to collapse on bottom side of the SDView.
    public static let bottom: SDCollapseOptions = SDCollapseOptions(rawValue: 1 << 3)
    
    /// Allow content to collapse on leading and trailing sides of the SDView. This is the default value.
    public static let horizontal: SDCollapseOptions = [.leading, .trailing]
    
    /// Allow content to collapse on top and bottom sides of the SDView.
    public static let vertical: SDCollapseOptions = [.top, .bottom]
    
    /// Allow content to collapse on all sides of the SDView.
    public static let all: SDCollapseOptions = [.horizontal, .vertical]
}
