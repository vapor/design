import Plot

public struct SiteFooter: Component {
    
    var isLocal: Bool
    var isMainSite: Bool
    
    public init(isLocal: Bool = false, isMainSite: Bool = false) {
        self.isLocal = isLocal
        self.isMainSite = isMainSite
    }
    
    public var body: Component {
        Footer {
            Div {
                Div {
                    Div {
                        Span {
                            
                        }.class("d-inline-block align-text-top").accessibilityLabel("Vapor Logo").id("vapor-logo-footer").attribute(named: "width", value: "197").attribute(named: "height", value: "76")
                        Div {
                            Text("Vapor provides a safe, performant and easy to use foundation to build HTTP servers, backends and APIs in Swift")
                        }.class("w-50 mt-4")
                    }.id("footer-callout").class("col-lg-6")
                    Div {
                        H6("Community").class("ps-5")
                        List {
                            ListItem {
                                Link("Team", url: "#")
                            }
                            ListItem {
                                Link("Contributors", url: "#")
                            }
                            ListItem {
                                Link("Join our Discord", url: "https://vapor.team").linkTarget(.blank)
                            }
                            ListItem {
                                Link("Evangelists", url: "#")
                            }
                            ListItem {
                                Link("Showcase", url: "#")
                            }
                            ListItem {
                                Link("Supporters", url: "#")
                            }
                        }.class("ps-5")
                    }.id("footer-community-links").class("col-lg-3 col-6 ps-5")
                    Div {
                        H6("Resources")
                        List {
                            ListItem {
                                Link("Blog", url: "https://blog.vapor.codes").linkTarget(.blank)
                            }
                            ListItem {
                                Link("Framework Docs", url: "https://docs.vapor.codes").linkTarget(.blank)
                            }
                            ListItem {
                                Link("API Docs", url: "https://api.vapor.codes").linkTarget(.blank)
                            }
                            ListItem {
                                Link("Press Kit", url: "https://design.vapor.codes/presskit.zip").attribute(named: "download", value: nil)
                            }
                            ListItem {
                                Link("Help", url: "#")
                            }
                            ListItem {
                                Link("Contact", url: "#")
                            }
                        }
                    }.id("footer-resources-links").class("col-lg-3 col-6")
                }.class("row")
                Node.hr()
                Div {
                    Div {
                        Text("&copy; QuTheory, LLC 2022")
                    }.id("footer-copyright")
                    
                    Div {
                        List {
                            ListItem {
                                Link(url: "https://twitter.com/codevapor") {
                                    Span().class("vapor-icon icon-twitter-fill")
                                }.linkTarget(.blank)
                            }.class("me-4")
                            ListItem {
                                Link(url: "https://github.com/vapor") {
                                    Span().class("vapor-icon icon-github-fill")
                                }.linkTarget(.blank)
                            }
                        }.class("d-flex")
                    }.id("footer-social-links").class("ms-auto")
                }.id("footer-bottom")
            }.class("container mt-5")
        }.class("mt-5")
    }
    
    func buildNavLink(to url: URLRepresentable, label: String) -> Link {
        return Link(label, url: url)
    }
}
