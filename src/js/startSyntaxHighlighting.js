import './highlight.min.js'

const hljs = require('./highlight.min.js');
const CopyButtonPlugin = require('highlightjs-copy');

window.hljs = hljs;

require('./highlightjs-line-numbers.min.js');

// Copy-to-clipboard button on every code block (styled in syntax.scss).
// The plugin captures each block's source at highlight time, so the copy
// excludes the line-number gutter. autohide:true reveals the button only while
// the code block is hovered (styled in syntax.scss off the data-autohide
// attribute the plugin sets); the localised label follows <html lang>.
hljs.addPlugin(new CopyButtonPlugin({ autohide: true }));

hljs.highlightAll();
hljs.initLineNumbersOnLoad();