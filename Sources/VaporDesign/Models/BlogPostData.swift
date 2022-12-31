import Publish

public struct BlogPostExtraData {
    public let length: String
    public let author: BlogPostAuthor
    public let publishedDate: String
    
    public init(length: String, author: BlogPostAuthor, publishedDate: String) {
        self.length = length
        self.author = author
        self.publishedDate = publishedDate
    }
}

public struct BlogPostAuthor {
    let name: String
    let imageURL: String
    
    public init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
    }
}
