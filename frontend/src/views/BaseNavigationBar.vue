<script setup>
import { Icon } from '@iconify/vue'
import { useStore } from 'vuex'
import { computed, reactive } from 'vue'

const toggleDarkMode = () => {
  if (document.documentElement.classList.contains('dark')) {
    document.documentElement.classList.remove('dark')
    localStorage.theme = 'light'
  } else {
    document.documentElement.classList.add('dark')
    localStorage.theme = 'dark'
  }
}

const store = useStore()

const unreadNotifications = computed(() => {
  console.log('Vuexストアから通知情報を取得する')
  return store.getters['notification/unread']
})
const userInfo = computed(() => {
  console.log('Vuexストアから認証情報を取得する')
  return store.getters['auth/userInfo']
})

const iconSize = reactive({
  width: '24',
  height: '24',
})
if (window.innerWidth >= 768) {
  iconSize.width = '24'
  iconSize.height = '24'
}
if (window.innerWidth >= 1024) {
  iconSize.width = '36'
  iconSize.height = '36'
}
</script>

<template>
  <nav
    v-if="userInfo.login"
    class="flex justify-between border-y bg-teal-100/80 border-teal-500 dark:bg-teal-900/90 dark:border-teal-800"
  >
    <div
      class="flex justify-start content-center py-1 lg:py-2 cursor-pointer divide-x divide-teal-600 dark:divide-teal-700"
    >
      <router-link
        class="px-2 lg:px-4 flex flex-col items-center"
        to="/home"
      >
        <Icon
          :width="iconSize.width"
          :height="iconSize.height"
          icon="ant-design:home-outlined"
        /><span class="text-xs md:text-base lg:text-lg">Home</span>
      </router-link>
      <router-link
        class="px-2 lg:px-4 flex flex-col items-center"
        to="/post"
      >
        <Icon
          :width="iconSize.width"
          :height="iconSize.height"
          icon="jam:write"
        /><span
          class="text-xs md:text-base lg:text-lg"
        >Post</span>
      </router-link>
      <router-link
        class="px-2 lg:px-4 flex flex-col items-center"
        to="/search"
      >
        <Icon
          :width="iconSize.width"
          :height="iconSize.height"
          icon="bx:search-alt"
        /><span
          class="text-xs md:text-base lg:text-lg"
        >Search</span>
      </router-link>
      <router-link
        class="px-2 lg:px-4 flex flex-col items-center"
        to="/rooms/index"
      >
        <Icon
          :width="iconSize.width"
          :height="iconSize.height"
          icon="bx:paper-plane"
        /><span
          class="text-xs md:text-base lg:text-lg"
        >DM</span>
      </router-link>
      <div v-if="!(unreadNotifications.length === 0)">
        <router-link
          class="px-2 lg:px-4 flex flex-col items-center dark:text-orange-300 text-orange-600"
          to="/notifications"
        >
          <Icon
            :width="iconSize.width"
            :height="iconSize.height"
            icon="codicon:bell-dot"
          /><span
            class="text-xs md:text-base lg:text-lg"
          >Notice({{ unreadNotifications.length }})</span>
        </router-link>
      </div>
      <div v-else-if="unreadNotifications.length === 0">
        <router-link
          class="px-2 lg:px-4 flex flex-col items-center"
          to="/notifications"
        >
          <Icon
            :width="iconSize.width"
            :height="iconSize.height"
            icon="akar-icons:bell"
          /><span
            class="text-xs md:text-base lg:text-lg"
          >Notice</span>
        </router-link>
      </div>
    </div>
    <button
      class="pr-4 py-1 lg:pr-8 lg:py-2 flex flex-col items-center"
      @click="toggleDarkMode"
    >
      <Icon
        :width="iconSize.width"
        :height="iconSize.height"
        icon="akar-icons:light-bulb"
      /><span
        class="text-xs md:text-base lg:text-lg"
      >dark / light</span>
    </button>
  </nav>
</template>
