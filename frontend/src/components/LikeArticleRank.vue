<script setup>
import axios from 'axios'
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'

dayjs.locale(ja)

const article = reactive({
  datas: [],
})

axios
  .get('api/like_article_rank')
  .then((response) => {
    console.log('いいね数が多い順で全記事データを取得する')
    console.log({ response })
    article.datas = response.data
  })
  .catch((error) => {
    console.log('いいね数が多い順で全記事データの取得失敗')
    console.log({ error })
  })

const router = useRouter()
const articleDetail = (article_id) => {
  router.push(`/articles/${article_id}`)
}
</script>

<template>
  <div
    class="p-8 ml-8 my-8 lg:p-12 lg:ml-12 lg:my-12 rounded-l-lg dark:bg-teal-800 border-y border-l border-teal-500/80 dark:border-none"
  >
    <h2 class="font-bold text-lg lg:text-2xl">
      人気ランキング(投稿記事)
    </h2>
    <ul class="flex overflow-x-auto">
      <li
        v-for="(articleData, index) in article.datas"
        :key="articleData.id"
        class="flex-none mx-4 w-60 md:w-72 lg:w-96 mb-4 lg:mb-6"
      >
        <div class="p-4 lg:p-8 rounded dark:bg-teal-700 bg-teal-100 h-full">
          <p
            class="rounded-full w-6 h-6 lg:w-12 lg:h-12 text-center lg:text-xl lg:pt-2 ring-offset-2 dark:ring-offset-teal-100 ring-4 dark:ring-teal-500 ring-emerald-400"
          >
            {{ index + 1 }}
          </p>
          <div class="text-center">
            <p class="mt-1 lg:mt-4 text-lg lg:text-xl truncate ...">
              {{ articleData.title }}
            </p>
            <div v-if="!articleData.image.url">
              <img
                src="../../public/no_image.png"
                class="object-contain h-36 md:h-48 lg:h-60 m-auto"
              >
            </div>
            <div v-else>
              <img
                :src="articleData.image.url"
                class="object-contain h-36 md:h-48 lg:h-60 m-auto"
              >
            </div>
            <p class="text-sm lg:text-lg font-hairline mt-1">
              いいね数:
              <span class="font-bold text-lg lg:text-2xl">{{ articleData.like_number }}</span>
            </p>
          </div>
          <div class="mt-6 lg:mt-10 flex justify-around text-center">
            <div>
              <p class="text-sm lg:text-lg">
                {{ dayjs(articleData.created_at).format('YYYY/M/D') }}
              </p>
              <p class="text-xs lg:text-lg mt-2 font-hairline">
                投稿日
              </p>
            </div>
            <div>
              <p class="text-sm lg:text-lg">
                {{ dayjs(articleData.updated_at).format('YYYY/M/D') }}
              </p>
              <p class="text-xs lg:text-lg mt-2 font-hairline">
                更新日
              </p>
            </div>
          </div>
          <div class="mt-6 lg:mt-10">
            <button
              class="px-4 py-2 md:mt-4 lg:text-lg text-white rounded w-full items-center shadow-md bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
              @click="articleDetail(articleData.id)"
            >
              詳細ページ
            </button>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>
