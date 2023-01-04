import Plot
import Publish

public struct Pagination: Component {
    
    public init() {
    }
    
    public var body: Component {
        Navigation {
            List {
                ListItem {
                    Link(url: "#") {
                        Span().class("vapor-icon icon-chevron-left")
                        Div {
                            Text("Previous")
                        }.class("d-none d-lg-block")
                    }.class("page-link page-link-next-previous d-flex page-link-previous").accessibilityLabel("Previous")
                }.class("page-item me-auto")
                ListItem {
                    Span {
                        Text("1")
                    }.class("page-link")
                }.class("page-item active d-none d-lg-block").attribute(named: "aria-current", value: "page")
                
                ListItem {
                    Link("2", url: "#").class("page-link")
                }.class("page-item d-none d-lg-block")
                ListItem {
                    Link("3", url: "#").class("page-link")
                }.class("page-item d-none d-lg-block")
                ListItem {
                    Text("...")
                }.class("page-item pagination-ellipsis d-none d-lg-block ms-1 me-1")
                ListItem {
                    Link("8", url: "#").class("page-link")
                }.class("page-item d-none d-lg-block")
                ListItem {
                    Link("9", url: "#").class("page-link")
                }.class("page-item d-none d-lg-block")
                ListItem {
                    Link("10", url: "#").class("page-link")
                }.class("page-item d-none d-lg-block")
                ListItem {
                    Text("Page 1 of 10")
                }.class("page-item pagination-ellipsis d-lg-none")
                ListItem {
                    Link(url: "#") {
                        Div {
                            Text("Next")
                        }.class("d-none d-lg-block")
                        Span().class("vapor-icon icon-chevron-right")
                    }.class("page-link page-link-next-previous d-flex page-link-next").accessibilityLabel("Next")
                }.class("page-item ms-auto")
            }.class("pagination justify-content-center")
        }.accessibilityLabel("blog-pagination")
    }
}
