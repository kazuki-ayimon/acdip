<template>
  <v-btn
    color="green darken-3"
    class="btn white--text"
    depressed
    :disabled="disabled"
    :large="large"
    :to="to"
    @click="onClick"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  name: 'GreenBtn',
  props: {
    disabled: {
      type: Boolean,
      default: false
    },
    large: {
      type: Boolean,
      default: false
    },
    to: {
      type: [String, Object],
      default: undefined
    }
  },
  methods: {
    onClick () {
      return this.$emit('click')
    }
  }
}
</script>

<style lang="scss" scoped>
.btn {
  color: white;
}
</style>
