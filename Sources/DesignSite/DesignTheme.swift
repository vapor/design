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
                    CompanyCard(name: "Transeo", url: "https://gotranseo.com", logo: "icon-transeo")
                    CompanyCard(name: "John Lewis", url: "https://johnlewis.com", logo: "icon-john-lewis")
                    CompanyCard(name: "Spotify", url: "https://spotify.com", logo: "icon-spotify")
                    CompanyCard(name: "Swift Package Index", url: "https://swiftpackageindex.com", logo: "icon-swift-package-index")
                    CompanyCard(name: "Allegro", url: "https://allegro.pl", logo: "icon-allegro")
                }.class("d-flex flex-row flex-wrap align-items-center justify-content-center used-by-companies-items")
            }.class("used-by-companies")
            
            Div {
                H2("Build server side with the tooling you already understand").class("main-site-section-header")
                Paragraph {
                    Text("No need to learn a language from scratch (or assemble a different team) just for your backend. Vapor is built on Apple’s SwiftNIO so you’ll get to use the language you already know and love.")
                }.class("caption")
                
                Div {
                    let vapor = PackageCard(title: "Vapor", description: "Build efficient APIs in a language you love. Create routes, send and receive JSON and build HTTP servers.", icon: "server-04", url: "https://docs.vapor.codes/")
                    let fluent = PackageCard(title: "Fluent", description: "Create models and interact with your database in native, safe Swift code without needing to write any SQL", icon: "database-03", url: "https://docs.vapor.codes/fluent/overview/")
                    let JWT = PackageCard(title: "JWT", description: "Create, sign and verify JSON Web Tokens in Swift. Built on top of SwiftNIO", icon: "key-01", url: "https://docs.vapor.codes/security/jwt/")
                    let leaf = PackageCard(title: "Leaf", description: "A templating engine written in Swift. Generate HTML for both web apps and emails with a simple syntax anyone can use", icon: "code-browser", url: "https://docs.vapor.codes/4.0/leaf/overview/")
                    return ComponentGroup(members: [vapor, fluent, JWT, leaf].map { card in
                        Div { card }.class("col")
                    })
                }.class("main-site-packages-grid row row-cols-1 row-cols-lg-2 gx-5")
            }.class("main-site-packages-list")
            
            Div {
                Div {
                    Div {
                        FeatureContainer(title: "High-performant APIs and servers", description: "Built with a non-blocking, event-driven architecture, Vapor allows you to build high-performant, scalable APIs and HTTP servers. Using Swift’s Concurrency model, you can write clear, maintainable code that’s efficient and easy to read.", url: "https://docs.vapor.codes/", icon: "icon-dataflow-03")
                    }.class("col order-2 order-lg-1 g-lg-0")
                    Div {
                        Div {
                            let html = """
                            func search (req: Request) async throws -> [Todo] {

                               let searchTerm =
                                 try req.query.get(String.self, at: "term")

                               let results = try await
                               Todo.query(on: req.db)
                                 .filter(\\.$title == searchTerm).all

                               return results
                            }
                            """
                            let code = Node.code(.text(html)).class("language-swift")
                            Node.pre(.component(code))
                        }.class("code-example")
                        Div {}.class("grey-outline-border-wrap-right")
                    }.class("col order-1 order-lg-2 g-lg-0 position-relative")
                }.class("row row-cols-1 row-cols-lg-2 align-items-center")
                
                Div {
                    Div {
                        FeatureContainer(title: "Ship with confidence, even on Fridays", description: "With Vapor's expressive, protocol oriented design, you'll have peace of mind when shipping your code. With our strong type-safety focus, many errors and problems are caught early on by the compiler.", url: "https://docs.vapor.codes/", icon: "icon-brackets-check")
                    }.class("col order-2 g-lg-0")
                    Div {
                        Div {
                            let html = """
                            func search (req: Request) async throws -> [Todo] {

                               let searchTerm =
                                 try req.query.get(String.self, at: "term")

                               let results = try await
                               Todo.query(on: req.db)
                                 .filter(\\.$number == searchTerm).all

                               return results
                            }
                            """
                            let code = Node.code(.text(html)).class("language-swift")
                            Node.pre(.component(code))
                        }.class("code-example errored")
                        Div {}.class("grey-outline-border-wrap-left")
                        Div {
                            Div {
                                Span().class("vapor-icon icon-alert-octagon")
                            }.class("code-error-sidebar")
                            Div {
                                Text("""
                                Binary operator '==' cannot be applied to operands of type 'KeyPath<Todo, 
                                FieldProperty<Todo, Int>>* and 'String'
                                """)
                            }.class("code-error-message")
                        }.class("code-error")
                    }.class("col order-1 g-lg-0 position-relative")
                }.class("row row-cols-1 row-cols-lg-2 align-items-center")

                Div {
                    Div {
                        FeatureContainer(title: "Full integration with your entire stack", description: "Vapor’s mature ecosystem includes over a hundred official and community maintained server-first Swift packages to make building your applications easy and efficient.", url: "https://docs.vapor.codes/", iconString: "Integrations")
                    }.class("col")

                    // Div {
                    //     Div {
                    //         Div {
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //         }.class("row")
                    //         Div {
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //         }.class("row")
                    //         Div {
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //             Div {
                    //                 Span().class("vapor-icon icon-integration-01")
                    //             }.class("col")
                    //         }.class("row")
                    //     }.class("container")
                    // }.class("col")

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
