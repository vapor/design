import type { HLJSApi } from 'highlight.js';

interface VaporLangSuggest {
    preview(locale?: string): void;
    reset(): void;
}

declare global {
    interface Window {
        hljs: HLJSApi;
        vaporLangSuggest: VaporLangSuggest;
        kilnSearchIndex: string | undefined;
        kilnVersionBase: string;
    }
}

export {};
