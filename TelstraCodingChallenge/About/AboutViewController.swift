import UIKit

final class AboutViewController: UIViewController {

    // MARK: - Properties

    // MARK: Private

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.registerReusable(
            [
                AboutTableViewCell.self,
                NoDataTableViewCell.self,
            ]
        )
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private var items: TableViewItems = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl.default
        refreshControl.addTarget(self, action: .refresh, for: .valueChanged)
        return refreshControl
    }

    private var refreshBarButton: UIBarButtonItem {
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: .refresh
        )
        return refreshButton
    }

    // MARK: Public

    var presenter: AboutPresenting!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .viewBackground

        navigationItem.rightBarButtonItem = refreshBarButton

        assert(presenter != nil, "AboutPresenter cannot be nil")

        setupViews()

        presenter.displayDidLoad()
    }
}

// MARK: - Conformance

// MARK: AboutDisplaying

extension AboutViewController: AboutDisplaying {

    func set(items: TableViewItems) {
        if tableView.refreshControl?.isRefreshing == true {
            tableView.refreshControl?.endRefreshing()
        }
        self.items = items
    }

    func startRefreshing() {
//        showLoading(show: true)
        tableView.refreshControl?.beginRefreshing()
    }

    func endRefreshing() {
//        showLoading(show: false)
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: UITableViewDataSource

extension AboutViewController: UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        items[indexPath.row].extractCell(from: tableView, for: indexPath)
    }
}

// MARK: - Private Helpers

private extension AboutViewController {

    func setupViews() {
        tableView.embed(inView: view)
    }

    @objc
    func refresh() {
        presenter.refreshData()
    }
}

// MARK: Selector

private extension Selector {
    static var refresh = #selector(AboutViewController.refresh)
}
