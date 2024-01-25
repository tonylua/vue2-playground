import HelloRemote from "./components/HelloRemote.vue";

const install = function (Vue) {
  if (install.installed) return;
  Vue.component(HelloRemote.name, HelloRemote);
  if (typeof window !== "undefined" && window.Vue) install(window.Vue);
};

HelloRemote.install = install;
export default HelloRemote;
