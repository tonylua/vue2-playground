const path = require("path");
const glob = require("glob");

module.exports = {
  devServer: {
    open: true,
    port: 8080,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
    before(app) {
      const module_path = path.resolve(
        __dirname,
        "./node_modules/systemjs/dist/"
      );
      // 引入目标目录中的所有文件
      glob.sync(path.resolve(module_path, "**/*.js")).forEach((file) => {
        const url = "/@systemjs/" + path.relative(module_path, file);
        app.get(url, function (req, res) {
          res.sendFile(file);
        });
      });
    },
  },
  configureWebpack: {
    resolve: {
      alias: {
        "@sample": path.resolve(__dirname, "./public/vue-sample"),
        "@systemjs": path.resolve(__dirname, "./node_modules/systemjs/dist"),
      },
    },
  },
};
