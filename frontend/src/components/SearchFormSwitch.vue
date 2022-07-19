<script setup>
import { reactive, toRefs } from 'vue'
import SearchProfileForm from '../components/SearchProfileForm.vue'
import SearchArticleForm from '../components/SearchArticleForm.vue'
import axios from 'axios'
import VuexStore from '../components/VuexStore.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}

const visible = reactive({
  openTab: 1,
})
const { openTab } = toRefs(visible)

const toggleTabs = (tabNumber) => {
  visible.openTab = tabNumber
}
</script>

<template>
  <VuexStore />
  <div
    class="m-2 p-2 md:m-4 md:p-4 lg:m-8 lg:p-8 border border-teal-400 rounded dark:bg-teal-800 dark:border-none"
  >
    <div class="flex flex-wrap">
      <h2 class="font-bold text-lg lg:text-2xl">
        検索してみよう
      </h2>
      <div class="w-full">
        <ul class="flex mb-1 list-none flex-row">
          <li class="mr-1 last:mr-0 flex-auto text-center w-1/2">
            <a
              class="text-sm lg:text-lg font-bold uppercase px-5 py-3 shadow-lg rounded block leading-normal"
              :class="{
                'dark:text-teal-700 dark:bg-teal-50 text-teal-900 bg-teal-50': openTab !== 1,
                'dark:text-teal-50 dark:bg-teal-700 text-teal-900 bg-teal-100': openTab === 1,
              }"
              @click="toggleTabs(1)"
            >
              ユーザー
            </a>
          </li>
          <li class="-mb-px mr-2 last:mr-0 flex-auto text-center w-1/2">
            <a
              class="text-sm lg:text-lg font-bold uppercase px-5 py-3 shadow-lg rounded block leading-normal"
              :class="{
                'dark:text-teal-700 dark:bg-teal-50 text-teal-900 bg-teal-50': openTab !== 2,
                'dark:text-teal-50 dark:bg-teal-700 text-teal-900 bg-teal-100': openTab === 2,
              }"
              @click="toggleTabs(2)"
            >
              投稿記事
            </a>
          </li>
        </ul>
        <div
          class="flex flex-col min-w-0 break-words bg-teal-100 text-teal-900 dark:bg-teal-700 dark:text-teal-50 w-full shadow-lg rounded"
        >
          <div class="p-4 flex-auto">
            <div class="tab-content tab-space">
              <div :class="{ hidden: openTab !== 1, block: openTab === 1 }">
                <SearchProfileForm />
              </div>
              <div :class="{ hidden: openTab !== 2, block: openTab === 2 }">
                <SearchArticleForm />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
