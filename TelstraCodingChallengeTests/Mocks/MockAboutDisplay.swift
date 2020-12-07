@testable import TelstraCodingChallenge

final class MockAboutDisplay: MockDisplay, AboutDisplaying {

    private(set) var startRefreshingCalledCount: Int = 0
    func startRefreshing() {
        startRefreshingCalledCount += 1
    }

    private(set) var endRefreshingCalledCount: Int = 0
    func endRefreshing() {
        endRefreshingCalledCount += 1
    }

    private(set) var setItemsCalledCount: Int = 0
    private(set) var setItems: TableViewItems?
    func set(items: TableViewItems) {
        setItemsCalledCount += 1
        setItems = items
    }
}
