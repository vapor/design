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
    publicPath: process.env.PR_NAME ? `/${process.env.PR_NAME}/` : '',
    library: {
      name: 'Vapor',
      type: 'var',
    },
  },

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
            options: { sourceMap: true },
          }
        ]
      }
    ]
  }
}
