<template>
  <v-btn
    :id="id"
    color="#ef5350"
    class="btn"
    :disabled="disabled"
    :large="large"
    :block="block"
    :outlined="outlined"
    :to="to"
    depressed
    @click="onClick"
  >
    <slot />
  </v-btn>
</template>

<script>
export default {
  name: 'RedBtn',
  props: {
    id: {
      type: String,
      default: null
    },
    disabled: {
      type: Boolean,
      default: false
    },
    large: {
      type: Boolean,
      default: false
    },
    block: {
      type: Boolean,
      default: false
    },
    outlined: {
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
