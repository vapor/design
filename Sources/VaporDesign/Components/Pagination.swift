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
                    Link(url: "#") {
                        Span().class("vapor-icon icon-chevron-left")
                        Div {
                            Text("Previous")
                        }.class("d-none d-lg-block")
                    }.class("page-link page-link-next-previous d-flex page-link-previous").accessibilityLabel("Previous")
                }.class(previousClassList)
                pageLinks.append(previousLink)
                for pageNumber in 1...numberOfPages {
                    let pageLink = ListItem {
                        Link("\(pageNumber)", url: generatePageURL(pageNumber: pageNumber)).class("page-link")
                    }.class("page-item d-none d-lg-block")
                    pageLinks.append(pageLink)
                }
//                ListItem {
//                    Span {
//                        Text("1")
//                    }.class("page-link")
//                }.class("page-item active d-none d-lg-block").attribute(named: "aria-current", value: "page")
//
//                ListItem {
//                    Link("2", url: "#").class("page-link")
//                }.class("page-item d-none d-lg-block")
//                ListItem {
//                    Link("3", url: "#").class("page-link")
//                }.class("page-item d-none d-lg-block")
//                ListItem {
//                    Text("...")
//                }.class("page-item pagination-ellipsis d-none d-lg-block ms-1 me-1")
//                ListItem {
//                    Link("8", url: "#").class("page-link")
//                }.class("page-item d-none d-lg-block")
//                ListItem {
//                    Link("9", url: "#").class("page-link")
//                }.class("page-item d-none d-lg-block")
//                ListItem {
//                    Link("10", url: "#").class("page-link")
//                }.class("page-item d-none d-lg-block")
                let mobilePagination = ListItem {
                    Text("Page 1 of 10")
                }.class("page-item pagination-ellipsis d-lg-none")
                pageLinks.append(mobilePagination)
                let next = ListItem {
                    Link(url: "#") {
                        Div {
                            Text("Next")
                        }.class("d-none d-lg-block")
                        Span().class("vapor-icon icon-chevron-right")
                    }.class("page-link page-link-next-previous d-flex page-link-next").accessibilityLabel("Next")
                }.class("page-item ms-auto")
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
}
