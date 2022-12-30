import Plot

public struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider
    
    public init(content: @escaping ContentProvider) {
        self.content = content
    }
    
    public var body: Component {
        Div(content: content).class("wrapper")
    }
}
