<script setup>
import { Icon } from '@iconify/vue'
import axios from 'axios'
import { computed, reactive } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import removeItem from '../methods/removeItem'
import { useStore } from 'vuex'
import UserMenuDropdown from '../components/UserMenuDropdown.vue'

const router = useRouter()
const route = useRoute()
const store = useStore()

const logout = () => {
  axios
    .delete('/auth/sign_out')
    .then((response) => {
      console.log('ログアウト成功')
      console.log({ response })
      removeItem()
      store.dispatch('auth/deleteDatas')
      store.dispatch('notification/deleteDatas')
      console.log('Welcomeページにリダイレクト')
      router.push({ name: 'Welcome' })
      console.log(`移動元ページ: ${route.path}`)
    })
    .catch((error) => {
      console.log('ログアウト失敗')
      console.log({ error })
      alert('ログアウト失敗')
    })
}

const createProfile = () => {
  const userId = localStorage.getItem('user-id')
  router.push(`/users/${userId}`)
}

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
  <header class="flex justify-between bg-teal-100/80 dark:bg-teal-900/90 h-16 lg:h-24">
    <router-link
      to="/home"
      class="flex pl-4 lg:pl-8 my-auto"
    >
      <Icon
        icon="arcticons:wallpaperengine"
        :width="iconSize.width"
        :height="iconSize.height"
      />
      <span class="text-sm md:text-lg lg:text-2xl py-1 pl-1 md:p-0 md:pl-2 lg:pl-3">Engists</span>
    </router-link>
    <ul
      v-if="userInfo.login == true"
      class="flex justify-end md:space-x-2 lg:space-x-4 md:pr-4 lg:pr-8"
    >
      <li
        class="mr-1 p-1 cursor-pointer my-auto text-sm md:text-lg lg:text-2xl rounded bg-stone-900/30 hover:bg-stone-800/30 active:bg-stone-900/10"
        @click="logout"
      >
        Logout
      </li>
      <li class="flex flex-col items-center my-auto">
        <UserMenuDropdown />
        <button
          v-if="userInfo.profileExist == false"
          class="md:p-1 lg:p-2 text-xs lg:text-sm rounded whitespace-pre dark:bg-red-500 dark:hover:bg-red-600 dark:active:bg-red-700 dark:text-red-50 bg-red-500 hover:bg-red-400 active:bg-red-300 text-red-50"
          @click="createProfile"
        >
          プロフィール未登録
        </button>
      </li>
    </ul>
  </header>
</template>
