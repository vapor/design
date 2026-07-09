import Testing
import Foundation
import Kiln
import LeafKit
import VaporDesignTheme

// `.serialized` because the override test mutates a process-global env var that
// the default test asserts is absent.
@Suite("#designResource tag", .serialized)
struct DesignResourceTagTests {

    @Test("Joins base and path with a single slash")
    func joinsWithSingleSlash() {
        #expect(DesignResourceTag.resourceURL(base: "https://design.vapor.codes", path: "main.js")
            == "https://design.vapor.codes/main.js")
    }

    @Test("Tolerates a trailing slash on the base and a leading slash on the path")
    func toleratesExtraSlashes() {
        #expect(DesignResourceTag.resourceURL(base: "http://localhost:8001/", path: "/js/theme-init.js")
            == "http://localhost:8001/js/theme-init.js")
    }

    @Test("Renders the production CDN URL by default")
    func rendersCDNByDefault() async throws {
        unsetenv(DesignResourceTag.environmentKey)
        let html = try await renderFooter(
            ##"<footer><link href="#designResource("main.css")"><script src="#designResource("main.js")"></script></footer>"##
        )
        #expect(html.contains(##"href="https://design.vapor.codes/main.css""##))
        #expect(html.contains(##"src="https://design.vapor.codes/main.js""##))
    }

    @Test("VAPOR_DESIGN_ASSET_URL overrides the base")
    func envOverridesBase() async throws {
        setenv(DesignResourceTag.environmentKey, "http://localhost:8001", 1)
        defer { unsetenv(DesignResourceTag.environmentKey) }
        let html = try await renderFooter(
            ##"<footer><script src="#designResource("main.js")"></script></footer>"##
        )
        #expect(html.contains(##"src="http://localhost:8001/main.js""##))
        #expect(!html.contains("design.vapor.codes"))
    }

    /// Build a one-page site whose shared layer overrides `footer.leaf` with the
    /// given markup, rendered with the design system's Leaf tags.
    private func renderFooter(_ footer: String) async throws -> String {
        let shared = FileManager.default.temporaryDirectory
            .appendingPathComponent("vdt-theme-\(UUID().uuidString)")
        let partials = shared.appendingPathComponent("templates/partials")
        try FileManager.default.createDirectory(at: partials, withIntermediateDirectories: true)
        try footer.write(to: partials.appendingPathComponent("footer.leaf"), atomically: true, encoding: .utf8)

        let content = FileManager.default.temporaryDirectory
            .appendingPathComponent("vdt-content-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: content, withIntermediateDirectories: true)
        try "# Home\n\nHello.".write(to: content.appendingPathComponent("index.md"), atomically: true, encoding: .utf8)

        let output = FileManager.default.temporaryDirectory
            .appendingPathComponent("vdt-out-\(UUID().uuidString)")
        defer {
            try? FileManager.default.removeItem(at: shared)
            try? FileManager.default.removeItem(at: content)
            try? FileManager.default.removeItem(at: output)
        }

        let site = KilnSite(
            name: "Design Resource Test",
            url: "https://example.com",
            description: "Tag test.",
            theme: .default(sharedLayers: [shared]),
            languages: [.init(.english, isDefault: true)]
        ) {
            Page("Home", "index.md")
        }
        try await Kiln.build(
            site,
            contentDirectory: content,
            outputDirectory: output,
            linkChecking: .off,
            leafTags: VaporDesignTheme.leafTags
        )
        return try String(contentsOf: output.appendingPathComponent("index.html"), encoding: .utf8)
    }
}
