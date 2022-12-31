import Plot
import Publish
import Foundation
import VaporDesign

extension Theme where Site == DesignSite {
    static var vapor: Self {
        Theme(htmlFactory: VaporThemeHTMLFactory())
    }
}

private struct VaporThemeHTMLFactory: HTMLFactory {
    typealias Site = DesignSite
    
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        let body: Node<HTML.DocumentContext> = .body {
            SiteNavigation(context: context, selectedSelectionID: nil)
            H1("Hello")
            SiteFooter()
        }
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: index, context: context, body: body)
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: section, context: context, body: .body())
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: item, context: context, body: .body())
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: page, context: context, body: .body())
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: page, context: context, body: .body())
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: page, context: context, body: .body())
    }
}
