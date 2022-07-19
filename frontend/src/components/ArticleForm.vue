<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'

const articleDatas = reactive({
  title: '',
  content: '',
  tagName: '',
  errors: null,
})
const { title, content, tagName } = toRefs(articleDatas)

const router = useRouter()

const message = reactive({
  error: '',
})

const articleSend = () => {
  const formData = new FormData()
  formData.append('article[title]', articleDatas.title)
  formData.append('article[content]', articleDatas.content)
  formData.append('article[image]', fileUproad.files)
  formData.append('tag_name', articleDatas.tagName)
  axios
    .post('/api/articles', formData)
    .then((response) => {
      console.log('投稿成功')
      console.log({ response })
      router.push({ path: `/myarticles`, query: { successMessage: '記事を投稿しました' } })
    })
    .catch((error) => {
      console.log('投稿失敗')
      console.log({ error })
      message.error = '投稿できませんでした。入力に誤りがないかご確認お願いします。'
    })
}

const fileUproad = reactive({
  deviseEqualLarge: false,
  isEnter: false,
  files: [],
})
const { deviseEqualLarge, isEnter, files } = toRefs(fileUproad)

if (window.innerWidth >= 768) {
  fileUproad.deviseEqualLarge = true
}

const setFile = (event) => {
  fileUproad.files = event.target.files[0]
}

const dragEnter = () => {
  fileUproad.isEnter = true
}
const dragLeave = () => {
  fileUproad.isEnter = false
}
const dragOver = () => {
  fileUproad.isEnter = true
}
const dropFile = (event) => {
  fileUproad.files = event.dataTransfer.files[0]
  fileUproad.isEnter = false
}

const iconSize = reactive({
  width: '24',
  height: '24',
})
if (window.innerWidth >= 768) {
  iconSize.width = '36'
  iconSize.height = '36'
}
if (window.innerWidth >= 1024) {
  iconSize.width = '48'
  iconSize.height = '48'
}
</script>

<template>
  <div class="m-4 p-4 lg:m-8 lg:p-8 rounded border border-teal-500 dark:border-teal-100">
    <h1 class="text-xl md:text-3xl lg:text-4xl font-bold text-center">
      記事を投稿しよう
    </h1>

    <form @submit.prevent="articleSend">
      <div class="mt-6 mx-4 lg:mt-10 lg:mx-8 grid gap-4 lg:gap-8">
        <div>
          <label
            for="title"
            class="text-sm md:text-lg lg:text-2xl"
          >タイトル</label>
          <input
            id="title"
            v-model="title"
            type="text"
            name="title"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full lg:placeholder:text-xl"
            placeholder="50文字以内で入力してください"
          >
        </div>

        <div>
          <label
            for="tagname"
            class="text-sm md:text-lg lg:text-2xl"
          >タグ</label>
          <p class="text-xs md:text-base lg:text-xl block">
            (複数タグは
            <span class="underline decoration-teal-300">半角スペース</span> を入れてください)
          </p>
          <input
            id="tagname"
            v-model="tagName"
            type="text"
            name="tagname"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full lg:placeholder:text-xl"
            placeholder="(例)Rails Ruby rubocop RSpec facker ..."
          >
        </div>

        <div>
          <label
            for="file_upload"
            class="text-sm md:text-lg lg:text-2xl"
          >ファイル添付</label><br>
          <span class="text-xs md:text-base lg:text-xl block">【対応ファイル: jpg/ jpeg/ gif/ png 】</span>
          <span class="text-xs md:text-base lg:text-xl block">（ファイル数: １つまで）</span>
          <div
            v-if="!deviseEqualLarge"
            class="mt-1"
          >
            <label
              class="p-1 text-xs md:p-2 md:text-base lg:p-4 lg:text-xl text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
            >
              <input
                id="file_upload"
                class="hidden"
                type="file"
                @change="setFile"
              >ファイル選択
            </label>
          </div>
          <div v-else-if="deviseEqualLarge">
            <div
              class="py-20 px-12 border rounded text-center dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full lg:placeholder:text-xl"
              :class="{ 'bg-teal-900 dark:bg-teal-100/10': isEnter }"
              @dragenter="dragEnter"
              @dragleave="dragLeave"
              @dragover.prevent="dragOver"
              @drop.prevent="dropFile"
            >
              <label
                class="py-2 px-4 lg:py-4 lg:px-8 lg:text-xl text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
              >
                <input
                  id="file_upload"
                  class="hidden"
                  type="file"
                  @change="setFile"
                >ファイル選択
              </label>
              <p class="mt-4">
                ドラッグ＆ドロップでもファイルをアップロードできます
              </p>
            </div>
          </div>
          <div>
            <p class="mt-1 text-sm md:text-xl text-teal-100/90">
              ■添付したファイル
            </p>
            <p
              v-if="files.length == 0"
              class="ml-4 text-xs md:text-lg text-teal-100/90"
            >
              現在アップロード済みファイルはありません
            </p>
            <p
              v-else-if="files"
              class="flex"
            >
              <Icon
                icon="ant-design:file-image-outlined"
                :width="iconSize.width"
                :height="iconSize.height"
              />
              <span class="my-auto text-sm md:text-lg lg:text-2xl">{{ files.name }}</span>
            </p>
          </div>
        </div>

        <div>
          <label
            for="content"
            class="text-sm md:text-lg lg:text-2xl"
          >内容</label>
          <textarea
            id="content"
            v-model="content"
            name="content"
            class="py-1 px-4 lg:py-4 lg:px-6 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full lg:placeholder:text-xl h-80"
            placeholder="記事の内容/詳細はこちらに入力してください"
          />
        </div>
      </div>

      <div class="mt-8 mb-20 text-center">
        <button
          class="py-2 px-4 lg:py-4 lg:px-8 lg:text-xl text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
        >
          投稿する
        </button>
        <p
          v-if="message.error"
          class="my-4 py-2 text-center w-full rounded bg-teal-50/10"
        >
          {{ message.error }}
        </p>
      </div>
    </form>
  </div>
</template>
