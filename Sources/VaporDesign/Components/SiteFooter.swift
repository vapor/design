import Plot
import Foundation

public struct SiteFooter: Component {
    
    let isLocal: Bool
    let currentSite: CurrentSite
    
    public init(isLocal: Bool = false, currentSite: CurrentSite) {
        self.isLocal = isLocal
        self.currentSite = currentSite
    }
    
    public var body: Component {
        guard let year = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year else {
            fatalError("Unable to get the current year")
        }
        let footer = Footer {
            Div {
                Div {
                    Div {
                        Span {
                            
                        }.class("d-inline-block align-text-top")
                            .accessibilityLabel("Vapor Logo")
                            .id("vapor-logo-footer")
                            .width(197)
                            .height(76)
                        Div {
                            Text("Vapor provides a safe, performant and easy to use foundation to build HTTP servers, backends and APIs in Swift")
                        }.class("w-lg-50 mt-4")
                    }.id("footer-callout").class("col-md")
                    Div {
                        Div {
                            Div {
                                H6("Community").class("ps-lg-5")
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
                                }.class("ps-lg-5")
                            }.id("footer-community-links").class("col-6 ps-lg-5")
                            Div {
                                H6("Resources")
                                List {
                                    ListItem {
                                        if currentSite == .blog {
                                            Link("Blog", url: "/")
                                        } else {
                                            Link("Blog", url: "https://blog.vapor.codes").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        if currentSite == .docs {
                                            Link("Framework Docs", url: "/")
                                        } else {
                                            Link("Framework Docs", url: "https://docs.vapor.codes").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        if currentSite == .apiDocs {
                                            Link("API Docs", url: "/")
                                        } else {
                                            Link("API Docs", url: "https://api.vapor.codes").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        Link("Press Kit", url: "https://design.vapor.codes/VaporPressKit.zip").attribute(named: "download", value: nil)
                                    }
                                    ListItem {
                                        Link("Help", url: "#")
                                    }
                                    ListItem {
                                        Link("Contact", url: "#")
                                    }
                                }
                            }.id("footer-resources-links").class("col-6")
                        }.class("row")
                    }.class("mt-4 mt-lg-0 col-md")
                }.class("row")
                Node.hr()
                Div {
                    Div {
                        Text("&copy; QuTheory, LLC \(year)")
                    }.id("footer-copyright").class("my-auto")
                    
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
        let jsScript = Script(url: VaporDesignUtilities.buildResourceLink(for: "/main.js", isLocal: isLocal))
        return ComponentGroup {
            footer
            jsScript
        }
    }
}
