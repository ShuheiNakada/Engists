<script setup>
import axios from 'axios'
import { reactive } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'

dayjs.locale(ja)

const comment = reactive({
  datas: [],
})

const route = useRoute()
const router = useRouter()

axios
  .get(`api/articles/${route.params.id}/comments`)
  .then((response) => {
    console.log('コメント一覧の取得に成功')
    console.log({ response })
    comment.datas = response.data
  })
  .catch((error) => {
    console.log('コメント一覧の取得に失敗')
    console.log({ error })
  })

const deleteComment = (comment_id) => {
  axios
    .delete(`api/articles/${route.params.id}/comments/${comment_id}`)
    .then((response) => {
      console.log('コメント削除成功')
      console.log({ response })
      router.go({ path: router.currentRoute.path, force: true })
    })
    .catch((error) => {
      console.log('コメント削除失敗')
      console.log({ error })
    })
}

const myself = reactive({
  userId: window.localStorage.getItem('user-id'),
})

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
  <div class="m-4 p-4 lg:m-8 lg:p-8 rounded dark:bg-teal-800 bg-teal-100">
    <h2 class="lg:text-lg">
      コメント一覧
    </h2>
    <ul v-if="comment.datas">
      <li
        v-for="data in comment.datas"
        :key="data.id"
        class="mb-4 p-4 lg:mb-8 lg:p-8 rounded dark:bg-teal-700"
      >
        <div class="flex mt-2 lg:mt-4">
          <Icon
            icon="bxs:user"
            :width="iconSize.width"
            :height="iconSize.height"
          />
          <router-link :to="`/users/${data.user_id}`">
            <span class="underline hover:text-teal-500 text-xs lg:text-lg">
              {{ data.user_name }}
            </span>
          </router-link>
        </div>
        <div class="mt-2 ml-2 lg:mt-4 lg:ml-4">
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            カテゴリー<span
              class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >{{ data.category }}</span>
          </p>
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            タイトル<span
              class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >{{ data.title }}</span>
          </p>
          <p class="mt-2 text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            コメント内容
            <span
              class="block p-2 mt-1 lg:p-4 lg:mt-2 rounded dark:text-teal-50 text-xs md:text-sm lg:text-lg whitespace-pre-line dark:bg-teal-600 bg-teal-200/50"
            >{{ data.content }}</span>
          </p>
        </div>
        <div class="mt-4 lg:mt-8 text-center">
          <button
            v-if="myself.userId == data.user_id"
            class="w-full max-w-xs text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:py-4 rounded bg-stone-500 hover:bg-stone-500 active:bg-stone-500"
            @click="deleteComment(data.id)"
          >
            削除する
          </button>
        </div>
      </li>
    </ul>
    <div v-if="comment.datas.length === 0">
      <p class="p-4 lg:p-8 lg:text-xl">
        現在コメントはありません
      </p>
    </div>
  </div>
</template>
