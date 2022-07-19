<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import _ from 'lodash'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'
import { Icon } from '@iconify/vue'

dayjs.locale(ja)

const followUser = reactive({
  datas: [],
})
const { datas } = toRefs(followUser)

const router = useRouter()
const route = useRoute()

axios
  .get(`/api/users/${route.params.id}/following`)
  .then((response) => {
    console.log('フォローリストの取得に成功')
    console.log({ response })
    const updateDateSortedItems = _.sortBy(response.data, (item) => item.follow_date).reverse()
    followUser.datas = updateDateSortedItems
  })
  .catch((error) => {
    console.log('フォローリストの取得に失敗')
    console.log({ error })
  })

const userDetail = (user_id) => {
  router.push(`/users/${user_id}`)
  console.log('ユーザー詳細へ移動')
}
</script>

<template>
  <div class="m-8 lg:m-12 rounded">
    <h2 class="text-sm md:text-lg lg:text-2xl">
      フォローしたユーザー<span class="ml-2 md:ml-4 lg:ml-6 text-lg md:text-2xl lg:text-4xl">{{ datas.length }}件</span>
    </h2>
    <ul>
      <li
        v-for="(data, index) in datas"
        :key="data.id"
        class="mb-4 p-4 lg:mb-8 lg:p-8 rounded border border-teal-500/80 dark:bg-teal-800 dark:border-none"
      >
        <p
          class="mb-2 md:mb-4 lg:mb-8 rounded-full w-6 h-6 lg:w-12 lg:h-12 text-center lg:text-xl lg:pt-2 ring-offset-2 dark:ring-offset-teal-100 ring-4 dark:ring-teal-500 ring-emerald-400"
        >
          {{ index + 1 }}
        </p>
        <div class="flex justify-center space-x-4 md:space-x-20 lg:space-x-32">
          <div class="my-auto">
            <p v-if="!data.icon_path">
              <Icon
                icon="bxs:user"
                class="object-cover w-16 h-16 md:w-36 md:h-36 lg:w-48 lg:h-48 m-auto rounded-full"
              />
            </p>
            <p v-else>
              <img
                :src="data.icon_path"
                class="object-cover w-16 h-16 md:w-36 md:h-36 lg:w-48 lg:h-48 m-auto rounded-full"
              >
            </p>
          </div>
          <div>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              フォローした日<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ dayjs(data.follow_date).format('YYYY年M月D日') }}
              </span>
            </p>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              ユーザー名<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.name }}</span>
            </p>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              ステータス<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.status }}</span>
            </p>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              年齢(学習開始時)<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.starting_age }}</span>
            </p>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              性別<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.gender }}</span>
            </p>
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              居住地<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.residence }}</span>
            </p>
          </div>
        </div>
        <p class="text-center">
          <button
            class="w-full max-w-xs mt-4 lg:mt-8 text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
            @click="userDetail(data.id)"
          >
            詳細
          </button>
        </p>
      </li>
    </ul>
  </div>
</template>
