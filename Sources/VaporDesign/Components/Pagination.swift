import Plot
import Publish

public struct Pagination: Component {
    
    let activePage: Int
    let numberOfPages: Int
    let pageURL: (_ pageNumber: Int) -> String
    let isDemo: Bool
    
    public init(activePage: Int, numberOfPages: Int, pageURL: @escaping (Int) -> String, isDemo: Bool = false) {
        self.activePage = activePage
        self.numberOfPages = numberOfPages
        self.pageURL = pageURL
        self.isDemo = isDemo
    }
    
    public var body: Component {
        Navigation {
            List {
                var pageLinks = [Component]()
                var previousClassList = "page-item me-auto"
                if activePage == 1 {
                    previousClassList.append(" disabled")
                }
                let previousLink = ListItem {
                    let link: String
                    if activePage == 1 {
                        link = "#"
                    } else {
                        link = generatePageURL(pageNumber: activePage - 1)
                    }
                    return ComponentGroup {
                        Link(url: link) {
                            Span().class("vapor-icon icon-chevron-left").attribute(named: "aria-hidden", value: "true")
                            Div {
                                Text("Previous")
                            }.class("d-none d-lg-block")
                        }.class("page-link page-link-next-previous d-flex page-link-previous").accessibilityLabel("Previous")
                    }
                }.class(previousClassList)
                pageLinks.append(previousLink)
                var builtEllipsisBeforeActivePage = false
                var builtEllipsisAfterActivePage = false
                for pageNumber in 1...numberOfPages {
                    // The maximum number of pages we should show is 9:
                    // 1 2 3 ... 10 11 12 ... 19 20 21
                    // Where 11 is the current page
                    // So we always show the first three and last three
                    if numberOfPages > 9 {
                        // Check if we're generating outside the first and last 3 or around the active page
                        let activePageSet = [activePage - 1, activePage, activePage + 1]
                        if (pageNumber > 3 && pageNumber <= numberOfPages - 3) && !activePageSet.contains(pageNumber) {
                            
                            // We now need to build ellipsis - we should only do this once before and after the active page
                            if !builtEllipsisBeforeActivePage && pageNumber < activePage {
                                builtEllipsisBeforeActivePage = true
                            } else if !builtEllipsisAfterActivePage && pageNumber > activePage {
                                builtEllipsisAfterActivePage = true
                            } else {
                                // If we hit here without either of the above conditions then we've already built an ellipsis and can skip
                                continue
                            }
                            let ellipsisLink = buildEllipsisPageLink()
                            pageLinks.append(ellipsisLink)
                            continue
                        }
                    }
                    
                    let pageLink = buildPageLink(pageNumber: pageNumber)
                    pageLinks.append(pageLink)
                }

                let mobilePagination = ListItem {
                    Text("Page \(activePage) of \(numberOfPages)")
                }.class("page-item pagination-ellipsis d-lg-none")
                pageLinks.append(mobilePagination)
                var nextClassList = "page-item ms-auto"
                if activePage == numberOfPages {
                    nextClassList.append(" disabled")
                }
                let next = ListItem {
                    let link: String
                    if activePage == numberOfPages {
                        link = "#"
                    } else {
                        link = generatePageURL(pageNumber: activePage + 1)
                    }
                    return ComponentGroup {
                        Link(url: link) {
                            Div {
                                Text("Next")
                            }.class("d-none d-lg-block")
                            Span().class("vapor-icon icon-chevron-right").attribute(named: "aria-hidden", value: "true")
                        }.class("page-link page-link-next-previous d-flex page-link-next").accessibilityLabel("Next")
                    }
                }.class(nextClassList)
                pageLinks.append(next)
                return ComponentGroup(members: pageLinks)
            }.class("pagination justify-content-center")
        }.accessibilityLabel("blog-pagination")
    }
    
    func generatePageURL(pageNumber: Int) -> String {
        if isDemo {
            return "#"
        } else {
            return pageURL(pageNumber)
        }
    }
    
    func buildPageLink(pageNumber: Int) -> Component {
        var linkClassList = "page-item d-none d-lg-block"
        let generatingCurrentPageLink = pageNumber == activePage
        var pageLink: Component = ListItem {
            if generatingCurrentPageLink {
                Span {
                    Text("\(pageNumber)")
                }.class("page-link")
            } else {
                Link("\(pageNumber)", url: generatePageURL(pageNumber: pageNumber)).class("page-link")
            }
        }
        if generatingCurrentPageLink {
            linkClassList.append(" active")
            pageLink = pageLink.attribute(named: "aria-current", value: "page")
        }
        
        pageLink = pageLink.class(linkClassList)
        return pageLink
    }
    
    func buildEllipsisPageLink() -> Component {
        ListItem {
            Text("...")
        }.class("page-item pagination-ellipsis d-none d-lg-block ms-1 me-1")
    }
}
