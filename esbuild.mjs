#!/usr/bin/env node

import esbuild from 'esbuild'
import { sassPlugin } from 'esbuild-sass-plugin'

try {
  await esbuild.build({
    entryPoints: ['src/js/main.js', 'src/scss/main.scss'],
    outdir: 'Example',
    bundle: true,
    sourcemap: true,
    minify: true,
    watch: process.argv.includes('--watch'),
    plugins: [sassPlugin()],
    external: ['/src/fonts/*', '/src/images/*', '/src/index.html'],
  })
} catch {
  process.exit(1)
}
