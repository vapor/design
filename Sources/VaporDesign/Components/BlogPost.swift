import Plot
import Publish

public struct BlogPost<Site: Website>: Component {
    let blogPostData: BlogPostExtraData
    let item: Item<Site>
    let site: Site
    
    public init(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site) {
        self.blogPostData = blogPostData
        self.item = item
        self.site = site
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
                        buildBlogPostTagList()
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
                Div {
                    Image(url: blogPostData.author.imageURL, description: blogPostData.author.name).id("blog-post-author-image").class("me-2")
                    Div {
                        Div {
                            Text(blogPostData.author.name)
                        }.id("blog-post-author-name")
                        Div {
                            Text(blogPostData.publishedDate)
                        }.id("blog-post-publish-date")
                    }.id("blog-post-author-date-container")
                }.id("blog-post-author").class("d-flex col-lg-6")
                
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
                buildBlogPostTagList()
            }.id("blog-bottom-tags").class("blog-tags col-lg-6")
            Div {
                buildBlogPostShareList()
            }.class("ms-auto blog-share col-lg-6").id("blog-bottom-share")
        }.id("blog-post-bottom").class("row")
    }
    
    func buildBlogPostTagList() -> Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
    }
    
    func buildBlogPostShareList() -> Component {
        List {
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-copy-06 me-2")
                    Text("Copy Link")
                }.class("btn btn-secondary btn-small d-flex")
            }
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-twitter-fill")
                }.class("btn btn-secondary btn-small")
            }
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-reddit-fill")
                }.class("btn btn-secondary btn-small")
            }
            ListItem {
                Link(url: "#") {
                    Span().class("vapor-icon icon-facebook-circle-fill")
                }.class("btn btn-secondary btn-small")
            }
        }
    }
}
