<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'

dayjs.locale(ja)

const articles = reactive({
  datas: [],
})
const { datas } = toRefs(articles)

axios
  .get('api/my_articles')
  .then((response) => {
    console.log('自分が投稿した記事の取得成功')
    console.log({ response })
    articles.datas = response.data
  })
  .catch((error) => {
    console.log('自分が投稿した記事を取得失敗')
    console.log({ error })
  })

const router = useRouter()

const articleDetail = (article_id) => {
  router.push(`/articles/${article_id}`)
}
</script>

<template>
  <p
    v-if="$route.query.successMessage"
    class="w-full text-lg lg:text-2xl text-center bg-teal-50/10 p-2 lg:p-4"
  >
    {{ $route.query.successMessage }}
  </p>
  <div class="m-8 lg:m-12 rounded">
    <h2 class="text-sm md:text-lg lg:text-2xl">
      投稿した記事<span class="ml-2 md:ml-4 lg:ml-6 text-lg md:text-2xl lg:text-4xl">{{ datas.length }}件</span>
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
        <div class="md:flex md:space-x-12 lg:space-x-20 md:justify-center md:items-center">
          <div
            class="w-full md:w-1/2 lg:w-1/3 mt-2 text-xs md:text-sm lg:text-lg dark:text-teal-50/80"
          >
            <p v-if="!data.image_path">
              <img
                src="../../public/no_image.png"
                class="max-h-40 md:max-h-60 lg:max-h-80 my-2 mx-auto"
              >
            </p>
            <p v-else>
              <img
                :src="data.image_path"
                class="max-h-40 md:max-h-60 lg:max-h-80 my-2 mx-auto"
              >
            </p>
          </div>
          <div class="md:w-1/2 lg:w-2/3">
            <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              <h3>タイトル</h3>
              <p class="truncate ... ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                {{ data.title }}
              </p>
            </div>
            <div class="mt-2 text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              <h3>タグ</h3>
              <p class="truncate ... ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                {{ data.tag_name }}
              </p>
            </div>
            <div class="mt-2 text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              <h3>記事内容(一部)</h3>
              <p class="truncate ... ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                {{ data.content }}
              </p>
            </div>

            <div class="flex space-x-12 mt-8">
              <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
                <h3>投稿日時</h3>
                <p class="ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                  {{ dayjs(data.created_at).format('YYYY年M月D日(ddd) HH:mm') }}
                </p>
              </div>
              <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
                <h3>更新日時</h3>
                <p class="ml-2 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                  {{ dayjs(data.updated_at).format('YYYY年M月D日(ddd) HH:mm') }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <p class="text-center">
          <button
            class="w-full max-w-xs mt-6 md:mt-12 lg:mt-24 text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:px-8 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
            @click="articleDetail(data.id)"
          >
            詳細
          </button>
        </p>
      </li>
    </ul>
  </div>
</template>
