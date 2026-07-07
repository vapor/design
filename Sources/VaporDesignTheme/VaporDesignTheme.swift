import Foundation
import LeafKit

public enum VaporDesignTheme {
    public static var directory: URL {
        guard let url = Bundle.module.url(forResource: "Theme", withExtension: nil) else {
            fatalError("VaporDesignTheme resources are missing from the bundle.")
        }
        return url
    }

    public static var leafTags: [String: any LeafTag] {
        ["designResource": DesignResourceTag()]
    }
}
