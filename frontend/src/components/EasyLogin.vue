<script setup>
import axios from 'axios'
import { reactive } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import setItem from '../methods/setItem'

const response = reactive({
  message: '',
})

const route = useRoute()
const router = useRouter()

const easyLogin = () => {
  axios
    .post('/auth/sign_in', {
      email: 'test@user.com',
      password: 'pass12345678',
    })
    .then((response) => {
      console.log('テストユーザーでログイン成功')
      console.log({ response })
      setItem(response.headers, response.data.data.name)
      console.log('Homeページにリダイレクト')
      router.push({ name: 'Home' })
      console.log(`移動元ページ: ${route}`)
    })
    .catch((error) => {
      console.log('テストユーザーでログイン失敗')
      console.log({ error })
      response.message = '簡単ログインに失敗しました'
    })
}
</script>

<template>
  <div class="mt-8 lg:mt-16 text-center">
    <p class="text-xs md:text-base lg:text-xl">
      テストユーザーとしてログインできます
    </p>
    <button
      class="mt-2 mb-8 py-2 px-4 lg:py-4 lg:px-8 lg:text-lg text-white rounded bg-teal-500 hover:bg-teal-600 active:bg-teal-700 disabled:opacity-50"
      @click="easyLogin"
    >
      簡単ログイン
    </button>
    <p>{{ response.message }}</p>
  </div>
</template>
