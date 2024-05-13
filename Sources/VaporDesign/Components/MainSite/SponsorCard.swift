import Plot
import Publish

public struct SponsorCard: Component {
    let name: String
    let url: String
    let logo: String
    let description: String

    public init(name: String, url: String, logo: String, description: String) {
        self.name = name
        self.url = url
        self.logo = logo
        self.description = description
    }

    public var body: Component {
        Div {
            Div {
                Image(url: logo, description: name).class("card-img-top")
                H5(name).class("card-title")
                Paragraph(description).class("card-text")
                Link(url: url) {
                    Text("Learn More")
                    Span().class("vapor-icon icon-chevron-right")
                }.linkTarget(.blank).class("learn-more-link mt-auto")
            }.class("card-body d-flex flex-column")
        }.class("card")
    }
}
