const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    // Order is important here
    main: { import: './src/js/main.ts', library: { name: 'Vapor', type: 'var' } },
    docs: { import: ['./src/scss/docs.scss', './src/js/docs.ts'] },
    'theme-init': { import: './src/js/themeInit.ts', filename: 'js/theme-init.js' },
    'search-init': { import: './src/js/searchInit.ts', filename: 'js/search-init.js' },
  },

  plugins: [
    // Copy static assets to the output directory
    new CopyWebpackPlugin({
      patterns: [{ from: 'static' }]
    }),
    new MiniCssExtractPlugin({
      filename: '[name].css'
    }),
  ],

  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'Content'),
    clean: { keep: /index\.md/ },
  },

  performance: { hints: false },

  resolve: {
    extensions: ['.ts', '.js'],
    extensionAlias: {
      '.js': ['.ts', '.js'],
    },
  },

  devServer: {
    static: path.resolve(__dirname, 'Content'),
    port: 8001,
    hot: true,
    // Add CORS so we can test the sites with this running locally
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Cross-Origin-Resource-Policy': 'cross-origin',
    },
  },

  module: {
    rules: [
      // TypeScript handling
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
              // Root-absolute url()s (e.g. /assets/heading-link.svg) are assets copied over so don't need
              // a URL rewrite
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
                // Shut bootstrap up
                quietDeps: true,
                silenceDeprecations: ['import'],
              },
            },
          }
        ]
      }
    ]
  }
}
