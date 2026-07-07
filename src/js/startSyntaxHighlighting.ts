// Syntax highlighting for every code block.
//
// Import order matters and encodes the runtime ordering:
//   1. ./hljsSetup           — registers the languages and sets window.hljs
//   2. highlightjs-line-numbers.js — a UMD that reads window.hljs at load and
//      augments it with initLineNumbersOnLoad(); must run *after* step 1
//   3. highlightjs-copy      — the copy-to-clipboard button plugin
// ES modules evaluate imports in source order, so listing hljsSetup first
// guarantees window.hljs exists before the line-numbers plugin loads.
import hljs from './hljsSetup';
import 'highlightjs-line-numbers.js';
import CopyButtonPlugin from 'highlightjs-copy';

// Copy-to-clipboard button on every code block (styled in syntax.scss).
// The plugin captures each block's source at highlight time, so the copy
// excludes the line-number gutter. autohide:true reveals the button only while
// the code block is hovered (styled in syntax.scss off the data-autohide
// attribute the plugin sets); the localised label follows <html lang>.
hljs.addPlugin(new CopyButtonPlugin({ autohide: true }));

hljs.highlightAll();
hljs.initLineNumbersOnLoad();
