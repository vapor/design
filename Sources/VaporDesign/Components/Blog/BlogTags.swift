import Plot
import Publish

public struct BlogTags<Site: Website>: Component {
    let blogPostData: BlogPostExtraData
    let isDemo: Bool
    let item: Item<Site>
    let site: Site
    
    public init(blogPostData: BlogPostExtraData, item: Item<Site>, site: Site, isDemo: Bool) {
        self.blogPostData = blogPostData
        self.item = item
        self.site = site
        self.isDemo = isDemo
    }
    
    public var body: Component {
        List {
            for (index, tag) in item.tags.enumerated() {
                if index == 0 {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }.class("my-1")
                } else if index == item.tags.count - 1 {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }.class("my-1")
                } else {
                    ListItem {
                        if isDemo {
                            Link(tag.string, url: "#")
                        } else {
                            Link(tag.string, url: site.path(for: tag).absoluteString)
                        }
                    }.class("my-1")
                }
            }
        }.class("mx-auto mx-lg-0 flex-wrap")
    }
}
