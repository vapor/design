import Plot
import Publish

public struct BlogPostAuthorComponent: Component {
    let blogPostData: BlogPostExtraData
    let postPage: Bool
    
    public init(blogPostData: BlogPostExtraData, postPage: Bool) {
        self.blogPostData = blogPostData
        self.postPage = postPage
    }
    
    public var body: Component {
        Div {
            Image(url: blogPostData.author.imageURL, description: blogPostData.author.name).class("blog-post-author-image").class("me-2")
            Div {
                Div {
                    Text(blogPostData.author.name)
                }.class("blog-post-author-name")
                Div {
                    if postPage {
                        Text("Published ")
                    }
                    Text(blogPostData.publishedDate)
                }.class("blog-post-publish-date")
            }.class("blog-post-author-date-container")
        }.class("blog-post-author").class("d-flex col-lg-6")
    }
}
