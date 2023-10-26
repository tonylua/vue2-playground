import Vue from "vue/dist/vue.common";
import { loadModule } from "vue3-sfc-loader/dist/vue2-sfc-loader";

const _loadJS = (url, onload) => {
  const s = document.createElement("script");
  s.type = "text/javascript";
  s.src = url;
  s.defer = "defer";
  if (typeof onload === "function") s.onload = onload;
  document.head.appendChild(s);
};
_loadJS("/@systemjs/system.min.js");
_loadJS("/@systemjs/extras/amd.min.js");
_loadJS("/@systemjs/extras/global.min.js");
_loadJS("/@systemjs/extras/module-types.min.js");
_loadJS("/@systemjs/extras/named-register.min.js");
_loadJS("/@systemjs/extras/use-default.min.js");

// https://github.com/FranckFreiburger/vue3-sfc-loader/blob/main/docs/api/README.md#loadmodule
// https://stackoverflow.com/questions/73889234/vue3-how-to-parse-sfc-string-to-a-component
const baseConfig = {
  moduleCache: { vue: Vue },
  addStyle(textContent) {
    const style = Object.assign(document.createElement("style"), {
      textContent,
    });
    const ref = document.head.getElementsByTagName("style")[0] || null;
    document.head.insertBefore(style, ref);
  },
};

export const sfc2Component = (sfcString) => {
  const id = crypto.randomUUID();
  const options = {
    ...baseConfig,
    async getFile() {
      return Promise.resolve(sfcString);
    },
  };
  return loadModule(`${id}.vue`, options);
};

export const loadSfc = (url) =>
  Promise.all([
    fetch(url).then((res) => res.text()),
    loadModule(url, {
      ...baseConfig,
      async getFile(url) {
        const res = await fetch(url);
        if (!res.ok) {
          throw Object.assign(new Error(`${res.statusText}  ${url}`), {
            res,
          });
        }
        return {
          getContentData: (asBinary) =>
            asBinary ? res.arrayBuffer() : res.text(),
        };
      },
    }),
  ]);

export const loadComponent = (url) =>
  Promise.all([
    fetch(url).then((res) => res.text()),
    window.System.import(url),
  ]);

export const module2Component = async (moduleContent) => {
  const dataUrl = `data:text/javascript;charset=utf-8;base64,${btoa(
    moduleContent
  )}`;
  const [_, res] = await loadComponent(dataUrl);
  return res.default || res;
};
