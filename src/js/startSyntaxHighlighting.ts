// Hacks the line number CSS because that's apparently not a thing you can turn off
import './suppressLineNumberStyles';
import hljs from './hljsSetup';
import 'highlightjs-line-numbers.js';
import CopyButtonPlugin from 'highlightjs-copy';

hljs.addPlugin(new CopyButtonPlugin({ autohide: true }));

// Skip Kiln's DocC declaration blocks: they're already tokenised server-side and
// have no language class, so highlight.js would auto-detect the wrong language —
// splitting `associatedtype` and clobbering the inline type links.
hljs.configure({ cssSelector: 'pre:not(.declaration) code' });
hljs.highlightAll();
hljs.initLineNumbersOnLoad();
