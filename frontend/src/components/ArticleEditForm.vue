<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'

const article = reactive({
  datas: [],
})

const route = useRoute()

axios
  .get(`/api/articles/${route.params.id}`)
  .then((response) => {
    console.log('記事情報を取得成功')
    console.log({ response })
    article.datas = response.data
    fileUproad.previousFile = response.data.image_name
  })
  .catch((error) => {
    console.log('記事情報の取得失敗')
    console.log({ error })
  })

const message = reactive({
  error: '',
})

const router = useRouter()

const editArticle = () => {
  const formData = new FormData()
  formData.append('article[title]', article.datas.title)
  formData.append('article[content]', article.datas.content)
  if (fileUproad.currentFile) {
    formData.append('article[image]', fileUproad.currentFile)
  } else if (fileUproad.previousFile && !fileUproad.currentFile) {
    formData.append('article[image]', fileUproad.previousFile)
  } else {
    formData.append('article[image]', '')
  }
  formData.append('tag_name', article.datas.tag_name)
  axios
    .put(`/api/articles/${route.params.id}`, formData)
    .then((response) => {
      console.log('記事の編集に成功')
      console.log({ response })
      router.push({
        path: `/articles/${route.params.id}`,
        query: { successMessage: '記事を更新しました' },
      })
    })
    .catch((error) => {
      console.log('記事の編集に失敗')
      console.log({ error })
      message.error = '記事更新に失敗しました。入力内容をお確かめください。'
    })
}

const fileUproad = reactive({
  deviseEqualLarge: false,
  isEnter: false,
  previousFile: '',
  currentFile: '',
})
const { deviseEqualLarge, isEnter, previousFile, currentFile } = toRefs(fileUproad)

if (window.innerWidth >= 768) {
  fileUproad.deviseEqualLarge = true
}

const setFile = (event) => {
  fileUproad.currentFile = event.target.files[0]
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
  fileUproad.currentFile = event.dataTransfer.files[0]
  fileUproad.isEnter = false
}
const deleteFilePrevious = () => {
  fileUproad.previousFile = ''
}
const deleteFileCurrent = () => {
  fileUproad.currentFile = ''
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
  <div
    class="m-4 px-8 py-4 lg:m-8 lg:px-12 lg:py-8 rounded border border-teal-500 dark:border-teal-100"
  >
    <h1 class="text-xl md:text-3xl lg:text-4xl font-bold text-center">
      記事編集フォーム
    </h1>

    <form @submit.prevent="editArticle">
      <div class="mt-6 mx-4 lg:mt-10 lg:mx-12 grid gap-4">
        <div>
          <label
            for="title"
            class="text-sm md:text-lg lg:text-2xl"
          >タイトル</label>
          <p class="ml-4 text-sm lg:text-base">
            50文字以内で入力してください
          </p>
          <input
            id="title"
            type="text"
            name="title"
            class="py-1 px-4 lg:py-4 lg:px-6 lg:text-xl border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            :value="article.datas.title"
            @input="article.datas.title = $event.target.value"
          >
        </div>

        <div>
          <label
            for="tagname"
            class="text-sm md:text-lg lg:text-2xl"
          >タグ</label>
          <p class="ml-4 text-sm lg:text-base">
            複数タグは <span class="underline decoration-teal-300">カンマ</span> と
            <span class="underline decoration-teal-300">半角スペース</span> を入れてください
          </p>
          <p class="ml-4 text-sm lg:text-base">
            (例)Rails, Ruby, rubocop, RSpec, facker, ...
          </p>
          <input
            id="tagname"
            type="text"
            name="tagname"
            class="py-1 px-4 lg:py-4 lg:px-6 lg:text-xl border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            :value="article.datas.tag_name"
            @input="article.datas.tag_name = $event.target.value"
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
          <div class="md:flex md:justify-between">
            <div class="p-1 m-1 md:p-2 md:w-1/2 text-center bg-teal-100/10 rounded-lg">
              <p class="mt-1 text-sm md:text-lg text-teal-100/90">
                登録済みのファイル
              </p>
              <p
                v-if="!previousFile"
                class="ml-4 text-xs md:text-base text-teal-100/90"
              >
                (登録済みファイルはありません)
              </p>
              <p
                v-else
                class="flex justify-center"
              >
                <span
                  class="my-auto cursor-pointer"
                  @click="deleteFilePrevious"
                > × </span>
                <Icon
                  icon="ant-design:file-image-outlined"
                  :width="iconSize.width"
                  :height="iconSize.height"
                />
                <span class="my-auto text-sm md:text-lg lg:text-2xl">{{ previousFile }}</span>
              </p>
            </div>
            <div class="p-1 m-1 md:p-2 md:w-1/2 text-center bg-teal-100/10 rounded-lg">
              <p class="mt-1 text-sm md:text-lg text-teal-100/90">
                新しくアップロードしたファイル
              </p>
              <p
                v-if="!currentFile"
                class="ml-4 text-xs md:text-base text-teal-100/90"
              >
                (選択されたファイルはありません)
              </p>
              <p
                v-else
                class="flex justify-center"
              >
                <span
                  class="my-auto cursor-pointer"
                  @click="deleteFileCurrent"
                > × </span>
                <Icon
                  icon="ant-design:file-image-outlined"
                  :width="iconSize.width"
                  :height="iconSize.height"
                />
                <span class="my-auto text-sm md:text-lg lg:text-2xl">{{ currentFile.name }}</span>
              </p>
            </div>
          </div>
        </div>

        <div>
          <label
            for="content"
            class="text-sm md:text-lg lg:text-2xl"
          >内容</label>
          <textarea
            id="content"
            name="content"
            class="py-1 px-4 lg:py-4 lg:px-6 lg:text-xl border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full h-60"
            :value="article.datas.content"
            @input="article.datas.content = $event.target.value"
          />
        </div>
      </div>

      <div class="mt-8 text-center">
        <button
          class="py-2 px-4 lg:py-4 lg:px-8 lg:text-lg text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
        >
          投稿する
        </button>
        <p
          v-if="message.error"
          class="my-4 py-2 lg:p-4 text-center w-full rounded bg-teal-50/10"
        >
          {{ message.error }}
        </p>
      </div>
    </form>
  </div>
</template>
