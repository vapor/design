import Plot
import Publish

public struct BlogTagList<Site: Website>: Component {
    let isDemo: Bool
    let tags: [TagWithPostCount]
    let site: Site
    let selectedTag: Tag?
    let totalPosts: Int
    
    public init(tags: [TagWithPostCount], site: Site, selectedTag: Tag?, totalPosts: Int, isDemo: Bool = false) {
        self.isDemo = isDemo
        self.tags = tags
        self.site = site
        self.selectedTag = selectedTag
        self.totalPosts = totalPosts
    }
    
    public var body: Component {
        Div {
            H5("Blog Tags").class("list-heading")
            
            List {
                ListItem {
                    let allTagsURL: String
                    if isDemo {
                        allTagsURL = "#"
                    } else {
                        allTagsURL = site.tagListPath.absoluteString
                    }
                    var classList = "tag-link d-flex align-items-center"
                    if selectedTag == nil {
                        classList.append(" active")
                    }
                    return ComponentGroup {
                        Link(url: allTagsURL) {
                            Text("View All")
                            Span {
                                Text("\(totalPosts)")
                            }.class("badge ms-2")
                        }.class(classList)
                    }
                }.class("tag-list-tag")
                
                for tag in tags {
                    ListItem {
                        let tagURL: String
                        if isDemo {
                            tagURL = "#"
                        } else {
                            tagURL = site.path(for: tag.tag).absoluteString
                        }
                        var classList = "tag-link d-flex align-items-center"
                        if selectedTag == tag.tag {
                            classList.append(" active")
                        }
                        return ComponentGroup {
                            Link(url: tagURL) {
                                Text(tag.tag.string)
                                Span {
                                    Text("\(tag.postCount)")
                                }.class("badge ms-2")
                            }.class(classList)
                        }
                    }.class("tag-list-tag")
                }
            }
        }.class("blog-tag-list")
    }
}
