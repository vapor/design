import Publish

public struct TagWithPostCount {
    public let tag: Tag
    public let postCount: Int
    
    public init(tag: Tag, postCount: Int) {
        self.tag = tag
        self.postCount = postCount
    }
}
