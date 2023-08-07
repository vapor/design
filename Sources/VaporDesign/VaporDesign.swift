import Plot
import Publish

public struct VaporDesign<Site: Website> {
    
    let siteLanguage: Language
    let isLocal: Bool
    let isMainSite: Bool
    
    public init(siteLanguage: Language, isLocal: Bool = false, isMainSite: Bool = false) {
        self.siteLanguage = siteLanguage
        self.isLocal = isLocal
        self.isMainSite = isMainSite
    }
    
    public func buildHTML(for page: Location, context: PublishingContext<Site>, body: Node<HTML.DocumentContext>) -> HTML {
        HTML(
            .lang(siteLanguage),
            buildHead(for: page, context: context),
            body
        )
    }
    
    func buildHead(for page: Location, context: PublishingContext<Site>) -> Node<HTML.DocumentContext> {
        let head = Node.head(
            for: page,
            on: context.site,
            stylesheetPaths: [
                Path(VaporDesignUtilities.buildResourceLink(for: "/main.css", isLocal: isLocal))
            ],
            scripts: [
                Path(VaporDesignUtilities.buildResourceLink(for: "/js/detectColorScheme.js", isLocal: isLocal)),
                Path(VaporDesignUtilities.buildResourceLink(for: "/js/scrollMainSiteShowcase.js", isLocal: isLocal)),
                Path(VaporDesignUtilities.buildResourceLink(for: "/js/mainSiteScrollNavbar.js", isLocal: isLocal))
            ],
            isLocal: isLocal)
        return head
    }
}
