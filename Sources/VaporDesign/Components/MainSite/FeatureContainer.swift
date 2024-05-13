import Plot
import Publish

public struct FeatureContainer: Component {
    let title: String
    let description: String
    let url: String
    let icon: String?
    let iconString: String?

    public init(title: String, description: String, url: String, icon: String? = nil, iconString: String? = nil) {
        self.title = title
        self.description = description
        self.url = url
        self.icon = icon
        self.iconString = iconString
    }

    public var body: Component {
        Div {
            Div {
                if let icon = icon {
                    Span().class("vapor-icon \(icon)")
                } else if let iconString = iconString {
                    Span(iconString)
                }
                H2(title)
                Paragraph {
                    Text(description)
                }
                Button {
                    Link(url: "https://docs.vapor.codes/") {
                        Text("Get Started")
                        Span().class("vapor-icon icon-chevron-right")
                    }.linkTarget(.blank)
                }.class("btn btn-primary w-mobile-100")
            }.class("code-example-explainer")
        }.class("col order-2 order-lg-1 g-lg-0")
    }
}
