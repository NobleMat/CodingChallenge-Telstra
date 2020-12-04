import UIKit

typealias TableViewItems = [CellDisplayable]

/// This protocol is used to easily display a tableView cell
protocol CellDisplayable {

    /// This function extracts the cell. And sets the required viewmodel to it.
    /// - Parameters:
    ///   - tableView: The tableView that the cell is used in.
    ///   - indexPath: The indexPath of the cell
    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
}
