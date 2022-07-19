<script setup>
import { reactive, toRefs } from 'vue'
import LoginForm from '../components/LoginForm.vue'
import SignupForm from '../components/SignupForm.vue'
import EasyLogin from '../components/EasyLogin.vue'
import { Icon } from '@iconify/vue'

const correntShowForm = reactive({
  showLoginForm: false,
})
const { showLoginForm } = toRefs(correntShowForm)
</script>

<template>
  <div
    class="flex flex-col space-y-2 md:space-y-4 lg:space-y-6 items-center text-xs md:text-lg lg:text-3xl text-center bg-teal-100/80 dark:bg-teal-800/90 mx-8 rounded-full py-8"
  >
    <p>プログラミング初学者がつながるコミュニティ</p>
    <Icon
      icon="ic:twotone-handshake"
      class="w-8 h-8 md:w-12 md:h-12 lg:w-16 lg:h-16"
    />
    <a
      href="https://github.com/ShuheiNakada/second_app/blob/master/README.md"
      target="_blank"
      class="underline text-emerald-500 hover:text-emerald-400 active:text-emerald-300 dark:text-emerald-500 dark:hover:text-emerald-600 dark:active:text-emerald-700 cursor-pointer"
    >
      Engistsとは
    </a>
  </div>
  <div class="m-4 lg:m-12">
    <div v-if="showLoginForm">
      <LoginForm />
      <p class="pl-4 lg:pl-8 text-sm md:text-lg lg:text-xl">
        初めての方は
        <span
          class="underline text-emerald-500 hover:text-emerald-400 active:text-emerald-300 dark:text-emerald-500 dark:hover:text-emerald-600 dark:active:text-emerald-700 cursor-pointer"
          @click="showLoginForm = false"
        >
          こちら
        </span>
      </p>
    </div>
    <div v-if="!showLoginForm">
      <SignupForm />
      <p class="pl-4 lg:pl-8 text-sm md:text-lg lg:text-xl">
        アカウントをお持ちの方は
        <span
          class="underline text-emerald-500 hover:text-emerald-400 active:text-emerald-300 dark:text-emerald-500 dark:hover:text-emerald-600 dark:active:text-emerald-700 cursor-pointer"
          @click="showLoginForm = true"
        >
          こちら
        </span>
      </p>
    </div>
    <EasyLogin />
  </div>
</template>
