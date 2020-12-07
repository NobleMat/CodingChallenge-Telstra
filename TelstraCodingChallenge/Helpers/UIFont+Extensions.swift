import UIKit

extension UIFont {

    enum FontString: String {
        case regular = "AvenirNext-Regular"
        case light = "AvenirNext-UltraLight"
        case semiBold = "AvenirNext-DemiBold"

        var name: String {
            rawValue
        }
    }

    static func regularFont(with size: CGFloat) -> UIFont {
        UIFont(name: FontString.regular.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func lightFont(with size: CGFloat) -> UIFont {
        UIFont(name: FontString.light.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func semiBoldFont(with size: CGFloat) -> UIFont {
        UIFont(name: FontString.semiBold.name, size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

    /// Helper Function to return a scaled font using testStyle and default size.
    /// This has a maximum font size of 2 times the default size.
    /// - Parameters:
    ///   - textStyle: TextStyle of the font to be used. This can be used to restrict the maximum font size
    ///   - size: Default size to be used when the iPhone is on the default setting
    /// - Returns: A scaled font that can be used by the label.
    func scaledFont(using textStyle: UIFont.TextStyle, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName, size: size) else { fatalError() }
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
    }
}

extension UILabel {

    /// Add text scaling to the the UILabel
    /// - Parameters:
    ///   - textStyle: TextStyle of the font to be used. This can be used to restrict the maximum font size
    ///   - isAttributed: If the label uses an attributed String
    func addAccessibility(using textStyle: UIFont.TextStyle) {
        font = font.scaledFont(using: textStyle, size: font.pointSize)
        adjustsFontForContentSizeCategory = true
    }
}
