import Plot

/// Component used to render an `<script>` element for embetdding scripts.
public struct Script: Component {
    /// The URL of the script.
    public var url: URLRepresentable

    /// Create a new script instance.
    /// - parameters:
    ///   - url: The URL of the script to include.
    public init(url: URLRepresentable) {
        self.url = url
    }

    public var body: Component {
        Node<HTML.BodyContext>.script(.src(url))
    }
}
