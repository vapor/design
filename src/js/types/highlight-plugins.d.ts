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

declare module 'highlightjs-line-numbers.js';
