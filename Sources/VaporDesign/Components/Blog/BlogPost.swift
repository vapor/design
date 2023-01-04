import Plot
import Publish

public struct BlogPost<Site: Website>: Component {
    let blogPostData: BlogPostExtraData
    let item: Item<Site>
    let site: Site
    let isDemo: Bool
    
    public init(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site, isDemo: Bool) {
        self.blogPostData = blogPostData
        self.item = item
        self.site = site
        self.isDemo = isDemo
    }
    
    public var body: Component {
        Div {
            buildBlogHeader()
            blogPostDivider()
            buildBlogPostContent()
            blogPostDivider()
            buildBlogPostBottom()
        }.class("container vapor-container blog-container")
    }
    
    func buildBlogHeader() -> Component {
        Div {
            Div {
                Div {
                    Div {
                        BlogTagList(blogPostData: blogPostData, item: item, site: site, isDemo: isDemo)
                    }.class("blog-tags")
                    Div {
                        Text(blogPostData.length)
                    }.id("blog-post-reading-time")
                }.class("d-flex").id("blog-time-tags")
            }.id("blog-time-tag-container")
            H1(item.title).class("mb-4 mt-4")
            Div {
                Text(item.description)
            }.class("mb-4").id("blog-description")
            Div {
                BlogPostAuthorComponent(blogPostData: blogPostData, postPage: true)
                Div {
                    buildBlogPostShareList()
                }.id("blog-top-share").class("ms-auto blog-share col-lg-6 mt-4 mt-lg-0")
            }.class("row")
        }.class("blog-post-header")
    }
    
    func blogPostDivider() -> Component {
        Node.hr().class("blog-post-divider")
    }
    
    func buildBlogPostContent() -> Component {
        Div {
            item.content.body
        }.class("blog-content")
    }
    
    func buildBlogPostBottom() -> Component {
        Div {
            Div {
                BlogTagList(blogPostData: blogPostData, item: item, site: site, isDemo: isDemo)
            }.id("blog-bottom-tags").class("blog-tags col-lg-6")
            Div {
                buildBlogPostShareList()
            }.class("ms-auto blog-share col-lg-6").id("blog-bottom-share")
        }.id("blog-post-bottom").class("row align-items-center")
    }
    
    func buildBlogPostShareList() -> Component {
        List {
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-copy-06 me-2")
                    Text("Copy Link")
                }.class("btn btn-secondary btn-small d-flex").onclick("Vapor.copyURLToClipboard(); return false;")
            }.class("ms-auto")
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-twitter-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex twitter-share-button")
            }
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-reddit-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex reddit-share-button")
            }
            ListItem {
                Link(url: "#") {
                    Text("&nbsp;")
                    Span().class("vapor-icon icon-mastodon-fill share-icon-empty")
                    Text("&nbsp;")
                }.class("btn btn-secondary btn-small d-flex mastodon-share-button")
            }.class("me-auto")
        }
    }
}
