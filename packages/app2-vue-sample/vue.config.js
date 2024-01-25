const path = require("path");
const CopyPlugin = require("copy-webpack-plugin");

module.exports = {
  productionSourceMap: false,
  css: {
    extract: false,
  },
  configureWebpack: {
    entry: {
      app: path.resolve(__dirname, "./src/index.js"),
    },
    optimization: {
      minimize: false,
    },
    plugins: [
      new CopyPlugin([
        {
          from: path.resolve(__dirname, "./src/components/HelloRemote.vue"),
          to: "./",
        },
      ]),
    ],
  },
};
