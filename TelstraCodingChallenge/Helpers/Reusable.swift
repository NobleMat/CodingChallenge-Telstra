import UIKit

/// Protocol to automatically give an identifier to views
protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {

    typealias ReusableCell = UITableViewCell & Reusable

    /// Helper method to easily register cells using their identifier
    /// - Parameter cells: The cells to register
    func registerReusable(_ cells: [ReusableCell.Type]) {
        cells.forEach { registerReusable($0) }
    }

    func registerReusable(_ cell: ReusableCell.Type) {
        register(cell.self, forCellReuseIdentifier: cell.identifier)
    }
}

extension UITableView {

    /// Generic method used to dequeque cells in tableView
    /// - Parameter indexPath: The indexPath of the cell
    /// - Returns: A type infered cell
    func dequeReusable<T: Reusable>(at indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
