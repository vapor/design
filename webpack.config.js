const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
  mode: 'production',
  entry: './src/js/main.js',

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

  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'Output'),
    library: {
      name: 'Vapor',
      type: 'var',
    },
  },

  // The bundle intentionally ships all of Bootstrap + highlight.js and is loaded
  // once from the CDN by every site, so webpack's generic 244 KiB asset-size hint
  // doesn't apply here.
  performance: { hints: false },

  devServer: {
    static: path.resolve(__dirname, 'Output'),
    port: 8001,
    hot: true
  },

  module: {
    rules: [
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
            options: { sourceMap: true },
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
