const { environment } = require('@rails/webpacker')
// const { VueLoaderPlugin } = require('vue-loader')
// const vue = require('./loaders/vue')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery/src/jquery',
  jQuery: 'jquery/src/jquery',
  Popper: ['popper.js', 'default'],
  Rails: '@rails/ujs'
}))
module.exports = environment
