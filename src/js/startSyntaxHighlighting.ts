// Hacks the line number CSS because that's apparently not a thing you can turn off
import './suppressLineNumberStyles';
import hljs from './hljsSetup';
import 'highlightjs-line-numbers.js';
import CopyButtonPlugin from 'highlightjs-copy';

hljs.addPlugin(new CopyButtonPlugin({ autohide: true }));

hljs.highlightAll();
hljs.initLineNumbersOnLoad();
