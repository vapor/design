import Publish

public struct TagWithPostCount {
    let tag: Tag
    let postCount: Int
    
    public init(tag: Tag, postCount: Int) {
        self.tag = tag
        self.postCount = postCount
    }
}
