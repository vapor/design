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
        let blogPostData = BlogPostExtraData(length: "15 mins read", author: .init(name: "Tim", imageURL: "/images/author-image-placeholder.png"), publishedDate: "Published 1st September 2022")
        let itemContent = Content(title: "Hello, world!", description: "Quis orci, sociis fringilla sed aenean sem. Pulvinar mi nunc neque vestibulum at. Sem tincidunt.", body: .init(html: demoPostHTML))
        let item = Item<Site>(path: "/demo", sectionID: .posts, metadata: .init(), tags: ["Vapor", "Swift", "Framework"], content: itemContent)
        let body: Node<HTML.DocumentContext> = .body {
            SiteNavigation(context: context, selectedSelectionID: nil)
            BlogPost(blogPostData: blogPostData, item: item, site: context.site)
            buildComponentDemo()
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

let demoPostHTML = """
<h2>Introduction</h2>

        <p>
          Mi tincidunt elit, id quisque ligula ac diam, amet. Vel etiam suspendisse morbi eleifend faucibus eget vestibulum felis.
          Dictum quis montes, sit sit. Tellus aliquam enim urna, etiam. Mauris posuere vulputate arcu amet, vitae nisi, tellus tincidunt.
          At feugiat sapien varius id.
        </p>
        <p>
          Eget quis mi enim, leo lacinia pharetra, semper. Eget in volutpat mollis at volutpat lectus velit, sed auctor. Porttitor fames arcu quis fusce augue enim.
          Quis at habitant diam at. Suscipit tristique risus, at donec. In turpis vel et quam imperdiet. Ipsum molestie aliquet sodales id est ac volutpat.
        </p>

        <pre>
          <code class="language-swift">
// This is a comment
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

        <blockquote>
          “Hendrerit amet nibh dui ut in feugiat pellentesque. Sed consectetur blandit lectus arcu lacus libero diam. Nulla turpis etiam non et, adipiscing.
          Egestas at vitae, at purus accumsan fermentum. Sed quis sed nulla malesuada.""
        </blockquote>

        <p>
          Dolor enim eu tortor urna sed duis nulla. Aliquam vestibulum, nulla odio nisl vitae. In aliquet pellentesque aenean hac vestibulum turpis mi bibendum diam.
          Tempor integer aliquam in vitae malesuada fringilla.
        </p>
        <p>
          Elit nisi in eleifend sed nisi. Pulvinar at orci, proin imperdiet commodo consectetur convallis risus. Sed condimentum enim
          dignissim adipiscing faucibus consequat, urna. Viverra purus et erat auctor aliquam. Risus, volutpat vulputate posuere purus
          sit congue convallis aliquet. Arcu id augue ut feugiat donec porttitor neque. Mauris, neque ultricies eu vestibulum, bibendum quam
          lorem id. Dolor lacus, eget nunc lectus in tellus, pharetra, porttitor.
        </p>
        <p>
          Ipsum sit mattis nulla quam nulla. Gravida id gravida ac enim mauris id. Non pellentesque congue eget consectetur turpis.
          Sapien, dictum molestie sem tempor. Diam elit, orci, tincidunt aenean tempus. Quis velit
          eget ut tortor tellus. Sed vel, congue felis elit erat nam nibh orci.
        </p>

        <h3>Software and Tools</h3>

        <p>
          Pharetra morbi libero id aliquam elit massa integer tellus. Quis felis aliquam ullamcorper porttitor.
          Pulvinar ullamcorper sit dictumst ut eget a, elementum eu. Maecenas est morbi mattis id in ac pellentesque ac.
        </p>

        <p>
          Sagittis et eu at elementum, quis in. Proin praesent volutpat egestas sociis sit lorem nunc nunc sit. Eget diam curabitur mi ac.
          Auctor rutrum lacus malesuada massa ornare et. Vulputate consectetur ac ultrices at diam dui eget fringilla tincidunt.
          Arcu sit dignissim massa erat cursus vulputate gravida id. Sed quis auctor vulputate hac elementum gravida cursus dis.
        </p>

        <ol>
          <li>Lectus id duis vitae porttitor enim gravida morbi.</li>
          <li>Eu turpis posuere semper feugiat volutpat elit, ultrices suspendisse. Auctor vel in vitae placerat.</li>
          <li>Suspendisse maecenas ac donec scelerisque diam sed est duis purus.</li>
        </ol>
"""
