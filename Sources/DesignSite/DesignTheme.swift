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
        let currentSite: CurrentSite = .blog
        let blogPostData = BlogPostExtraData(length: "15 mins read", author: .init(name: "Tim", imageURL: "/images/author-image-placeholder.png"), publishedDate: "Published 3rd January 2023")
        let itemContent = Content(title: "Vapor's Design Guide", description: "Welcome to Vapor's Design Guide which contains the designs for all of Vapor's websites", body: .init(html: demoPostHTML))
        let item = Item<Site>(path: "/demo", sectionID: .posts, metadata: .init(), tags: ["Vapor", "Swift", "Framework"], content: itemContent)
        let body: Node<HTML.DocumentContext> = .body {
            SiteNavigation(context: context, selectedSelectionID: nil, currentSite: currentSite)
            BlogPost(blogPostData: blogPostData, item: item, site: context.site, isDemo: true)
            buildComponentDemo()
            SiteFooter(isLocal: true, currentSite: currentSite)
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
    
    func buildComponentDemo() -> Component {
        Div {
            H1("Component Guide")
            
            H2("Typography")
            
            H1("Header 1")
            H2("Header 2")
            H3("Header 3")
            H4("Header 4")
            H5("Header 5")
            H6("Header 6")
            
            H2("Pagination")

            #warning("Extract to component")
            Navigation {
                List {
                    ListItem {
                        Link(url: "#") {
                            Span().class("vapor-icon icon-chevron-left")
                            Div {
                                Text("Previous")
                            }.class("d-none d-lg-block")
                        }.class("page-link page-link-next-previous d-flex page-link-previous").accessibilityLabel("Previous")
                    }.class("page-item me-auto")
                    ListItem {
                        Span {
                            Text("1")
                        }.class("page-link")
                    }.class("page-item active d-none d-lg-block").attribute(named: "aria-current", value: "page")

                    ListItem {
                        Link("2", url: "#").class("page-link")
                    }.class("page-item d-none d-lg-block")
                    ListItem {
                        Link("3", url: "#").class("page-link")
                    }.class("page-item d-none d-lg-block")
                    ListItem {
                        Text("...")
                    }.class("page-item pagination-ellipsis d-none d-lg-block ms-1 me-1")
                    ListItem {
                        Link("8", url: "#").class("page-link")
                    }.class("page-item d-none d-lg-block")
                    ListItem {
                        Link("9", url: "#").class("page-link")
                    }.class("page-item d-none d-lg-block")
                    ListItem {
                        Link("10", url: "#").class("page-link")
                    }.class("page-item d-none d-lg-block")
                    ListItem {
                        Text("Page 1 of 10")
                    }.class("page-item pagination-ellipsis d-lg-none")
                    ListItem {
                        Link(url: "#") {
                            Div {
                                Text("Next")
                            }.class("d-none d-lg-block")
                            Span().class("vapor-icon icon-chevron-right")
                        }.class("page-link page-link-next-previous d-flex page-link-next").accessibilityLabel("Next")
                    }.class("page-item ms-auto")
                }.class("pagination justify-content-center")
            }.accessibilityLabel("blog-pagination")
            
            H2("Blog Post Card")
            
            
        }.class("container")
    }
}

let demoPostHTML = """
<h2>Introduction</h2>

        <p>
          This site contains Vapor's Design Guide showing examples of different components used in web pages. Evetually, this design guide will be rolled out across all of Vapor's sites, old and new.
        </p>
        <p>
          The designs have been developed in conjunction with <a href="https://www.redbourbon.co">Red Bourbon</a> who have created some amazing desgins for us. The code for this site, the desgin guide and the reference designs can be found on <a href="https://github.com/vapor/design">GitHub</a>.
        </p>

        <p>
            Originally this page was a proof on concept for building the blog (the first site to be ported over to the new design) as a way of getting the styling and HTML/CSS to work. It's now evolved to host the generated CSS and JS the sites can pull in, this example site, all the static files (like images) and components for Publish to use when building out sites.
        </p>

        <p>Here's an example of a code block:</p>

        <pre>
          <code class="language-swift">// This is a comment
struct CreateTodoTitleIndex: AsyncMigration {
  func prepare(on database: Database) async throws {
      try await (database as! SQLDatabase)
          .create(index: "todo_index")
          .on("todos")
          .column("title")
          .run()
  }

  func thisIsALongLineOfCodeToTestHowWeDealWithBiggerLinesOfCode(something somethingeElse: MySuperLongType) async throws -> MyOtherType {
      fatalError()
  }

  func revert(on database: Database) async throws {
      try await (database as! SQLDatabase)
          .drop(index: "todo_index")
          .run()
  }
}
          </code>
        </pre>

        <p>And now a quote:</p>

        <blockquote>
          “Hendrerit amet nibh dui ut in feugiat pellentesque. Sed consectetur blandit lectus arcu lacus libero diam. Nulla turpis etiam non et, adipiscing.
          Egestas at vitae, at purus accumsan fermentum. Sed quis sed nulla malesuada.""
        </blockquote>

        <p>
          And finally a list:
        </p>
        

        <ol>
          <li>Lectus id duis vitae porttitor enim gravida morbi.</li>
          <li>Eu turpis posuere semper feugiat volutpat elit, ultrices suspendisse. Auctor vel in vitae placerat.</li>
          <li>Suspendisse maecenas ac donec scelerisque diam sed est duis purus.</li>
        </ol>
"""
