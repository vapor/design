import Plot
import Publish

public struct BlogTagList<Site: Website>: Component {
    let isDemo: Bool
    let tags: [Tag]
    let site: Site
    let selectedTag: Tag?
    
    public init(tags: [Tag], site: Site, selectedTag: Tag?, isDemo: Bool = false) {
        self.isDemo = isDemo
        self.tags = tags
        self.site = site
        self.selectedTag = selectedTag
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
                    var classList = "tag-link"
                    if selectedTag == nil {
                        classList.append(" active")
                    }
                    return ComponentGroup(Link("View All", url: allTagsURL).class(classList))
                }.class("tag-list-tag")
                
                for tag in tags {
                    ListItem {
                        let tagURL: String
                        if isDemo {
                            tagURL = "#"
                        } else {
                            tagURL = site.path(for: tag).absoluteString
                        }
                        var classList = "tag-link"
                        if selectedTag == nil {
                            classList.append(" active")
                        }
                        return ComponentGroup(Link(tag.string, url: tagURL).class(classList))
                    }.class("tag-list-tag")
                }
            }
        }.class("blog-tag-list")
    }
}
