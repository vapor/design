import Plot

import Plot
import Publish

public struct BlogCard<Site: Website>: Component {
    let blogPostData: BlogPostExtraData
    let item: Item<Site>
    let site: Site
    let isDemo: Bool
    
    public init(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site, isDemo: Bool = false) {
        self.blogPostData = blogPostData
        self.item = item
        self.site = site
        self.isDemo = isDemo
    }
    
    public var body: Component {
        Div {
            Div {
                Link(url: buildLinkForPost(item: item, isDemo: isDemo)) {
                    H2(item.title).class("card-title")
                }.class("blog-post-link")
                Paragraph(item.description).class("card-text")
                Div {
                    BlogPostAuthorComponent(blogPostData: blogPostData, postPage: false)
                    Div {
                        BlogTags(blogPostData: blogPostData, item: item, site: site, isDemo: isDemo)
                    }.class("col-lg blog-tags pt-4 pt-lg-0 d-flex align-items-center")
                }.class("row")
            }.class("card-body")
        }.class("card blog-card")
    }
        
    func buildLinkForPost(item: Item<Site>, isDemo: Bool) -> String {
        if isDemo {
            return "#"
        } else {
            return item.path.absoluteString
        }
    }
}
