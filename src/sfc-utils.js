import Vue from "vue/dist/vue.common";
import {
  loadModule,
  createSFCModule,
} from "vue3-sfc-loader/dist/vue2-sfc-loader";

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
