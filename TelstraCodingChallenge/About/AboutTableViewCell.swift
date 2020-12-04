import UIKit

final class AboutTableViewCell: UITableViewCell, Reusable {

    // MARK: - Properties

    // MARK: Private

    private lazy var contentStackView = makeStackView()
    private lazy var labelContentView = makeView()
    private lazy var labelStackView = makeLabelStackView()
    private lazy var titleLabel = makeLabel(with: .semiBoldFont(with: 16.0))
    private lazy var descriptionLabel = makeLabel(with: .regularFont(with: 14))
    private lazy var imageContentView = makeView()
    private lazy var aboutImageView = makeImageView()

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

    func configure(with item: AboutItem) {
        contentView.backgroundColor = .cellBackground
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        aboutImageView.downloaded(
            from: item.imageURL,
            placeholder: Constants.defaultImage
        )
    }
}

// MARK: Private

private extension AboutTableViewCell {

    enum Constants {
        static let defaultImage: UIImage = UIImage(named: "defaultImage")!
        static let contentInsets: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
        static let imageViewSize: CGSize = .init(width: 75, height: 75)
    }

    private func setupViews() {
        contentStackView.embed(
            inView: contentView,
            insets: Constants.contentInsets
        )

        addImageViewConstraints()

        labelStackView.constraintWithBottomGreaterThanOrEqual(to: labelContentView)
    }

    func addImageViewConstraints() {
        aboutImageView.setSize(size: Constants.imageViewSize)
        aboutImageView.constraintWithBottomGreaterThanOrEqual(to: imageContentView)
    }

    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    private func makeLabel(with font: UIFont) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.addAccessibility(using: .body)
        return label
    }

    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        return imageView
    }

    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageContentView, labelContentView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8.0
        return stackView
    }

    private func makeLabelStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8.0
        return stackView
    }
}

struct AboutItem: CellDisplayable {
    let title: String?
    let description: String?
    let imageURL: String?

    init(using about: Row) {
        title = about.title
        description = about.rowDescription
        imageURL = about.imageURL
    }

    func extractCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell: AboutTableViewCell = tableView.dequeReusable(at: indexPath)
        cell.configure(with: self)
        return cell
    }
}
