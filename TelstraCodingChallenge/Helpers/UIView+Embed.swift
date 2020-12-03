import UIKit
extension UIView {

    struct Embed {

        enum Edge {
            case top
            case left
            case bottom
            case right
        }

        let layoutGuide: UILayoutGuide
        let edges: [Edge]
    }

    /// Embed the view into another view, with insets and other options
    /// - Parameters:
    ///   - view: The view in which the current view is to be added
    ///   - insets: The insets to be set on the view
    ///   - options: Other options to follow while embedding
    func embed(inView view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero, options: Embed? = nil) {

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        var topConstraint: NSLayoutConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
        var leftConstraint: NSLayoutConstraint = leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        var bottomConstraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        var rightConstraint: NSLayoutConstraint = view.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right)

        if let options = options {
            options.edges.forEach { edge in
                switch edge {
                case .top: topConstraint = self.topAnchor.constraint(equalTo: options.layoutGuide.topAnchor, constant: insets.top)
                case .left: leftConstraint = self.leftAnchor.constraint(equalTo: options.layoutGuide.leftAnchor, constant: insets.left)
                case .bottom: bottomConstraint = options.layoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom)
                case .right: rightConstraint = options.layoutGuide.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.right)
                }
            }
        }

        NSLayoutConstraint.activate(
            [
                topConstraint,
                leftConstraint,
                bottomConstraint,
                rightConstraint,
            ]
        )
    }

    /// Center the view inside the superview
    /// - Parameter size: A custom size for the view
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
