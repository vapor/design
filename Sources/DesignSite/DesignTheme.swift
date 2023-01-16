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
        let isDemo = true
        let currentSite: CurrentSite = .blog
        let blogPostData = BlogPostExtraData(length: "15 mins read", author: .init(name: "Tim Condon", imageURL: "/images/author-image-placeholder.png"), publishedDate: "3rd January 2023")
        let itemContent = Content(title: "Vapor's Design Guide", description: "Welcome to Vapor's Design Guide which contains the designs for all of Vapor's websites", body: .init(html: demoPostHTML))
        let item = Item<Site>(path: "/demo", sectionID: .posts, metadata: .init(), tags: ["Vapor", "Swift", "Framework"], content: itemContent)
        let body: Node<HTML.DocumentContext> = .body {
            SiteNavigation(context: context, selectedSelectionID: nil, currentSite: currentSite, currentMainSitePage: nil, isDemo: isDemo)
            BlogPost(blogPostData: blogPostData, item: item, site: context.site, isDemo: isDemo)
            buildComponentDemo(blogPostData: blogPostData, item: item, site: context.site, isDemo: isDemo)
            SiteFooter(isLocal: true, isDemo: isDemo, currentSite: currentSite)
        }
        
        let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
        return builder.buildHTML(for: index, context: context, body: body)
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        if section.title == "Mainpagedemo" {
            let body: Node<HTML.DocumentContext> = .body {
                let isDemo = true
                let currentSite: CurrentSite = .main
                SiteNavigation(context: context, selectedSelectionID: nil, currentSite: currentSite, currentMainSitePage: nil, isDemo: isDemo)
                buildMainSiteDemo()
                SiteFooter(isLocal: true, isDemo: isDemo, currentSite: currentSite)
            }
            
            let bodyWithClass = body.class("main-site-main-page")
            let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
            return builder.buildHTML(for: section, context: context, body: bodyWithClass.convertToNode())
        } else {
            let builder = VaporDesign<Site>(siteLanguage: context.site.language, isLocal: true)
            return builder.buildHTML(for: section, context: context, body: .body())
        }
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
    
    func buildComponentDemo(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site, isDemo: Bool) -> Component {
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

            Pagination(activePage: 1, numberOfPages: 15, pageURL: { pageNumber in
                return "/\(pageNumber)"
            }, isDemo: isDemo)
            
            H2("HR")
            
            Node.hr()
            
            H2("Blog Post Cards")
            
            Div {
                Div {
                    let item2 = Item<Site>(path: "/demo", sectionID: .posts, metadata: .init(), tags: ["Vapor", "Swift", "Framework"], content: Content(title: "This is a longer post", description: "Welcome to Vapor's Design Guide which contains the designs for all of Vapor's websites. This description is much longer to test card heights and make sure the cards are the same height.", body: .init(html: demoPostHTML)))
                    BlogCard(blogPostData: blogPostData, item: item2, site: site, isDemo: true)
                }.class("col")
                Div {
                    BlogCard(blogPostData: blogPostData, item: item, site: site, isDemo: true)
                }.class("col")
                Div {
                    BlogCard(blogPostData: blogPostData, item: item, site: site, isDemo: true)
                }.class("col")
            }.class("row row-cols-1 row-cols-lg-2 g-4")
            
            H2("Blog Site Title")
            
            H1("Articles, tools & resources for Vapor devs").class("vapor-blog-page-heading")
            
            H2("Blog Tag List")
            
            H4("This is a list on desktop and a drop down menu on mobile")
            
            Div {
                Div {
                    let tags: [Tag] = [Tag("Vapor"), Tag("Swift"), Tag("DevOps"), Tag("API"), Tag("Announcements")]
                    let tagsWithPostCount = tags.map { TagWithPostCount(tag: $0, postCount: 2)}
                    return ComponentGroup(BlogTagList(tags: tagsWithPostCount, site: site, selectedTag: nil, totalPosts: 72, isDemo: true))
                }.class("col-lg-3")
                Div().class("col")
            }.class("row")
            
        }.class("container")
    }

    func buildMainSiteDemo() -> Component {
        Div {
            Span().class("d-flex mx-auto")
                .accessibilityLabel("Vapor Logo")
                .id("vapor-hero-logo")
            H1("Swift, but on a server").class("main-title")
            H3("Vapor provides a safe, performant and easy to use foundation to build HTTP servers, backends and APIs in Swift").class("main-page-caption d-flex mx-auto")

            Div {
                Div {
                    Button {
                        Link("Get Started", url: "https://docs.vapor.codes/").linkTarget(.blank).id("main-page-callout-button-link")
                    }.class("btn btn-primary w-mobile-100")
                }.class("w-mobile-100")
                Div {
                    Button {
                        Link(url: "https://github.com/vapor/vapor") {
                            Span().class("vapor-icon icon-github-line icon-secondary btn-icon me-2")
                            Text("22k stars on GitHub")
                        }.class(" d-flex align-items-center")
                    }.class("btn btn-link btn-secondary-link")
                }.class("d-flex align-items-center ms-lg-5")
            }.class("main-page-callout-buttons d-flex align-items-center justify-content-center flex-column flex-lg-row")

            Div {
                let html = """
                import Vapor

                let app = try Application(.detect())
                defer { app.shutdown() }

                app.get("hello") { req in
                    return "Hello, world!"
                }

                try app.run()
                
                
                
                
                
                
                
                
                
                
                
                """
                let code = Node.code(.text(html)).class("language-swift")
                Node.pre(.component(code))
            }.class("main-code-demo mx-auto")

            Div {
                H5("Powering companies like:").class("used-by-caption")
                Div {
                    Div {
                        Link(url: "https://swiftpackageindex.com") {
                            Span().class("used-by-icon icon-transeo").attribute(named: "title", value: "Transeo")
                        }.class("used-by-logo")
                    }.class("used-by-item")

                    Div {
                        Link(url: "https://swiftpackageindex.com") {
                            Span().class("used-by-icon icon-john-lewis").attribute(named: "title", value: "John Lewis")
                        }.class("used-by-logo")
                    }.class("used-by-item")

                    Div {
                        Link(url: "https://swiftpackageindex.com") {
                            Span().class("used-by-icon icon-spotify").attribute(named: "title", value: "Spotify")
                        }.class("used-by-logo")
                    }.class("used-by-item")

                    Div {
                        Link(url: "https://swiftpackageindex.com") {
                            Span().class("used-by-icon icon-swift-package-index").attribute(named: "title", value: "Swift Package Index")
                        }.class("used-by-logo")
                    }.class("used-by-item")

                    Div {
                        Link(url: "https://swiftpackageindex.com") {
                            Span().class("used-by-icon icon-allegro").attribute(named: "title", value: "Allegro")
                        }.class("used-by-logo")
                    }.class("used-by-item")
                }.class("d-flex flex-row flex-wrap align-items-center justify-content-center used-by-companies-items")
            }.class("used-by-companies")
            
            Div {
                H2("Build server side with the tooling you already understand").class("main-site-section-header")
                Paragraph {
                    Text("No need to learn a language from scratch (or assemble a different team) just for your backend. Vapor is built on Apple’s SwiftNIO so you’ll get to use the language you already know and love.")
                }.class("caption")
                
                Div {
                    var cards = [Component]()
                    for _ in 1...4 {
                        let card = Div {
                            Div {
                                Div {
                                    Span().class("vapor-icon feature-card-icon icon-server-04")
                                    H3("Vapor").class("card-title")
                                    Paragraph("Build efficient APIs in a language you love. Create routes, send and receive JSON and build HTTP servers.").class("card-text")
                                    Link(url: "https://github.com/vapor/vapor") {
                                        Text("Learn More")
                                        Span().class("vapor-icon icon-chevron-right")
                                    }.linkTarget(.blank).class("main-site-learn-more-link")
                                }
                            }.class("card h-100 vapor-feature-card")
                        }.class("col")
                        cards.append(card)
                    }
                    return ComponentGroup(members: cards)
                }.class("main-site-packages-grid row row-cols-1 row-cols-lg-2 gx-5")
            }.class("main-site-packages-list")
            
            Div {
                Div {
                    Div {
                        Span().class("vapor-icon icon-dataflow-03")
                        H2("High-performant APIs and servers")
                        Paragraph {
                            Text("Built with a non-blocking, event-driven architecture, Vapor allows you to build high-performant, scalable APIs and HTTP servers. Using Swift’s Concurrency model, you can write clear, maintainable code that’s efficient and easy to read.")
                        }
                        Button {
                            Link(url: "https://docs.vapor.codes/") {
                                Text("Get Started")
                                Span().class("vapor-icon icon-chevron-right")
                            }.linkTarget(.blank)
                        }.class("btn btn-primary w-mobile-100")
                    }.class("col")
                    Div {
                        Div {
                            let html = """
                            func search (req: Request) async throws -> [Todo] {

                               let searchTerm =
                                 try req.query.get(String.self, at: "term")

                               let results = try await
                               Todo.query (on: req.db). filter
                               (\\.$title == searchTerm).all

                               return results
                            }
                            """
                            let code = Node.code(.text(html)).class("language-swift")
                            Node.pre(.component(code))
                        }.class("code-example mx-auto")
                    }.class("col")
                }.class("row row-cols-1 row-cols-lg-2 align-items-center")
            }.class("main-site-features")
        }.class("container")
    }
}

let demoPostHTML = """
<h2>Introduction</h2>

        <p>
          This site contains Vapor's Design Guide showing examples of different components used in web pages. Evetually, this design guide will be rolled out across all of Vapor's sites, old and new.
        </p>
        <p>
          The designs have been developed in conjunction with <a href="https://www.redbourbon.co">Red Bourbon</a> who have created some amazing designs for us. The code for this site, the design guide and the reference designs can be found on <a href="https://github.com/vapor/design">GitHub</a>.
        </p>

        <p>
            Originally this page was a proof on concept for building the blog (the first site to be ported over to the new design) as a way of getting the styling and HTML/CSS to work. It's now evolved to host the generated CSS and JS the sites can pull in, this example site, all the static files (like images) and components for Publish to use when building out sites.
        </p>

        <p>
            You can see an example of the main site <a href="/mainPageDemo">here</a>.
        </p>

        <h2>Some <code>Vapor</code> code blocks</h2>

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

        <p>And then we have some inline code: <code>let vaporIsAwesome = true</code></p>

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
