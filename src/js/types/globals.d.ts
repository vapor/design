import type { HLJSApi } from 'highlight.js';

// QA helper published by languageSuggestion.ts for manual testing in DevTools.
interface VaporLangSuggest {
    preview(locale?: string): void;
    reset(): void;
}

declare global {
    interface Window {
        // startSyntaxHighlighting publishes the highlight.js instance so the
        // line-numbers plugin (which reads window.hljs at load) and page scripts
        // can reach it.
        hljs: HLJSApi;
        vaporLangSuggest: VaporLangSuggest;
        // Set by searchInit from <body> data- attributes; read by Kiln's search.js.
        kilnSearchIndex: string | undefined;
        kilnVersionBase: string;
    }
}

export {};
