import Plot
import Publish

public struct FeatureCard<Site: Website>: Component {
    let item: Item<Site>
    let site: Site
    let isDemo: Bool
    let featureCardData: FeatureCardData

    public init(featureCardData: FeatureCardData, item: Item<Site>, site: Site, isDemo: Bool = false) {
        self.item = item
        self.site = site
        self.isDemo = isDemo
        self.featureCardData = featureCardData
    }

    public var body: Component {
        Div {
            Div {
                Span().class("card-icon vapor-icon icon-\(featureCardData.icon)")
                H2(item.title).class("card-title")
                Paragraph(item.description).class("card-text")
                Link(url: buildLinkForFeature(item: item, isDemo: isDemo)) {
                    Text("Learn more")
                    Span().class("vapor-icon icon-chevron-right")
                }.class("card-link d-flex align-items-center")
            }.class("card-body")
        }.class("card feature-card")
    }

    func buildLinkForFeature(item: Item<Site>, isDemo: Bool) -> String {
        if isDemo {
            return "#"
        } else {
            return item.path.absoluteString
        }
    }
}