<template>
  <div id="app">
    <button @click="readRemoteSfc">read sfc</button>
    <button @click="loadRemoteComp">systemjs load</button>
    <div class="code-box">
      <codemirror
        v-model="code"
        :options="cmOptions"
        :mode="isSFCSource ? 'text/x-vue' : 'text/javascript'"
        @ready="onCmReady"
        @input="onCmChange"
      />
      <component :is="remote" v-if="remote" v-bind="$attrs" v-on="$listeners" />
    </div>
  </div>
</template>

<script>
import Vue from "vue/dist/vue.common";
import { sfc2Component, loadSfc, loadComponent, loadJS } from "./sfc-utils";

export default {
  name: "App",
  components: {},
  data() {
    return {
      remote: null,
      // TODO
      code: ``,
      isSFCSource: true,
      cmOptions: {},
    };
  },
  methods: {
    onCmReady(cm) {
      cm.setSize(600, 360);
    },
    async onCmChange(v) {
      let comp = null;
      if (this.isSFCSource) {
        comp = await sfc2Component(v);
        console.log("sfc to component");
        this.remote = comp;
        return;
      }
      const dataUrl = `data:text/javascript;charset=utf-8;base64,${btoa(v)}`;
      const [_, c] = await loadComponent(dataUrl);
      comp = c;
      this.remote = comp.default;
    },
    async readRemoteSfc() {
      this.code = "";
      this.isSFCSource = false;
      const [code, comp] = await loadSfc(
        "/vue-sample/src/components/HelloRemote.vue"
      );
      console.log(comp, "remote sfc loaded");
      this.isSFCSource = true;
      this.code = code;
      // this.remote = comp;
    },
    async loadRemoteComp() {
      this.code = "";
      this.isSFCSource = false;
      const [code, comp] = await loadComponent(
        "http://localhost:8080/vue-sample/dist/comp.umd.min.js"
      );
      console.log(comp, "systemjs component loaded");
      this.code = code;
      // this.remote = comp.default;
    },
  },
  mounted() {},
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
  margin-top: 20px;
}
.code-box {
  margin-top: 20px;
  display: flex;
  flex-direction: row;
  gap: 20px;
}
button + button {
  margin-left: 10px;
}
</style>
