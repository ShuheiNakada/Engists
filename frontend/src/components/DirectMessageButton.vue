<script setup>
import { Icon } from '@iconify/vue'
import axios from 'axios'
import { useRoute, useRouter } from 'vue-router'
import { reactive } from 'vue'

const route = useRoute()
const router = useRouter()

const directMessage = () => {
  axios
    .post(
      '/api/rooms',
      {},
      {
        params: {
          user_id: route.params.id,
        },
      },
    )
    .then((response) => {
      console.log('ダイレクトメッセージ用ルームの作成成功')
      console.log({ response })
      console.log('DMルームに移動する')
      router.push(`/rooms/${response.data.id}`)
    })
    .catch((error) => {
      console.log('ダイレクトメッセージ用ルームの作成失敗')
      console.log({ error })
    })
}

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
  <p class="ml-4 md:ml-6 lg:ml-8 flex flex-col items-center text-base">
    <button
      class="text-emerald-50 font-bold text-xs md:text-sm px-4 py-2 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
      @click="directMessage"
    >
      <Icon
        icon="entypo:paper-plane"
        :width="iconSize.width"
        :height="iconSize.height"
      />
    </button>
    <span class="text-xs md:text-sm lg:text-lg dark:font-thin text-center">DM</span>
  </p>
</template>
