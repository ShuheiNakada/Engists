<script setup>
import { Icon } from '@iconify/vue'
</script>

<template>
  <footer class="flex justify-between bg-teal-100/80 dark:bg-teal-900/90 h-8 md:h-10 lg:h-12">
    <div class="flex space-x-1 ml-4 my-auto py-2">
      <p class="my-auto dark:text-teal-50/70">
        <Icon
          icon="icon-park-outline:handle-c"
          width="12"
          height="12"
        />
      </p>
      <p class="text-xs lg:text-sm my-auto dark:text-teal-50/70">
        2022
      </p>
      <p class="text-sm lg:text-base my-auto dark:text-teal-50/70">
        Engists
      </p>
    </div>
    <div class="flex space-x-2 mr-4 my-auto">
      <a
        href="https://twitter.com/ShuheiNakada"
        class="cursor-pointer hover:text-teal-500"
      >
        <Icon
          icon="akar-icons:twitter-fill"
          width="24"
          height="24"
        />
      </a>
      <a
        href="https://github.com/ShuheiNakada/second_app"
        class="cursor-pointer hover:text-teal-500"
      >
        <Icon
          icon="akar-icons:github-fill"
          width="24"
          height="24"
        />
      </a>
      <a
        href="https://qiita.com/Shuhei_Nakada"
        class="cursor-pointer hover:text-teal-500"
      >
        <Icon
          icon="simple-icons:qiita"
          width="24"
          height="24"
        />
      </a>
      <a
        href="https://www.wantedly.com/id/shuhei_nakada_xxx"
        class="cursor-pointer hover:text-teal-500"
      >
        <img
          src="../assets/Wantedly_Mark_DarkBG.png"
          alt="wontedlyロゴ"
          width="24"
          height="24"
        >
      </a>
    </div>
  </footer>
</template>
