<template>
  <v-card outlined tile style="border-top: 2px solid #ef5350;">
    <v-card-title style="background-color: #FFFCFC;" v-text="title" />
    <v-divider />
    <slot />
  </v-card>
</template>

<script>
export default {
  name: 'BaseTitleCard',
  props: {
    title: {
      type: String,
      default: ''
    }
  }
}
</script>
