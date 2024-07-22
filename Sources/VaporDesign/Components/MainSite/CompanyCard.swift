import Plot
import Publish

public struct CompanyCard: Component {
    let name: String
    let url: String
    let logo: String

    public init(name: String, url: String, logo: String) {
        self.name = name
        self.url = url
        self.logo = logo
    }

    public var body: Component {
        Div {
            Link(url: url) {
                Span().class("used-by-icon \(logo)").attribute(named: "title", value: name)
            }.linkTarget(.blank)
            .class("used-by-logo")
        }.class("used-by-item")
    }
}
