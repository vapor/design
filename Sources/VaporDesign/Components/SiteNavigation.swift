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
                    // New teardrop mark (colour, theme-agnostic) + "Vapor" wordmark
                    // as text. Replaces the old single-colour lockup image.
                    Span().id("vapor-logo-mark").attribute(named: "aria-hidden", value: "true")
                    Span("Vapor").id("vapor-logo-text")
                }.class("navbar-brand ms-3 d-inline-flex align-items-center").accessibilityLabel("Vapor")

                // Custom off-canvas trigger (mobileNav.js) — replaces the Bootstrap
                // collapse so the menu can slide in as a right-side panel.
                Button {
                    Span {
                        Span("Toggle Navigation").class("visually-hidden")
                    }.id("vapor-navbar-toggler-icon").class("vapor-icon icon-menu-04")
                }.class("navbar-toggler")
                    .attribute(named: "type", value: "button")
                    .id("vapor-navmenu-toggle")
                    .accessibilityLabel("Toggle navigation")
                    .attribute(named: "aria-controls", value: "vapor-navmenu")
                    .attribute(named: "aria-expanded", value: "false")

                Div {
                    // Off-canvas close (X) — only visible inside the mobile panel.
                    Button {
                        Span().class("vapor-icon icon-x-close").attribute(named: "aria-hidden", value: "true")
                    }
                    .class("vapor-navmenu-close")
                    .id("vapor-navmenu-close")
                    .attribute(named: "type", value: "button")
                    .accessibilityLabel("Close menu")

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
                            ComponentGroup {
                                Link("Store", url: "https://store.vapor.codes").class("nav-link").linkTarget(.blank)
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
                                return ComponentGroup(members: [Link("Showcase", url: "https://www.vapor.codes/showcase").class("nav-link").linkTarget(.blank)])
                            }
                        }.class("nav-item")
                        ListItem {
                            var classList = "nav-link dropdown-no-outline d-flex"
                            if currentSite == .docs || currentSite == .apiDocs {
                                classList += " active"
                            }
                            var docsLink = Link(url: "#") {
                                Text("Documentation")
                                Span().class("vapor-icon icon-chevron-down ms-auto ms-sm-1").id("documentation-navbar-chevron")
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
                                            Span().class("vapor-icon icon-dataflow-03").attribute(named: "aria-hidden", value: "true")
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
                        }.class("nav-item dropdown vapor-doc-nav")
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
                                return ComponentGroup(members: [Link("Team", url: "https://www.vapor.codes/team").class("nav-link").linkTarget(.blank)])
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
                                Span {
                                    Span("GitHub").class("visually-hidden")
                                }.class("vapor-icon icon-github-fill").accessibilityLabel("GitHub")
                            }.linkTarget(.blank).class("nav-link").attribute(named: "rel", value: "me")
                        }.class("nav-item vapor-github-nav")
                        ListItem {
                            // Theme picker (Light / Dark / System). Replaces the old
                            // single #theme-switch toggle; behaviour is in themePicker.js.
                            // The toggle shows the current choice's icon (mirrored from
                            // the active option by JS); no chevron on desktop.
                            // The "Theme" label only shows in the mobile panel.
                            Span("Theme").class("vapor-nav-label").attribute(named: "aria-hidden", value: "true")
                            Link(url: "#") {
                                Span().class("theme-toggle-icon").attribute(named: "aria-hidden", value: "true")
                                // Name + chevron only show in the mobile panel; desktop is icon-only.
                                Span("System").class("theme-name")
                                Span().class("vapor-icon icon-chevron-down ms-1 theme-chevron").attribute(named: "aria-hidden", value: "true")
                            }
                            .class("nav-link dropdown-no-outline d-flex align-items-center theme-picker-toggle")
                            .id("theme-picker-toggle")
                            .role("button")
                            .attribute(named: "data-bs-toggle", value: "dropdown")
                            .attribute(named: "aria-expanded", value: "false")
                            .accessibilityLabel("Select theme")

                            List {
                                themeOption(value: "light", label: "Light", svg: Self.sunSVG)
                                themeOption(value: "dark", label: "Dark", svg: Self.moonSVG)
                                themeOption(value: "system", label: "System", svg: Self.monitorSVG)
                            }.class("dropdown-menu dropdown-menu-end animate slideIn")
                        }.class("nav-item dropdown theme-picker")
                    }.class("navbar-nav ms-auto mb-2 mb-lg-0")
                }.class("vapor-navmenu").id("vapor-navmenu")

                // Backdrop behind the mobile panel (tap to close).
                Div().class("vapor-nav-backdrop").id("vapor-nav-backdrop")
            }.class("container-fluid")
        }.class("navbar navbar-expand-lg").id("vapor-navbar")
    }

    // MARK: - Theme picker

    private func themeOption(value: String, label: String, svg: String) -> Component {
        ListItem {
            Link(url: "#") {
                Span {
                    Node<HTML.BodyContext>.raw(svg)
                }.class("theme-opt-icon").attribute(named: "aria-hidden", value: "true")
                Text(label)
            }
            .class("dropdown-item d-flex align-items-center")
            .attribute(named: "data-theme", value: value)
        }
    }

    // Inline SVGs (sun / moon / monitor) so they inherit `currentColor` and don't
    // depend on the icon-font / mask set. themePicker.js mirrors the active
    // option's icon onto the toggle.
    // Computed (not stored) so they're allowed on this generic type.
    private static var sunSVG: String { #"<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41"/></svg>"# }
    private static var moonSVG: String { #"<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>"# }
    private static var monitorSVG: String { #"<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="13" rx="2"/><path d="M8 21h8M12 17v4"/></svg>"# }
}
