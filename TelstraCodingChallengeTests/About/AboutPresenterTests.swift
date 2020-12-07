@testable import TelstraCodingChallenge
import XCTest

class AboutPresenterTests: XCTestCase {

    private var presenter: AboutPresenter!
    private var mockDisplay: MockAboutDisplay!
    private var mockManager: MockAboutManager!

    override func setUp() {
        super.setUp()

        configure()
    }

    func testTitle() {
        // Given

        // When
        presenter.displayDidLoad()

        // Then
        XCTAssertEqual(mockDisplay.setTitleCalledCount, 1)
        XCTAssertEqual(mockDisplay.setTitle, "About")

        // When
        mockManager.fetchDataCompletion?(.success(About.mock()))

        // Then
        XCTAssertEqual(mockDisplay.startRefreshingCalledCount, 1)
        XCTAssertEqual(mockDisplay.endRefreshingCalledCount, 1)
        XCTAssertEqual(mockDisplay.setTitleCalledCount, 2)
        XCTAssertEqual(mockDisplay.setTitle, "title")
    }

    func testItems_apiFailure() throws {
        // Given

        // When
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.failure(APIError.cannotProcessData))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)
        XCTAssertEqual(mockDisplay.setTitleCalledCount, 2)
        XCTAssertEqual(mockDisplay.setTitle, "About")

        let item = try XCTUnwrap(mockDisplay.setItems?.first as? NoDataItem)
        XCTAssertEqual(item.text, NSLocalizedString("about.error", comment: "No Data description"))
    }

    func testItems_apiSuccess() throws {
        // Given

        // When
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.success(About.mock()))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)

        let item = try XCTUnwrap(mockDisplay.setItems?.first as? AboutItem)
        XCTAssertEqual(item.title, "rowTitle")
        XCTAssertEqual(item.description, "rowDescription")
        XCTAssertEqual(item.imageURL, "rowImageUrl")
    }

    func testItems_moreThanOneRow() {
        // Given

        // When
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.success(About.mock(rows: [Row.mock(), Row.mock()])))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setItems?.count, 2)
    }

    func testRefreshData() {
        // Given
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.success(About.mock(rows: [Row.mock(), Row.mock()])))

        // Then
        XCTAssertEqual(mockManager.fetchDataCalledCount, 1)

        // When
        presenter.refreshData()

        // Then
        XCTAssertEqual(mockManager.fetchDataCalledCount, 2)
    }

    func testItems_successToFailure() {
        // Given
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.success(About.mock(rows: [Row.mock()])))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)
        XCTAssertTrue(mockDisplay.setItems?.first is AboutItem)

        // When
        presenter.refreshData()
        mockManager.fetchDataCompletion?(.failure(APIError.unknown))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 3)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)
        XCTAssertTrue(mockDisplay.setItems?.first is NoDataItem)
    }

    func testItems_failureToSuccess() {
        // Given
        presenter.displayDidLoad()
        mockManager.fetchDataCompletion?(.failure(APIError.unknown))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 1)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)
        XCTAssertTrue(mockDisplay.setItems?.first is NoDataItem)

        // When
        presenter.refreshData()
        mockManager.fetchDataCompletion?(.success(About.mock(rows: [Row.mock()])))

        // Then
        XCTAssertEqual(mockDisplay.setItemsCalledCount, 3)
        XCTAssertEqual(mockDisplay.setItems?.count, 1)
        XCTAssertTrue(mockDisplay.setItems?.first is AboutItem)
    }
}

// MARK: - Private

private extension AboutPresenterTests {

    func configure(
        display: MockAboutDisplay = MockAboutDisplay(),
        manager: MockAboutManager = MockAboutManager()
    ) {
        mockDisplay = display
        mockManager = manager
        presenter = AboutPresenter(
            display: display,
            manager: manager
        )
    }
}
