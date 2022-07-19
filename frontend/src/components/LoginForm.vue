<script setup>
import { reactive, toRefs } from 'vue'
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import setItem from '../methods/setItem'

const userDatas = reactive({
  email: '',
  password: '',
  errors: null,
})

const { email, password, errors } = toRefs(userDatas)

const router = useRouter()
const route = useRoute()

const login = () => {
  userDatas.errors = null
  axios
    .post('/auth/sign_in', {
      email: userDatas.email,
      password: userDatas.password,
    })
    .then((response) => {
      console.log('ログイン成功')
      console.log({ response })
      setItem(response.headers, response.data.data.name)
      console.log('Homeページにリダイレクト')
      router.push({ name: 'Home' })
      console.log(`移動元ページ: ${route}`)
    })
    .catch((error) => {
      console.log('ログイン失敗')
      console.log({ error })
      userDatas.errors = error.response.data.errors
    })
}
</script>

<template>
  <div class="px-8 py-4 lg:px-16 lg:py-8 rounded border border-teal-500 dark:border-teal-100">
    <h1 class="text-xl md:text-3xl lg:text-4xl font-bold text-center">
      ログイン
    </h1>

    <form @submit.prevent="login">
      <div class="mt-6 mx-4 lg:mt-10 lg:mx-8 grid gap-4 lg:gap-8">
        <div>
          <label
            for="email"
            class="text-sm md:text-lg lg:text-2xl"
          >メールアドレス</label>
          <input
            id="email"
            v-model="email"
            type="email"
            name="email"
            class="py-1 px-4 lg:py-2 lg:px-6 border rounded dark:border-none dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full placeholder:text-lg"
            placeholder="Email"
          >
        </div>

        <div>
          <label
            for="password"
            class="text-sm md:text-lg lg:text-2xl"
          >パスワード</label>
          <input
            id="password"
            v-model="password"
            type="password"
            name="password"
            class="py-1 px-4 lg:py-2 lg:px-6 border rounded dark:border-none dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full placeholder:text-lg"
            placeholder="Password"
          >
        </div>
      </div>

      <div class="mt-8 text-center">
        <button
          class="py-2 px-4 lg:py-4 lg:px-8 lg:text-lg text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
        >
          ログインする
        </button>
        <br>
        <ul class="mt-4">
          <li
            v-for="error in errors"
            :key="error.id"
          >
            {{ error }}
          </li>
        </ul>
      </div>
    </form>
  </div>
</template>
