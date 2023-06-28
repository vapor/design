import Plot
import Foundation

public struct SiteFooter: Component {
    
    let isLocal: Bool
    let isDemo: Bool
    let currentSite: CurrentSite
    
    public init(isLocal: Bool = false, isDemo: Bool = false, currentSite: CurrentSite) {
        self.isLocal = isLocal
        self.isDemo = isDemo
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
                        Span().class("d-inline-block align-text-top")
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
                                        if isDemo {
                                            Link("Team", url: "#").class("nav-link")
                                        } else if currentSite == .main {
                                            Link("Team", url: "/team").class("nav-link")
                                        } else {
                                            #warning("Fix link")
                                            Link("Team", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        Link("Join our Discord", url: "https://vapor.team").linkTarget(.blank).class("nav-link")
                                    }
                                    ListItem {
                                        if isDemo {
                                            Link("Evangelists", url: "#").class("nav-link")
                                        } else if currentSite == .main {
                                            Link("Evangelists", url: "/evangelists").class("nav-link")
                                        } else {
                                            #warning("Fix link")
                                            Link("Evangelists", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        if isDemo {
                                            Link("Showcase", url: "#").class("nav-link")
                                        } else if currentSite == .main {
                                            Link("Showcase", url: "/showcase").class("nav-link")
                                        } else {
                                            #warning("Fix link")
                                            Link("Showcase", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)
                                        }
                                    }
                                    ListItem {
                                        if isDemo {
                                            Link("Supporters", url: "#").class("nav-link")
                                        } else if currentSite == .main {
                                            Link("Supporters", url: "/supporters").class("nav-link")
                                        } else {
                                            #warning("Fix link")
                                            Link("Supporters", url: "https://www.vapor.codes/").class("nav-link").linkTarget(.blank)
                                        }
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
                                            Link("Blog", url: "https://blog.vapor.codes").linkTarget(.blank).class("nav-link")
                                        }
                                    }
                                    ListItem {
                                        if currentSite == .docs {
                                            Link("Framework Docs", url: "/")
                                        } else {
                                            Link("Framework Docs", url: "https://docs.vapor.codes").linkTarget(.blank).class("nav-link")
                                        }
                                    }
                                    ListItem {
                                        if currentSite == .apiDocs {
                                            Link("API Docs", url: "/").class("nav-link")
                                        } else {
                                            Link("API Docs", url: "https://api.vapor.codes").linkTarget(.blank).class("nav-link")
                                        }
                                    }
                                    ListItem {
                                        Link("Press Kit", url: "https://design.vapor.codes/VaporPressKit.zip").attribute(named: "download", value: nil).class("nav-link")
                                    }
                                    ListItem {
                                        Link("Help", url: "https://vapor.team").linkTarget(.blank).class("nav-link")
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
                                }.linkTarget(.blank).attribute(named: "rel", value: "me")
                            }.class("me-4")
                            ListItem {
                                Link(url: "https://hachyderm.io/@codevapor") {
                                    Span().class("vapor-icon icon-mastodon-fill")
                                }.linkTarget(.blank).attribute(named: "rel", value: "me")
                            }.class("me-4")
                            ListItem {
                                Link(url: "https://github.com/vapor") {
                                    Span().class("vapor-icon icon-github-fill")
                                }.linkTarget(.blank).attribute(named: "rel", value: "me")
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
