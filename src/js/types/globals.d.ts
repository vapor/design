import type { HLJSApi } from 'highlight.js';

// startSyntaxHighlighting publishes the highlight.js instance on window so the
// line-numbers plugin (which reads window.hljs at load) and any page scripts can
// reach it.
declare global {
    interface Window {
        hljs: HLJSApi;
    }
}

export {};
