@testable import TelstraCodingChallenge

extension About {

    static func mock(
        title: String = "title",
        rows: [Row] = [.mock()]
    ) -> About {
        About(
            title: title,
            rows: rows
        )
    }
}

extension Row {

    static func mock(
        title: String = "rowTitle",
        rowDescription: String = "rowDescription",
        imageURL: String = "rowImageUrl"
    ) -> Row {
        Row(
            title: title,
            rowDescription: rowDescription,
            imageURL: imageURL
        )
    }
}
