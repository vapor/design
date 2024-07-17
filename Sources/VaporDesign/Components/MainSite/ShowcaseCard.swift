import Plot
import Publish

public struct ShowcaseCard: Component {
    let name: String
    let url: String
    let image: String
    let description: String

    public init(name: String, url: String, image: String, description: String) {
        self.name = name
        self.url = url
        self.image = image
        self.description = description
    }

    public var body: Component {
        Div {
            Image(url: image, description: "\(name) Card").class("card-img-top")
            Div {
                H5(name).class("card-title")
                Paragraph(description).class("card-text")
                Link(url: url) {
                    Text("See it in action")
                    Span("").class("vapor-icon icon-arrow-narrow-up-right")
                }.class("btn mt-auto")
            }.class("card-body d-flex flex-column")
        }.class("card")
        .id("\(name.lowercased().replacingOccurrences(of: " ", with: "-"))-card")
    }
}
