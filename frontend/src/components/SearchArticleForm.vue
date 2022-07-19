<script setup>
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'

const formDatas = reactive({
  word1: '',
  sort: 'initialValue',
})
const { word1, sort } = toRefs(formDatas)

const router = useRouter()

const searchArticle = () => {
  router.push({
    name: 'SearchResult',
    params: {
      model: 'article',
      category: 'title_or_content_or_tag',
      word1: formDatas.word1,
      sort: formDatas.sort,
    },
  })
}
</script>

<template>
  <form @submit.prevent="searchArticle">
    <div class="mt-2">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70 text-teal-900"
        for="title_or_content_or_tag"
      >キーワード</label><br>
      <p class="mb-1 text-xs md:text-sm lg:text-lg dark:text-teal-50/70 text-teal-900">
        (<span class="px-1 underline decoration-teal-500">タイトル,</span>
        <span class="px-1 underline decoration-teal-500">記事内容,</span>
        <span class="px-1 underline decoration-teal-500">タグ</span> をキーワードで検索します)
      </p>
      <input
        id="title"
        v-model="word1"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500 dark:placeholder:text-teal-50 placeholder:text-teal-900"
        type="text"
        placeholder="入力してください"
      >
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70 text-teal-900"
        for="sort"
      >並び順：</label><br>
      <select
        id="sort"
        v-model="sort"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500"
        name="sort"
      >
        <option
          disabled
          value="initialValue"
        >
          選択してください
        </option>
        <option value="created_at desc">
          作成日が新しい
        </option>
        <option value="updated_at desc">
          更新日が新しい
        </option>
        <option value="like_number desc">
          いいねが多い
        </option>
      </select>
    </div>
    <div class="text-center mt-6 lg:mt-10">
      <button
        class="w-full max-w-xs text-emerald-50 dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300 font-bold uppercase text-xs md:text-sm lg:text-lg px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-noneease-linear transition-all duration-150"
      >
        検索する
      </button>
    </div>
  </form>
</template>
