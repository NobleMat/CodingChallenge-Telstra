import UIKit
extension UIView {

    /// Embed the view into another view, with insets and other options
    /// - Parameters:
    ///   - view: The view in which the current view is to be added
    ///   - insets: The insets to be set on the view
    func embed(inView view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        let topConstraint: NSLayoutConstraint = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
        let leftConstraint: NSLayoutConstraint = leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        let bottomConstraint: NSLayoutConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        let rightConstraint: NSLayoutConstraint = view.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right)

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

    /// Sets constraints to size a particular view
    /// - Parameter size: The size to constriant the view
    func setSize(size: CGSize) {
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func constraintWithBottomGreaterThanOrEqual(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)

        let topConstraint: NSLayoutConstraint = topAnchor.constraint(equalTo: view.topAnchor)
        let leftConstraint: NSLayoutConstraint = leftAnchor.constraint(equalTo: view.leftAnchor)
        let bottomConstraint: NSLayoutConstraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor)
        let rightConstraint: NSLayoutConstraint = view.rightAnchor.constraint(equalTo: rightAnchor)

        NSLayoutConstraint.activate(
            [
                topConstraint,
                leftConstraint,
                bottomConstraint,
                rightConstraint,
            ]
        )
    }
}
