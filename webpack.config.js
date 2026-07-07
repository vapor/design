const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    // The shared brand bundle (Bootstrap + highlight.js + brand CSS) → main.js/main.css.
    main: { import: './src/js/main.ts', library: { name: 'Vapor', type: 'var' } },
    // The docs-site bundle → docs.css (layout + DocC styles) and docs.js (the
    // docs-body interactions: mobile drawers, scroll-spy, search). Served to
    // docs/apiDocs sites only.
    docs: { import: ['./src/scss/docs.scss', './src/js/docs.ts'] },
    // Pre-paint colour-scheme script, loaded synchronously in <head> → js/theme-init.js.
    'theme-init': { import: './src/js/themeInit.ts', filename: 'js/theme-init.js' },
    // Kiln search bootstrap; must load before Kiln's search.js → js/search-init.js.
    'search-init': { import: './src/js/searchInit.ts', filename: 'js/search-init.js' },
  },

  plugins: [
    // Copy static assets to the output directory
    new CopyWebpackPlugin({
      patterns: [{ from: 'static' }]
    }),
    // Extract CSS into separate files
    new MiniCssExtractPlugin({
      filename: '[name].css'
    }),
  ],

  // Emit the CDN assets (main.css/js, fonts, icons) and the copied static/ files
  // into Kiln's content directory. Kiln then copies them verbatim into ./site on
  // build — so webpack never writes into ./site directly (which Kiln wipes each
  // build). The generated files under Content/ are git-ignored; only Content's
  // source pages (index.md) are tracked.
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'Content'),
    // Wipe stale output each build so removed entries/assets don't linger (e.g.
    // the old detectColorScheme.js). Keep Content/index.md — it's the only
    // tracked source in Content/ (the design guide's page), not a build artifact.
    clean: { keep: /index\.md/ },
  },

  // The bundle intentionally ships all of Bootstrap + highlight.js and is loaded
  // once from the CDN by every site, so webpack's generic 244 KiB asset-size hint
  // doesn't apply here.
  performance: { hints: false },

  // Resolve .ts before .js for extensionless imports, and let an explicit
  // './foo.js' specifier resolve to a './foo.ts' source (extensionAlias) — so
  // modules can keep their existing `import './x.js'` specifiers as we migrate
  // files from .js to .ts one at a time.
  resolve: {
    extensions: ['.ts', '.js'],
    extensionAlias: {
      '.js': ['.ts', '.js'],
    },
  },

  devServer: {
    static: path.resolve(__dirname, 'Content'),
    port: 8001,
    hot: true
  },

  module: {
    rules: [
      // TypeScript handling. tsconfig.json sets noEmit:true (so a bare `tsc` /
      // the editor only type-checks); override it here so ts-loader can emit
      // into the webpack pipeline.
      {
        test: /\.ts$/,
        loader: 'ts-loader',
        exclude: /node_modules/,
        options: { compilerOptions: { noEmit: false } },
      },
      // SVG handling
      {
        test: /\.svg$/,
        type: 'asset/resource',
        generator: {
          filename: 'icons/[hash].svg'
        }
      },
      // Font handling
      {
        test: /\.(woff|woff2)$/,
        type: 'asset/resource',
        generator: {
          filename: 'fonts/[hash][ext]'
        }
      },
      // SCSS and CSS handling
      {
        test: /\.(scss|css)$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: 'css-loader',
            options: {
              sourceMap: true,
              // Root-absolute url()s (e.g. /assets/heading-link.svg) are runtime
              // server paths served by the consuming site, not build-time assets,
              // so leave them untouched instead of trying to resolve a module.
              url: { filter: (url) => !url.startsWith('/') },
            },
          },
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: [require('autoprefixer')],
              },
              sourceMap: true,
            },
          },
          'resolve-url-loader',
          {
            loader: 'sass-loader',
            options: {
              sourceMap: true,
              sassOptions: {
                // Most build warnings come from Bootstrap's own SCSS (deprecated
                // global colour functions, @import) which isn't ours to change —
                // silence deprecations originating in dependencies.
                quietDeps: true,
                // Our SCSS still uses @import (that's how Bootstrap shares its
                // vars/mixins with the partials); silence the @import deprecation
                // until a proper @use/@forward migration.
                silenceDeprecations: ['import'],
              },
            },
          }
        ]
      }
    ]
  }
}
