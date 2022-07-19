<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'

dayjs.locale(ja)

const props = defineProps({
  searchConditions: {
    type: Object,
    required: false,
    default: null,
  },
})

const searchResult = reactive({
  profiles: [],
})
const { profiles } = toRefs(searchResult)

axios
  .get('/api/search', {
    params: {
      model: props.searchConditions.model,
      category: props.searchConditions.category,
      word1: props.searchConditions.word1,
      word2: props.searchConditions.word2,
      word3: props.searchConditions.word3,
      word4: props.searchConditions.word4,
      sort: props.searchConditions.sort,
    },
  })
  .then((response) => {
    console.log('検索条件に合致したプロフィールの取得成功')
    console.log({ response })
    searchResult.profiles = response.data
  })
  .catch((error) => {
    console.log('検索条件に合致したプロフィールの取得失敗')
    console.log({ error })
  })

const router = useRouter()

const showProfileDetail = (user_id) => {
  console.log('プロフィール詳細ページに移動')
  router.push(`/users/${user_id}`)
}

const back = () => {
  router.back()
}
</script>

<template>
  <div
    v-if="!(profiles.length == 0)"
    class="m-8 lg:m-12 rounded"
  >
    <h2 class="text-sm md:text-lg lg:text-2xl">
      検索結果<span class="ml-4 lg:ml-6 text-2xl lg:text-4xl">{{ profiles.length }}件</span>
    </h2>
    <ul>
      <li
        v-for="data in profiles"
        :key="data.id"
        class="mb-4 p-4 lg:mb-8 lg:p-8 rounded border border-teal-500/80 dark:bg-teal-800 dark:border-none"
      >
        <div class="flex justify-center items-center space-x-4 md:space-x-8 lg:space-x-12">
          <div v-if="!data.image_path">
            <img
              src="../../public/no_image.png"
              class="object-cover w-24 h-24 md:w-48 md:h-48 lg:w-72 lg:h-72 m-auto rounded-full"
            >
          </div>
          <div v-else>
            <img
              :src="data.image_path"
              class="object-cover w-24 h-24 md:w-48 md:h-48 lg:w-72 lg:h-72 m-auto rounded-full"
            >
          </div>
          <div>
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
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              フォロワー数<span
                class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
              >{{ data.follower_number }}</span>
            </p>
          </div>
        </div>
        <div class="mt-2 flex space-x-2 md:space-x-8 justify-center">
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            作成日<span class="ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-base lg:text-xl">{{
              dayjs(data.created_at).format('YYYY年M月D日(ddd) HH:mm')
            }}</span>
          </p>
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            更新日<span class="ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-base lg:text-xl">{{
              dayjs(data.updated_at).format('YYYY年M月D日(ddd) HH:mm')
            }}</span>
          </p>
        </div>
        <p class="mt-6 lg:mt-10 text-center">
          <button
            class="w-full max-w-xs text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
            @click="showProfileDetail(data.user_id)"
          >
            詳細
          </button>
        </p>
      </li>
    </ul>
  </div>
  <div
    v-if="profiles.length == 0"
    class="m-8"
  >
    <h2 class="text-sm md:text-lg">
      検索結果
    </h2>
    <p class="text-lg text-center rounded py-4 bg-teal-50/20">
      検索条件に合致するデータはありません
    </p>
    <div class="text-center mt-6">
      <button
        class="text-emerald-50 dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300 font-bold uppercase text-xs md:text-sm px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-noneease-linear transition-all duration-150"
        @click="back"
      >
        戻る
      </button>
    </div>
  </div>
</template>
