<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'

const responseDatas = reactive({
  entries: [],
})
const { entries } = toRefs(responseDatas)

const myself = reactive({
  email: window.localStorage.getItem('uid'),
})

axios
  .get('api/entries')
  .then((response) => {
    console.log('操作ユーザーのDMルームへのエントリー履歴を取得する')
    console.log({ response })
    responseDatas.entries = response.data
  })
  .catch((error) => {
    console.log('操作ユーザーのDMルームへのエントリー履歴の取得失敗')
    console.log({ error })
  })
</script>

<template>
  <div class="m-4 lg:m-8">
    <h2 class="font-bold text-lg md:text-3xl lg:text-4xl">
      DMルーム
    </h2>
    <p class="text-xs md:text-base lg:text-xl">
      (過去にやり取りしたDM送信先を表示しています)
    </p>
    <ul>
      <li
        v-for="entry in entries"
        :key="entry.id"
        class="dark:bg-teal-800 dark:border-none bg-teal-200/50 rounded"
      >
        <div
          v-if="myself.email !== entry.email"
          class="m-2 p-2 md:m-6 md:p-6 lg:m-10 lg:p-10 rounded"
        >
          <p class="mb-4 md:text-lg lg:text-3xl">
            <span
              class="text-xs md:text-base lg:text-lg lg:mr-4 dark:text-teal-100/80 text-teal-900/50 mr-2"
            >送信先</span>{{ entry.name }}
          </p>
          <div class="space-x-4 lg:space-x-12 pl-4 pb-4 lg:pl-8 lg:p-8">
            <router-link
              class="p-2 lg:p-4 text-xs md:text-base lg:text-xl text-teal-50 rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300 disabled:opacity-50"
              :to="`/users/${entry.user_id}`"
            >
              ユーザー詳細へ
            </router-link>
            <router-link
              class="p-2 lg:p-4 text-xs md:text-base lg:text-xl text-teal-50 rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300 disabled:opacity-50"
              :to="`/rooms/${entry.room_id}`"
            >
              DMルームへ
            </router-link>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
