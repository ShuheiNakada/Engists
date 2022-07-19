<script setup>
import axios from 'axios'
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import dayjs from 'dayjs'

const user = reactive({
  datas: [],
})

axios
  .get('api/follow_user_rank')
  .then((response) => {
    console.log('フォロワー数が多い順で全ユーザーデータを取得する')
    console.log({ response })
    user.datas = response.data

    for (let i = 0; i < response.data.length; i++) {
      const today = dayjs()
      const birthday = dayjs(user.datas[i].birth)
      user.datas[i].age = today.diff(birthday, 'year')
    }
  })
  .catch((error) => {
    console.log('フォロワー数が多い順で全ユーザーデータの取得失敗')
    console.log({ error })
  })

const router = useRouter()
const userDetail = (user_id) => {
  router.push(`/users/${user_id}`)
}
</script>

<template>
  <div
    class="p-8 ml-8 my-8 lg:p-12 lg:ml-12 lg:my-12 rounded-l-lg dark:bg-teal-800 border-y border-l border-teal-500/80 dark:border-none"
  >
    <h2 class="font-bold text-lg lg:text-2xl">
      人気ランキング(ユーザー)
    </h2>
    <ul class="flex overflow-x-auto">
      <li
        v-for="(userData, index) in user.datas"
        :key="userData.id"
        class="flex-none mx-4 w-60 md:w-72 lg:w-96 mb-4 lg:mb-6"
      >
        <div class="p-4 lg:p-8 rounded dark:bg-teal-700 bg-teal-100 h-full">
          <p
            class="rounded-full w-6 h-6 lg:w-12 lg:h-12 text-center lg:text-xl lg:pt-2 ring-offset-2 dark:ring-offset-teal-100 ring-4 dark:ring-teal-500 ring-emerald-400"
          >
            {{ index + 1 }}
          </p>
          <div v-if="!userData.image.url">
            <img
              src="../../public/no_image.png"
              class="object-cover w-36 h-36 md:w-48 md:h-48 lg:w-60 lg:h-60 m-auto rounded-full"
            >
          </div>
          <div v-else>
            <img
              :src="userData.image.url"
              class="object-cover w-36 h-36 md:w-48 md:h-48 lg:w-60 lg:h-60 m-auto rounded-full"
            >
          </div>
          <div class="text-center text-lg lg:text-2xl">
            <p class="mt-1">
              {{ userData.name }}
            </p>
            <p class="text-sm lg:text-lg font-hairline mt-1">
              フォロワー数: <span class="font-bold text-lg">{{ userData.follower_number }}</span>
            </p>
          </div>
          <div class="mt-6 flex justify-around text-center">
            <div>
              <p class="font-bold lg:text-xl lg:mt-4">
                {{ userData.age }}
              </p>
              <p class="text-xs lg:text-lg mt-2 font-hairline">
                年齢
              </p>
            </div>
            <div>
              <p class="font-bold lg:text-xl lg:mt-4">
                {{ userData.residence }}
              </p>
              <p class="text-xs lg:text-lg mt-2 font-hairline">
                地域
              </p>
            </div>
            <div>
              <p class="font-bold lg:text-xl lg:mt-4">
                {{ userData.gender }}
              </p>
              <p class="text-xs lg:text-lg mt-2 font-hairline">
                性別
              </p>
            </div>
          </div>
          <div class="mt-6">
            <button
              class="px-4 py-2 md:mt-4 lg:mt-6 lg:text-lg text-white rounded w-full items-center shadow-md bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
              @click="userDetail(userData.id)"
            >
              詳細ページ
            </button>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
