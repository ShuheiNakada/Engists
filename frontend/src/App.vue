<script setup>
import BaseHeader from './views/BaseHeader.vue';
import BaseNavigationBar from './views/BaseNavigationBar.vue';
import BaseFooter from './views/BaseFooter.vue';
import { reactive } from 'vue';

const deviseWidth = reactive({
  small: '',
  large: ''
})

if(window.innerWidth < 768){
  deviseWidth.small = true
}else{
  deviseWidth.large = true
}
</script>

<template>
  <div class="fixed top-0 left-0 right-0">
    <BaseHeader />
    <div v-if="deviseWidth.large">
      <BaseNavigationBar />
    </div>
  </div>
  <div class="mt-16 md:mt-32 lg:mt-48 mb-24 md:mb-36 lg:mb-48 dark:bg-teal-900 bg-teal-50">
    <router-view />
  </div>
  <div class="fixed bottom-0 left-0 right-0">
    <div v-if="deviseWidth.small">
      <BaseNavigationBar />
    </div>
    <BaseFooter />
  </div>
</template>

<style>
</style>
