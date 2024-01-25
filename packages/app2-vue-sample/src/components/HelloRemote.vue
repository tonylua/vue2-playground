<template>
  <div class="hello">
    <h2>{{ time1 }}</h2>
    <p>{{ msg }}</p>
    <input type="text" v-model="msg" />
  </div>
</template>

<script>
export default {
  name: "HelloRemote",
  props: {},
  data() {
    return {
      msg: "hello remote",
      time1: "",
    };
  },
  created() {
    const now = new Date();
    this.time1 = now.toLocaleString();
  },
};
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
p {
  color: #42b983;
}
</style>
