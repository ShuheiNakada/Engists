<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
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
  articles: [],
})
const { articles } = toRefs(searchResult)

const message = reactive({
  error: '',
})

axios
  .get('/api/search', {
    params: {
      model: props.searchConditions.model,
      category: props.searchConditions.category,
      word1: props.searchConditions.word1,
      sort: props.searchConditions.sort,
    },
  })
  .then((response) => {
    console.log('検索条件に合致した投稿記事の取得成功')
    console.log({ response })
    searchResult.articles = response.data
  })
  .catch((error) => {
    console.log('検索条件に合致した投稿記事の取得失敗')
    console.log({ error })
    message.error = error.response.data
  })

const router = useRouter()

const showArticleDetail = (article_id) => {
  console.log('プロフィール詳細ページに移動')
  router.push(`/articles/${article_id}`)
}

const back = () => {
  router.back()
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
  <div class="m-8 lg:m-12 rounded">
    <h2 class="text-sm md:text-lg lg:text-2xl">
      検索結果<span class="ml-4 lg:ml-6 text-lg md:text-2xl lg:text-4xl">{{ articles.length }}件</span>
    </h2>
    <div v-if="message.error">
      <p class="w-full text-center bg-teal-50/10 p-2 lg:p-4 lg:text-lg">
        {{ message.error }}
      </p>
      <p class="text-center">
        <button
          class="w-full max-w-xs mt-6 text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
          @click="back"
        >
          戻る
        </button>
      </p>
    </div>
    <div v-if="!(articles.length === 0)">
      <ul>
        <li
          v-for="data in articles"
          :key="data.id"
          class="mb-4 p-4 lg:mb-8 lg:p-8 rounded border border-teal-500/80 dark:bg-teal-800 dark:border-none"
        >
          <div class="flex flex-row-reverse mb-4 lg:mb-8 dark:text-teal-50/80">
            <router-link
              :to="`/users/${data.user_id}`"
              class="text-sm md:text-lg lg:text-2xl underline decoration-teal-500 dark:text-teal-50"
            >
              <p class="ml-1 py-1 md:py-0 lg:mr-4 hover:text-emerald-500">
                {{ data.user_name }}
              </p>
            </router-link>
            <Icon
              icon="bxs:user"
              :width="iconSize.width"
              :height="iconSize.height"
            />
          </div>
          <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            <h3>タイトル</h3>
            <p
              class="truncate ... ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >
              {{ data.title }}
            </p>
          </div>
          <div class="mt-2 lg:mt-6 text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            <h3>タグ</h3>
            <ul
              class="flex space-x-1 md:space-x-2 lg:space-x-4 flex-wrap ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >
              <li
                v-for="tag in data.tags"
                :key="tag.id"
                class="bg-teal-100/20 p-0.5 md:p-1 lg:p-2 rounded-lg mb-1"
              >
                {{ tag }}
              </li>
            </ul>
          </div>
          <div class="mt-2 lg:mt-6 text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            <h3>記事内容(一部)</h3>
            <p
              class="truncate ... ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >
              {{ data.content }}
            </p>
          </div>
          <div v-if="!data.image_path">
            <img
              src="../../public/no_image.png"
              class="object-contain w-24 h-24 md:w-48 md:h-48 lg:w-72 lg:h-72 m-auto"
            >
          </div>
          <div v-else>
            <img
              :src="data.image_path"
              class="object-contain w-48 h-48 md:w-72 md:h-72 lg:w-96 lg:h-96 m-auto mt-2 md:mt-4 lg:mt-6"
            >
          </div>
          <div
            class="flex justify-center items-center mt-2 lg:mt-6 text-xs md:text-sm lg:text-lg dark:text-teal-50/80"
          >
            <h3>いいね数</h3>
            <p
              class="truncate ... ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >
              {{ data.like_number }}
            </p>
          </div>
          <div class="flex space-x-12 lg:space-x-24 justify-center mt-6">
            <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              <h3>投稿日時</h3>
              <p class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                {{ dayjs(data.created_at).format('YYYY年M月D日(ddd) HH:mm') }}
              </p>
            </div>
            <div class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              <h3>更新日時</h3>
              <p class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">
                {{ dayjs(data.updated_at).format('YYYY年M月D日(ddd) HH:mm') }}
              </p>
            </div>
          </div>

          <p class="text-center">
            <button
              class="w-full max-w-xs mt-6 lg:mt-12 text-emerald-50 font-bold text-xs lg:text-lg md:text-sm px-4 py-2 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
              @click="showArticleDetail(data.id)"
            >
              詳細
            </button>
          </p>
        </li>
      </ul>
    </div>
    <div v-else-if="!(props.searchConditions.word1 == '') && articles.length == 0">
      <p class="w-full text-center bg-teal-50/10 p-2 lg:p-4 lg:text-lg">
        検索条件に該当する記事はありませんでした
      </p>
      <p class="text-center">
        <button
          class="w-full max-w-xs mt-6 text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
          @click="back"
        >
          戻る
        </button>
      </p>
    </div>
  </div>
</template>
