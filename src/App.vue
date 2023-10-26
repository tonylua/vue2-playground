<template>
  <div id="app">
    <nav>
      <h1>
        <img
          src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxOTYuMzIgMTcwLjAyIj4KICA8cGF0aCBmaWxsPSIjNDJiODgzIiBkPSJNMTIwLjgzIDBMOTguMTYgMzkuMjYgNzUuNDkgMEgwbDk4LjE2IDE3MC4wMkwxOTYuMzIgMGgtNzUuNDl6Ii8+CiAgPHBhdGggZmlsbD0iIzM1NDk1ZSIgZD0iTTEyMC44MyAwTDk4LjE2IDM5LjI2IDc1LjQ5IDBIMzkuMjZsNTguOSAxMDIuMDFMMTU3LjA2IDBoLTM2LjIzeiIvPgo8L3N2Zz4K"
        />
        Vue 2 Component Playground
      </h1>
      <span class="path">{{ currentPath }}</span>
      <div class="buttons">
        <button @click="onShot" v-if="currentPath">📷 screenshot</button>
        <button class="save" @click="onSave" v-if="currentPath">💾 save</button>
        <button @click="readRemoteSfc">read sfc</button>
        <button @click="loadRemoteComp">systemjs load</button>
      </div>
    </nav>
    <div class="code-box">
      <div class="left">
        <codemirror
          v-model="code"
          :options="cmOptions"
          :mode="mode"
          @ready="onCmReady"
          @input="onCmChange"
        />
      </div>
      <div class="right">
        <component
          ref="comp"
          :is="remote"
          v-if="remote"
          v-bind="$attrs"
          v-on="$listeners"
        />
      </div>
    </div>
  </div>
</template>

<script>
import {
  sfc2Component,
  module2Component,
  loadSfc,
  loadComponent,
} from "./utils/sfc";
import { shot } from "./utils/canvas";

export default {
  name: "App",
  components: {},
  data() {
    return {
      remote: null,
      currentPath: "",
      code: ``,
      isSFCSource: true,
      cmOptions: {},
    };
  },
  computed: {
    mode() {
      return this.isSFCSource ? "text/x-vue" : "text/javascript";
    },
  },
  methods: {
    onCmReady(cm) {
      cm.setSize("100%", "100%");
    },
    async onCmChange(v) {
      this.remote = this.isSFCSource
        ? await sfc2Component(v)
        : await module2Component(v);
    },
    async readRemoteSfc() {
      this.code = "";
      this.isSFCSource = false;
      const sfcPath = prompt(
        "请输入SFC文件路径",
        "/vue-sample/src/components/HelloRemote.vue"
      );
      if (!sfcPath?.trim()) return;
      this.currentPath = sfcPath;
      const [code, comp] = await loadSfc(sfcPath);
      console.log(comp, "remote sfc loaded");
      this.isSFCSource = true;
      this.code = code;
      // this.remote = comp;
    },
    async loadRemoteComp() {
      this.code = "";
      this.isSFCSource = false;
      const modPath = prompt(
        "请输入模块文件路径",
        "/vue-sample/dist/comp.umd.min.js"
      );
      if (!modPath?.trim()) return;
      this.currentPath = modPath;
      const [code, comp] = await loadComponent(modPath);
      console.log(comp, "systemjs component loaded");
      this.code = code;
      // this.remote = comp.default;
    },
    onShot() {
      shot(this.$refs.comp.$el, "screenshot.png");
    },
    onSave() {
      let filename = this.currentPath.split("/");
      filename = filename[filename.length - 1];
      const a = document.createElement("a");
      a.href = window.URL.createObjectURL(
        new Blob([this.code], { type: this.mode })
      );
      a.download = filename;
      a.click();
    },
  },
  mounted() {},
};
</script>

<style scoped>
@import "./app.css";
</style>
