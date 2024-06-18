import Plot
import Publish

public struct SiteNavigation<Site: Website>: Component {
    let context: PublishingContext<Site>
    let selectedSelectionID: Site.SectionID?
    let currentSite: CurrentSite
    let currentMainSitePage: CurrentPage?
    let isDemo: Bool

    public init(context: PublishingContext<Site>, selectedSelectionID: Site.SectionID?, currentSite: CurrentSite, currentMainSitePage: CurrentPage?, isDemo: Bool = false) {
        self.context = context
        self.selectedSelectionID = selectedSelectionID
        self.currentSite = currentSite
        self.currentMainSitePage = currentMainSitePage
        self.isDemo = isDemo
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
                            if currentSite == .main {
                                var classList = "nav-link"
                                if currentMainSitePage == .home {
                                    classList += " active"
                                }
                                let link = if isDemo {
                                    Link("Home", url: "#").class(classList)
                                } else {
                                    Link("Home", url: "/").class(classList)
                                }

                                return ComponentGroup(members: [link])
                            } else {
                                return ComponentGroup(members: [Link("Home", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)])
                            }
                        }.class("nav-item")
                        ListItem {
                            if currentSite == .main {
                                var classList = "nav-link"
                                if currentMainSitePage == .showcase {
                                    classList += " active"
                                }

                                let link = if isDemo {
                                    Link("Showcase", url: "#").class(classList)
                                } else {
                                    Link("Showcase", url: "/showcase").class(classList)
                                }

                                return ComponentGroup(members: [link])
                            } else {
                                #warning("Fix link")
                                return ComponentGroup(members: [Link("Showcase", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)])
                            }
                        }.class("nav-item")
                        ListItem {
                            var classList = "nav-link dropdown-no-outline d-flex"
                            if currentSite == .docs || currentSite == .apiDocs {
                                classList += " active"
                            }
                            var docsLink = Link(url: "#") {
                                Text("Documentation")
                                Span().class("vapor-icon icon-chevron-down ms-auto ms-lg-3").id("documentation-navbar-chevron")
                            }
                            .class(classList)
                            .id("documentation-dropdown-link")
                            .role("button")
                            .attribute(named: "data-bs-toggle", value: "dropdown")
                            .attribute(named: "aria-expanded", value: "false")

                            if currentSite == .docs || currentSite == .apiDocs {
                                docsLink = docsLink.attribute(named: "aria-current", value: "page")
                            }
                            return ComponentGroup {
                                docsLink

                                List {
                                    ListItem {
                                        let linkBody = Div {
                                            Span().class("vapor-icon icon-server-04")
                                            Div {
                                                Div {
                                                    Text("Framework Docs")
                                                }.class("nav-dropdown-container-title")
                                                Div {
                                                    Text("Learn how to use Vapor")
                                                }.class("nav-dropdown-container-caption d-none d-lg-block")
                                            }.class("ms-3")
                                        }.class("nav-dropdown-container d-flex")

                                        if currentSite == .docs {
                                            Link(url: "/") {
                                                linkBody
                                            }.class("dropdown-item")
                                        } else {
                                            Link(url: "https://docs.vapor.codes") {
                                                linkBody
                                            }.class("dropdown-item").linkTarget(.blank)
                                        }
                                    }.class("m-lg-2")

                                    ListItem {
                                        let linkBody = Div {
                                            Span().class("vapor-icon icon-dataflow-03")
                                            Div {
                                                Div {
                                                    Text("API Docs")
                                                }.class("nav-dropdown-container-title")
                                                Div {
                                                    Text("Reference documentation for Vapor")
                                                }.class("nav-dropdown-container-caption d-none d-lg-block")
                                            }.class("ms-3")
                                        }.class("nav-dropdown-container d-flex")

                                        if currentSite == .apiDocs {
                                            Link(url: "/") {
                                                linkBody
                                            }.class("dropdown-item")
                                        } else {
                                            Link(url: "https://api.vapor.codes") {
                                                linkBody
                                            }.class("dropdown-item").linkTarget(.blank)
                                        }
                                    }.class("m-lg-2")
                                }.class("dropdown-menu animate slideIn").id("framework-dropdown-menu")
                            }
                        }.class("nav-item dropdown")
                        ListItem {
                            if currentSite == .main {
                                var classList = "nav-link"
                                if currentMainSitePage == .team {
                                    classList += " active"
                                }
                                let link = if isDemo {
                                    Link("Team", url: "#").class(classList)
                                } else {
                                    Link("Team", url: "/team").class(classList)
                                }

                                return ComponentGroup(members: [link])
                            } else {
                                #warning("Fix link")
                                return ComponentGroup(members: [Link("Team", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)])
                            }
                        }.class("nav-item")
                        ListItem {
                            if currentSite == .blog {
                                Link("Blog", url: "/").class("nav-link active").attribute(named: "aria-current", value: "page")
                            } else {
                                Link("Blog", url: "https://blog.vapor.codes").class("nav-link").linkTarget(.blank)
                            }

                        }.class("nav-item")
                        ListItem {
                            Link(url: "https://github.com/vapor") {
                                Span().class("vapor-icon icon-github-fill")
                            }.linkTarget(.blank).class("nav-link").attribute(named: "rel", value: "me")
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
