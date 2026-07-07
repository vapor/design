// Ambient declarations for the two highlight.js plugins that ship no types.
// (highlight.js itself bundles its own types, including the language subpaths.)

// Copy-to-clipboard button plugin. `module.exports = CopyButtonPlugin`, a class
// whose instance is an hljs plugin (implements the after:highlightElement hook),
// so instances satisfy highlight.js's HLJSPlugin.
declare module 'highlightjs-copy' {
    interface CopyButtonPluginOptions {
        autohide?: boolean;
        lang?: string;
        callback?: (text: string, el: Element) => void;
    }
    export default class CopyButtonPlugin {
        constructor(options?: CopyButtonPluginOptions);
        'after:highlightElement'(args: { el: Element; text: string }): void;
    }
}

// Line-numbers plugin: a side-effect UMD that augments window.hljs at load time
// (adds initLineNumbersOnLoad / lineNumbersBlock / lineNumbersValue). Imported
// only for its side effect, so no exports are needed here.
declare module 'highlightjs-line-numbers.js';
