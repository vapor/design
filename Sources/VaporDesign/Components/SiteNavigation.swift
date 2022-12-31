import Plot
import Publish

public struct SiteNavigation<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?
    
    public init(context: PublishingContext<Site>, selectedSelectionID: Site.SectionID?) {
        self.context = context
        self.selectedSelectionID = selectedSelectionID
    }

    public var body: Component {
        Navigation {
            Div {
                Link(url: "/") {
                    Span().id("vapor-logo").class("d-inline-block align-text-top").accessibilityLabel("Vapor Logo").width(130).height(50)
                }.class("navbar-brand ms-3")
                
                Button {
                    Span().id("vapor-navbar-toggler-icon").class("vapor-icon icon-menu-04")
                }.class("navbar-toggler")
                    .attribute(named: "type", value: "button")
                    .accessibilityLabel("Toggle navigation")
                    .attribute(named: "data-bs-toggle", value: "collapse")
                    .attribute(named: "data-bs-target", value: "#navbarSupportedContent")
                    .attribute(named: "aria-controls", value: "navbarSupportedContent")
                    .attribute(named: "aria-expanded", value: "false")
                
                Div {
                    List {
                        ListItem {
                            #warning("Sort out all these links")
                            Link("Showcase", url: "#").class("nav-link")
                        }.class("nav-item")
                        ListItem {
                            Link("Documentation", url: "#")
                                .class("nav-link dropdown-toggle dropdown-no-outline")
                                .role("button")
                                .attribute(named: "data-bs-toggle", value: "dropdown")
                                .attribute(named: "aria-expanded", value: "fale")
                            
                            List {
                                ListItem {
                                    Link(url: "#") {
                                        Div {
                                            Span().class("vapor-icon icon-server-04")
                                            Div {
                                                Div {
                                                    Text("Framework Docs")
                                                }.class("nav-dropdown-container-title")
                                                Div {
                                                    Text("Learn how to use Vapor")
                                                }.class("nav-dropdown-container-caption")
                                            }.class("ms-3")
                                        }.class("nav-dropdown-container d-flex")
                                    }.class("dropdown-item")
                                }
                                
                                ListItem {
                                    Link(url: "#") {
                                        Div {
                                            Span().class("vapor-icon icon-dataflow-03")
                                            Div {
                                                Div {
                                                    Text("API Docs")
                                                }.class("nav-dropdown-container-title")
                                                Div {
                                                    Text("Reference documentation for Vapor")
                                                }.class("nav-dropdown-container-caption")
                                            }.class("ms-3")
                                        }.class("nav-dropdown-container d-flex")
                                    }.class("dropdown-item")
                                }
                            }.class("dropdown-menu").id("framework-dropdown-menu")
                        }.class("nav-item dropdown")
                        ListItem {
                            Link("Team", url: "#").class("nav-link")
                        }.class("nav-item")
                        ListItem {
                            Link("Community", url: "#").class("nav-link")
                        }.class("nav-item")
                        ListItem {
                            #warning("Build")
                            Link("Blog", url: "#").class("nav-link").attribute(named: "aria-current", value: "page")
                        }.class("nav-item active")
                        ListItem {
                            Link(url: "https://github.com/vapor") {
                                Span().class("vapor-icon icon-github-fill")
                            }.linkTarget(.blank).class("nav-link")
                        }.class("nav-item")
                        ListItem {
                            Link(url: "#") {
                                Span().class("vapor-icon").id("theme-switch-icon")
                            }.class("nav-link").id("theme-switch").accessibilityLabel("Toggle dark mode")
                        }.class("nav-item")
                    }.class("navbar-nav ms-auto mb-2 mb-lg-0")
                }.class("collapse navbar-collapse me-lg-3").id("navbarSupportedContent")
            }.class("container-fluid")
        }.class("navbar navbar-expand-lg").id("vapor-navbar")
    }
}
