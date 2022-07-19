<script setup>
import { useStore } from 'vuex'

const store = useStore()
store.dispatch('auth/getDatas')
store.dispatch('notification/getDatas')
</script>

<template>
  <div class="hidden">
    ...
  </div>
</template>
