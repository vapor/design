import hljs from './hljsSetup';
import 'highlightjs-line-numbers.js';
import CopyButtonPlugin from 'highlightjs-copy';

hljs.addPlugin(new CopyButtonPlugin({ autohide: true }));

hljs.highlightAll();
hljs.initLineNumbersOnLoad();
