<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const formDatas = reactive({
  category: '',
  title: '',
  content: '',
  error: '',
})
const { category, title, content } = toRefs(formDatas)

const route = useRoute()
const router = useRouter()

const sendComment = () => {
  axios
    .post(`api/articles/${route.params.id}/comments`, {
      category: formDatas.category,
      title: formDatas.title,
      content: formDatas.content,
    })
    .then((response) => {
      console.log('コメント投稿に成功')
      console.log({ response })
      router.go({ path: router.currentRoute.path, force: true })
    })
    .catch((error) => {
      console.log('コメント投稿に失敗')
      console.log({ error })
      formDatas.error = error.response.data.errors
    })
}
</script>

<template>
  <div class="m-4 p-4 lg:m-8 lg:p-8 rounded dark:bg-teal-800 bg-teal-100">
    <h2 class="lg:text-lg">
      コメント投稿フォーム
    </h2>
    <ul
      v-if="formDatas.error"
      class="w-full text-sm md:text-lg lg:text-2xl text-center bg-teal-50/10 p-2 lg:p-4"
    >
      <li
        v-for="data in formDatas.error"
        :key="data.id"
      >
        {{ data }}
      </li>
    </ul>
    <form @submit.prevent="sendComment">
      <div class="p-4 lg:p-8">
        <div>
          <label for="category">カテゴリー</label><br>
          <select
            id="category"
            v-model="category"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500"
            name="category"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>質問</option>
            <option>回答</option>
            <option>関連情報</option>
            <option>その他</option>
          </select>
        </div>

        <div class="mt-4">
          <label for="title">タイトル</label><br>
          <input
            id="title"
            v-model="title"
            type="text"
            name="title"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full lg:placeholder:text-lg"
            placeholder="30文字以内"
          >
        </div>

        <div class="mt-4">
          <label for="content">コメント内容</label><br>
          <textarea
            id="content"
            v-model="content"
            type="content"
            name="content"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full h-40 lg:h-60 lg:placeholder:text-lg"
            placeholder="入力してください"
          />
        </div>
      </div>

      <div class="mt-4 text-center">
        <button
          class="mb-8 w-full max-w-sm text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
        >
          送信する
        </button>
      </div>
    </form>
  </div>
</template>
