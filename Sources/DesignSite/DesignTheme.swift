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
    
    func buildExampleBlogPage() -> Component {
        Div {
            
        }
    }
    
    func buildComponentDemo() -> Component {
        Div {
            H1("Everything below this is for just showing components")

            #warning("Extract to component")
            Navigation {
                List {
                    ListItem {
                        Link(url: "#") {
                            Span() {
                                Text("«")
                            }.attribute(named: "aria-hidden", value: "true")
                            Text("Previous")
                        }.class("page-link page-link-next-previous").accessibilityLabel("Previous")
                    }.class("page-item")
                    ListItem {
                        Span {
                            Text("1")
                        }.class("page-link")
                    }.class("page-item active").attribute(named: "aria-current", value: "page")

                    ListItem {
                        Link("2", url: "#").class("page-link")
                    }.class("page-item")
                    ListItem {
                        Link("3", url: "#").class("page-link")
                    }.class("page-item")
                    ListItem {
                        Text("...")
                    }.class("page-item")
                    ListItem {
                        Link("8", url: "#").class("page-link")
                    }.class("page-item")
                    ListItem {
                        Link("9", url: "#").class("page-link")
                    }.class("page-item")
                    ListItem {
                        Link("10", url: "#").class("page-link")
                    }.class("page-item")
                    ListItem {
                        Link(url: "#") {
                            Span() {
                                Text("»")
                            }.attribute(named: "aria-hidden", value: "true")
                            Text("Next")
                        }.class("page-link page-link-next-previous").accessibilityLabel("Next")
                    }.class("page-item")
                }.class("pagination justify-content-center")
            }.accessibilityLabel("blog-pagination")
        }.class("container")
    }
}
