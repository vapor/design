import hljs from 'highlight.js/lib/core';
import type { HLJSApi, LanguageFn } from 'highlight.js';

import armasm from 'highlight.js/lib/languages/armasm';
import awk from 'highlight.js/lib/languages/awk';
import bash from 'highlight.js/lib/languages/bash';
import c from 'highlight.js/lib/languages/c';
import cmake from 'highlight.js/lib/languages/cmake';
import cpp from 'highlight.js/lib/languages/cpp';
import css from 'highlight.js/lib/languages/css';
import diff from 'highlight.js/lib/languages/diff';
import dockerfile from 'highlight.js/lib/languages/dockerfile';
import http from 'highlight.js/lib/languages/http';
import javascript from 'highlight.js/lib/languages/javascript';
import json from 'highlight.js/lib/languages/json';
import leaf from 'highlight.js/lib/languages/leaf';
import less from 'highlight.js/lib/languages/less';
import llvm from 'highlight.js/lib/languages/llvm';
import makefile from 'highlight.js/lib/languages/makefile';
import markdown from 'highlight.js/lib/languages/markdown';
import pgsql from 'highlight.js/lib/languages/pgsql';
import plaintext from 'highlight.js/lib/languages/plaintext';
import protobuf from 'highlight.js/lib/languages/protobuf';
import rust from 'highlight.js/lib/languages/rust';
import scss from 'highlight.js/lib/languages/scss';
import shell from 'highlight.js/lib/languages/shell';
import sql from 'highlight.js/lib/languages/sql';
import swift from 'highlight.js/lib/languages/swift';
import typescript from 'highlight.js/lib/languages/typescript';
import wasm from 'highlight.js/lib/languages/wasm';
import xml from 'highlight.js/lib/languages/xml';
import yaml from 'highlight.js/lib/languages/yaml';

const LANGUAGES = {
    armasm, awk, bash, c, cmake, cpp, css, diff, dockerfile, http, javascript,
    json, leaf, less, llvm, makefile, markdown, pgsql, plaintext, protobuf,
    rust, scss, shell, sql, swift, typescript, wasm, xml, yaml,
} satisfies Record<string, LanguageFn>;

for (const [name, language] of Object.entries(LANGUAGES)) {
    hljs.registerLanguage(name, language);
}

// Required for the line-numbers plugin
window.hljs = hljs;

export interface HLJSWithLineNumbers extends HLJSApi {
    initLineNumbersOnLoad(options?: { singleLine?: boolean }): void;
    lineNumbersBlock(element: HTMLElement, options?: { singleLine?: boolean }): void;
    lineNumbersValue(value: string, options?: { singleLine?: boolean }): string;
}

export default hljs as HLJSWithLineNumbers;
