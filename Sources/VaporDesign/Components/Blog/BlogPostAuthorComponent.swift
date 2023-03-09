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
            if blogPostData.contributingAuthors.isEmpty {
                Image(url: blogPostData.author.imageURL, description: blogPostData.author.name).class("blog-post-author-image").class("me-2")
            } else {
                Div {
                    Div {
                        Image(url: blogPostData.author.imageURL, description: blogPostData.author.name).class("blog-post-author-image").class("me-2")
                    }.class("col")
                    for author in blogPostData.contributingAuthors {
                        Div {
                            Image(url: author.imageURL, description: author.name).class("blog-post-author-image").class("me-2")
                        }.class("col")
                    }
                }.class("row row-cols-auto g-0")
            }
            Div {
                Div {
                    Div {
                        Text(blogPostData.author.name)
                    }
                    for author in blogPostData.contributingAuthors {
                        Div {
                            Text(author.name)
                        }
                    }
//                    if blogPostData.contributingAuthors.count > 1 {
//                        Text(", \(blogPostData.contributingAuthors.map(\.name).joined(separator: ", "))")
//                    } else if !blogPostData.contributingAuthors.isEmpty {
//                        Text(" &amp; \(blogPostData.contributingAuthors[0].name)")
//                    }
                }.class("blog-post-author-name")
                Div {
                    if postPage {
                        Text("Published ")
                    }
                    Text(blogPostData.publishedDate)
                }.class("blog-post-publish-date")
            }.class("blog-post-author-date-container \(blogPostData.contributingAuthors.isEmpty ? "" : "mt-3")")
        }.class("blog-post-author").class("col-lg \(blogPostData.contributingAuthors.isEmpty ? "d-flex" : "flex-wrap")")
    }
}
