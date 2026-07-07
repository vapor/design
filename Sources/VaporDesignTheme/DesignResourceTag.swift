#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import LeafKit

public struct DesignResourceTag: LeafTag {
    public static let defaultBase = "https://design.vapor.codes"
    public static let environmentKey = "VAPOR_DESIGN_ASSET_URL"

    public init() {}

    public func render(_ ctx: LeafContext) throws -> LeafData {
        try ctx.requireParameterCount(1)
        guard let path = ctx.parameters[0].string else {
            throw LeafError(.unknownError(#"#designResource requires a string path, e.g. #designResource("main.js")"#))
        }
        return .string(Self.resourceURL(base: Self.resolvedBase, path: path))
    }

    public static func resourceURL(base: String, path: String) -> String {
        let trimmedBase = base.hasSuffix("/") ? String(base.dropLast()) : base
        let trimmedPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        return "\(trimmedBase)/\(trimmedPath)"
    }

    public static var resolvedBase: String {
        guard let override = ProcessInfo.processInfo.environment[environmentKey],
              !override.isEmpty else {
            return defaultBase
        }
        return override
    }
}
