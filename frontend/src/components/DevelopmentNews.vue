<script setup>
import { Icon } from '@iconify/vue'
</script>

<template>
  <p
    class="flex items-center space-x-1 justify-center mx-32 md:mx-48 lg:mx-64 py-2 md:py-4 rounded-full text-sm md:text-lg lg:text-2xl dark:bg-teal-800/90 bg-teal-100"
  >
    <Icon icon="bxs:help-circle" />
    <a
      href="https://github.com/ShuheiNakada/second_app/blob/master/README.md#操作方法"
      target="_blank"
      class="underline cursor-pointer hover:text-emerald-500 active:text-emerald-600"
    >
      操作方法
    </a>
  </p>
</template>
