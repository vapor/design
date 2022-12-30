import PackagePlugin
import Foundation

@main
struct MySwiftLintPlugin: BuildToolPlugin {
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    let dir = context.pluginWorkDirectory.appending("Output")
    // var isDir:ObjCBool = true
    // if !FileManager.default.fileExists(atPath: dir.string, isDirectory: &isDir) {
    //   try FileManager.default.removeItem(atPath: dir.string)
    //   try FileManager.default.createDirectory(atPath: dir.string, withIntermediateDirectories: false)
    // }    

    return [
      .prebuildCommand(
        displayName: "Execute Command",
        executable: .init("pwd"),
        arguments: [/*"run", "build"*/],
        outputFilesDirectory: dir
      )
    ]
  }
}
