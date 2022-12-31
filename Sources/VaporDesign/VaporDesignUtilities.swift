import Plot

public enum VaporDesignUtilities {
    public static func buildResourceLink(for url: String, isLocal: Bool) -> String {
        if isLocal {
            return url
        } else {
            return "https://design.vapor.codes\(url)"
        }
    }
}
