<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import setItem from '../methods/setItem'
import { Icon } from '@iconify/vue'

const myself = reactive({
  userId: localStorage.getItem('user-id'),
})

axios
  .get(`/api/users/${myself.userId}`)
  .then((response) => {
    console.log('自分のユーザー情報の取得に成功')
    console.log({ response })
    fileUproad.previousFile = response.data.user_base.icon_name
  })
  .catch((error) => {
    console.log('自分のユーザー情報の取得に失敗')
    console.log({ error })
  })

const formDatas = reactive({
  password: '',
  passwordConfirmation: '',
  name: localStorage.getItem('name'),
  email: localStorage.getItem('uid'),
})
const { password, passwordConfirmation, name, email } = toRefs(formDatas)

const router = useRouter()
const route = useRoute()

const responseMessage = reactive({
  errorPassword: '',
  errorBasic: '',
})

const editUserPassword = () => {
  axios
    .put('/auth/password', {
      password: formDatas.password,
      password_confirmation: formDatas.passwordConfirmation,
    })
    .then((response) => {
      console.log('パスワード変更に成功')
      console.log({ response })
      router.push({
        path: `/myprofile/${route.params.id}`,
        query: { successMessage: '新しいパスワードに更新しました' },
      })
    })
    .catch((error) => {
      console.log('パスワード変更に失敗')
      console.log({ error })
      responseMessage.errorPassword = 'パスワードを更新できませんでした'
    })
}

const editUserBasic = () => {
  const formData = new FormData()
  formData.append('name', formDatas.name)
  formData.append('email', formDatas.email)
  if (fileUproad.currentFile) {
    formData.append('image', fileUproad.currentFile)
  } else if (fileUproad.previousFile && !fileUproad.currentFile) {
    formData.append('image', fileUproad.previousFile)
  } else {
    formData.append('image', '')
  }
  axios
    .put('/auth', formData)
    .then((response) => {
      console.log('ユーザー基本情報の変更に成功')
      console.log({ response })
      setItem(response.headers, response.data.data.name)
      router.push({
        path: `/myprofile/${route.params.id}`,
        query: { successMessage: 'ユーザー基本情報を更新しました' },
      })
    })
    .catch((error) => {
      console.log('ユーザー基本情報の変更に失敗')
      console.log({ error })
      responseMessage.errorBasic = 'ユーザー基本情報を更新できませんでした'
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
  <form
    class="m-4 p-4"
    @submit.prevent="editUserPassword"
  >
    <h2 class="p-2 text-center text-lg w-full rounded">
      パスワード変更
    </h2>
    <div class="mt-2 p-4 border rounded-lg dark:border-teal-50 border-teal-900">
      <div>
        <label for="password">パスワード</label><br>
        <input
          id="password"
          v-model="password"
          class="py-1 px-4 text-sm md:text-base border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
          type="password"
          placeholder="新しいパスワードを入力してください"
        >
      </div>
      <div class="mt-4">
        <label for="password_confirmation">パスワード(確認用)</label><br>
        <input
          id="password_confirmation"
          v-model="passwordConfirmation"
          class="py-1 px-4 text-sm md:text-base border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
          type="password"
          placeholder="確認のために再度ご入力お願いします"
        >
      </div>
      <div class="text-center mt-8">
        <button
          class="w-full max-w-xs py-2 text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-xs rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
        >
          変更する
        </button>
      </div>
      <p class="bg-teal-100/30 rounded text-center mt-4">
        {{ responseMessage.errorPassword }}
      </p>
    </div>
  </form>

  <form
    class="m-4 p-4"
    @submit.prevent="editUserBasic"
  >
    <h2 class="p-2 text-center text-lg w-full rounded">
      基本情報の変更
    </h2>
    <div class="mt-2 p-4 border rounded-lg dark:border-teal-50 border-teal-900">
      <div>
        <label for="name">ユーザー名</label><br>
        <input
          id="name"
          v-model="name"
          class="py-1 px-4 text-sm md:text-base border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
          type="text"
          placeholder="新しいユーザー名を入力してください"
        >
      </div>

      <div class="mt-4">
        <label for="email">メールアドレス</label><br>
        <input
          id="email"
          v-model="email"
          class="py-1 px-4 text-sm md:text-base border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
          type="email"
          placeholder="新しいメールアドレスを入力してください"
        >
      </div>

      <div class="mt-4">
        <label
          for="file_upload"
          class="text-sm md:text-lg lg:text-2xl"
        >アイコン</label><br>
        <span class="text-xs md:text-base lg:text-xl block">【対応ファイル: jpg/ jpeg/ gif/ png 】</span>
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

      <div class="text-center mt-8">
        <button
          class="w-full max-w-xs py-2 text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-xs rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
        >
          変更する
        </button>
        <p class="bg-teal-100/30 rounded text-center mt-4">
          {{ responseMessage.errorBasic }}
        </p>
      </div>
    </div>
  </form>
</template>
