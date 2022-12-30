import './highlight.min.js'

const hljs = require('./highlight.min.js');

window.hljs = hljs;

require('./highlightjs-line-numbers.min.js');

hljs.highlightAll();
hljs.initLineNumbersOnLoad();