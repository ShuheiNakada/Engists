<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const formData = reactive({
  content: '',
  sendErrorMessage: '',
})
const { content, sendErrorMessage } = toRefs(formData)

const route = useRoute()
const router = useRouter()

const sendMessage = () => {
  axios
    .post('api/messages', {
      message: {
        room_id: route.params.id,
        content: formData.content,
      },
    })
    .then((response) => {
      console.log('メッセージ送信成功')
      console.log({ response })
      router.go({ path: router.currentRoute.path, force: true })
    })
    .catch((error) => {
      console.log('メッセージ送信失敗')
      console.log({ error })
      formData.sendErrorMessage = error.response.data
    })
}
</script>

<template>
  <div class="m-4 lg:m-12">
    <div class="p-8 lg:p-12 text-center rounded-lg border dark:border-teal-100 border-teal-900">
      <h2 class="text-lg lg:text-2xl">
        メッセージ送信フォーム
      </h2>
      <ul
        v-if="sendErrorMessage"
        class="mt-4 mb-8 w-full max-w-2xl rounded-full m-auto text-center text-lg bg-red-500 p-2"
      >
        <li
          v-for="message in sendErrorMessage"
          :key="message.id"
        >
          {{ message }}
        </li>
      </ul>
      <form @submit.prevent="sendMessage">
        <div class="mt-8 lg:mt-12 grid lg:grid-col">
          <div>
            <label
              for="content"
              class="text-sm lg:text-lg dark:text-emerald-50 block mb-1 font-medium"
            >内容</label>
            <textarea
              id="content"
              v-model="content"
              class="py-1 px-3 lg:py-4 lg:px-6 text-lg block border rounded w-full h-60 lg:h-80 dark:bg-teal-100/10 dark:border-teal-100 dark:text-teal-100 bg-teal-100/10 border-teal-900 text-teal-900 outline-teal-500"
              placeholder="入力してください"
            />
          </div>
        </div>

        <div class="mt-8 lg:mt-12">
          <button
            class="py-2 px-4 lg:py-4 lg:px-8 text-white rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 disabled:opacity-50"
          >
            送信する
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
