import UIKit

final class NoDataTableViewCell: UITableViewCell, Reusable {

    // MARK: - Properties

    // MARK: Private

    private lazy var errorContentView = makeStackView()
    private lazy var errorLabel = makeLabel()
    private lazy var errorImageView = makeImageView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Helpers

    // MARK: Public

    func configure(with item: NoDataItem) {
        contentView.backgroundColor = .cellBackground
        errorLabel.text = item.text
    }
}

// MARK: Private

private extension NoDataTableViewCell {

    func setupViews() {
        errorContentView.embed(
            inView: contentView,
            insets: UIEdgeInsets(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            )
        )

        errorImageView.setSize(size: .init(width: 0, height: 80))
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [errorImageView, errorLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8.0
        return stackView
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .semiBoldFont(with: 16)
        label.textAlignment = .center
        label.addAccessibility(using: .body)
        return label
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error")
        imageView.tintColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

struct NoDataItem: CellDisplayable {

    let text: String

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: NoDataTableViewCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
