<script setup>
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'

const jsonObject = localStorage.getItem('search-result-by-tag')
const jsonParse = JSON.parse(jsonObject)

const article = reactive({
  datas: jsonParse,
  searchWord: localStorage.getItem('search-word'),
})
const { datas, searchWord } = toRefs(article)

const router = useRouter()

const showArticleDetail = (article_id) => {
  console.log('プロフィール詳細ページに移動')
  router.push(`/articles/${article_id}`)
}
</script>

<template>
  <div class="px-4 py-4 mx-4 my-4 bg-emerald-700">
    <h2>
      キーワード「<span class="font-bold">{{ searchWord }}</span>」がタグに含まれている投稿記事
    </h2>
    <div>
      <ul>
        <li
          v-for="articleData in datas"
          :key="articleData.id"
          class="px-4 py-4 mx-4 my-4 border"
        >
          <p>タイトル： {{ articleData.title }}</p>
          <p>投稿時期： {{ articleData.created_at }}</p>
          <p>更新日： {{ articleData.updated_at }}</p>
          <p>etc...</p>
          <p class="pl-4">
            <a
              class="bg-emerald-500 text-white active:bg-emerald-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mx-4 mt-4 ease-linear transition-all duration-150"
              @click="showArticleDetail(articleData.id)"
            >詳細ページ</a>
          </p>
        </li>
      </ul>
    </div>
  </div>
</template>
