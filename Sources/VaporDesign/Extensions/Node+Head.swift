import Plot
import Publish

public extension Node where Context == HTML.DocumentContext {
    /// Add an HTML `<head>` tag within the current context, based
    /// on inferred information from the current location and `Website`
    /// implementation.
    /// - parameter location: The location to generate a `<head>` tag for.
    /// - parameter site: The website on which the location is located.
    /// - parameter titleSeparator: Any string to use to separate the location's
    ///   title from the name of the website. Default: `" | "`.
    /// - parameter stylesheetPaths: The paths to any stylesheets to add to
    ///   the resulting HTML page. Default: `styles.css`.
    /// - parameter rssFeedPath: The path to any RSS feed to associate with the
    ///   resulting HTML page. Default: `feed.rss`.
    /// - parameter rssFeedTitle: An optional title for the page's RSS feed.
    static func head<T: Website>(
        for location: Location,
        on site: T,
        titleSeparator: String = " | ",
        stylesheetPaths: [Path] = ["/styles.css"],
        scripts: [Path] = [],
        rssFeedPath: Path? = .defaultForRSSFeed,
        rssFeedTitle: String? = nil,
        isLocal: Bool
    ) -> Node {
        var title = location.title
        
        if title.isEmpty {
            title = site.name
        } else {
            title.append(titleSeparator + site.name)
        }
        
        var description = location.description
        
        if description.isEmpty {
            description = site.description
        }
        
        return .head(
            .encoding(.utf8),
            .siteName(site.name),
            .url(site.url(for: location)),
            .title(title),
            .description(description),
            .twitterCardType(location.imagePath == nil ? .summary : .summaryLargeImage),
            .forEach(stylesheetPaths, { .stylesheet($0) }),
            .forEach(scripts, { .script(.src($0.absoluteString)) }),
            .viewport(.accordingToDevice),
            .meta(.attribute(named: "name", value: "color-scheme"), .attribute(named: "content", value: "light dark")),
            .buildFavicons(isLocal: isLocal),
            .unwrap(rssFeedPath, { path in
                let title = rssFeedTitle ?? "Subscribe to \(site.name)"
                return .rssFeedLink(path.absoluteString, title: title)
            }),
            .unwrap(location.imagePath ?? site.imagePath, { path in
                let url = site.url(for: path)
                return .socialImageLink(url)
            })
        )
    }
    
}

public extension Node where Context == HTML.HeadContext {
    
    static func buildFavicons(isLocal: Bool) -> Node {
        let touchIconURL = VaporDesignUtilities.buildResourceLink(for: "/favicons/apple-touch-icon.png", isLocal: isLocal)
        let icon32URL = VaporDesignUtilities.buildResourceLink(for: "/favicons/favicon-32x32.png", isLocal: isLocal)
        let icon16URL = VaporDesignUtilities.buildResourceLink(for: "/favicons/favicon-16x16.png", isLocal: isLocal)
        let touchIconLink = Node<HTML.HeadContext>.link(
            .rel(.appleTouchIcon),
            .sizes("180x180"),
            .href(touchIconURL)
        )
        let icon32Link = Node<HTML.HeadContext>.link(
            .rel(.icon),
            .sizes("32x32"),
            .href(icon32URL),
            .attribute(named: "type", value: "image/png")
        )
        
        let icon16Link = Node<HTML.HeadContext>.link(
            .rel(.icon),
            .sizes("16x16"),
            .href(icon16URL),
            .attribute(named: "type", value: "image/png")
        )
        
        let manifestURL = VaporDesignUtilities.buildResourceLink(for: "/favicons/site.webmanifest", isLocal: isLocal)
        let manifestLink = Node<HTML.HeadContext>.link(
            .rel(.manifest),
            .href(manifestURL)
        )
        
        let shortcutURL = VaporDesignUtilities.buildResourceLink(for: "/favicons/favicon.ico", isLocal: isLocal)
        let shortcutLink = Node<HTML.HeadContext>.link(
            .rel(.shortcutIcon),
            .href(shortcutURL)
        )
        
        let msApplicationTileMeta = Node<HTML.HeadContext>.meta(
            .name("msapplication-TileColor"),
            .content("#da532c")
        )
        
        let msApplicationURL = VaporDesignUtilities.buildResourceLink(for: "/favicons/browserconfig.xml", isLocal: isLocal)
        let msApplicationConfig = Node<HTML.HeadContext>.meta(
            .name("msapplication-config"),
            .content(msApplicationURL)
        )
        
        let themeColor = Node<HTML.HeadContext>.meta(
            .name("theme-color"),
            .content("#ffffff")
        )
        
        return .group(
            touchIconLink,
            icon32Link,
            icon16Link,
            manifestLink,
            shortcutLink,
            msApplicationTileMeta,
            msApplicationConfig,
            themeColor
        )
    }
}
