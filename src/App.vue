<template>
  <div id="app">
    <button @click="loadRemoteSfc">load remote sfc</button>
    <div class="code-box">
      <codemirror
        v-model="code"
        :options="cmOptions"
        @ready="onCmReady"
        @input="onCmChange"
      />
      <component :is="remote" v-if="remote" v-bind="$attrs" v-on="$listeners" />
    </div>
  </div>
</template>

<script>
import { sfc2Component, loadSfc } from "./sfc-utils";

export default {
  name: "App",
  components: {},
  data() {
    return {
      remote: null,
      // TODO
      code: ``,
      cmOptions: {},
    };
  },
  methods: {
    onCmReady(cm) {
      cm.setSize(600, 360);
    },
    async onCmChange(v) {
      const comp = await sfc2Component(v);
      this.remote = comp;
      console.log("sfc to component");
    },
    async loadRemoteSfc() {
      const [code, comp] = await loadSfc(
        "vue-sample/src/components/HelloRemote.vue"
      );
      console.log(comp, "remote sfc loaded");
      this.code = code;
      // this.remote = comp;
    },
  },
  async mounted() {},
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
</style>
