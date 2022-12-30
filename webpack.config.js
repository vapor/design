const miniCssExtractPlugin = require('mini-css-extract-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path')

module.exports = {
  mode: 'production',
  entry: './src/js/main.js',
  plugins: [
    new miniCssExtractPlugin(),
    new CopyWebpackPlugin({
      patterns: [
          { from: 'static' }
      ]
    })
  ],
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  },
  devServer: {
    static: path.resolve(__dirname, 'dist'),
    port: 8080,
    hot: true
  },
  module: {
    rules: [
      {
        mimetype: 'image/svg+xml',
        scheme: 'data',
        type: 'asset/resource',
        generator: {
          filename: 'icons/[hash].svg'
        }
      },
      {
        test: /\.(scss)$/,
        use: [
          {
            loader: miniCssExtractPlugin.loader
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: () => [
                  require('autoprefixer')
                ]
              }
            }
          },
          {
            loader: 'sass-loader'
          }
        ]
      }
    ]
  }
}
