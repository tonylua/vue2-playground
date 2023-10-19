<template>
  <div id="app">
    <codemirror v-model="code" :options="cmOptions" @ready="onCmReady" />
    <component :is="remote" v-if="remote" v-bind="$attrs" v-on="$listeners" />
  </div>
</template>

<script>
import Vue from "vue/dist/vue.common";
import dayjs from "dayjs";
import { loadModule } from "vue3-sfc-loader/dist/vue2-sfc-loader";

export default {
  name: "App",
  components: {},
  data() {
    return {
      remote: null,
      // TODO
      code: `<template functional>
  <div class="sample">
    hello excel!
  </div>
</template>

<style>
  .sample {
    color: red;
  }
</style>
      `,
      cmOptions: {},
    };
  },
  methods: {
    onCmReady(cm) {
      cm.setSize(600, 360);
    },
  },
  mounted() {
    loadModule("/vue-sample/src/components/HelloWorld.vue", {
      moduleCache: {
        vue: Vue,
        dayjs,
      },
      async getFile(url) {
        const res = await fetch(url);
        if (!res.ok) {
          throw Object.assign(new Error(`${res.statusText}  ${url}`), { res });
        }
        return {
          getContentData: (asBinary) =>
            asBinary ? res.arrayBuffer() : res.text(),
        };
      },
      addStyle(textContent) {
        const style = Object.assign(document.createElement("style"), {
          textContent,
        });
        const ref = document.head.getElementsByTagName("style")[0] || null;
        document.head.insertBefore(style, ref);
      },
    }).then((comp) => {
      console.log(comp, "remote sfc loaded");
      this.remote = comp;
    });
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
  margin-top: 60px;
  display: flex;
  flex-direction: row;
  gap: 20px;
}
</style>
