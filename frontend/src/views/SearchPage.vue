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
  <div class="flex flex-wrap m-4 lg:m-8">
    <div class="w-full">
      <ul class="flex mb-1 lg:mb-2 list-none flex-wrap flex-row">
        <li class="mr-2 last:mr-0 flex-auto text-center">
          <a
            class="text-xs lg:text-lg font-bold uppercase px-5 py-3 lg:py-5 shadow-lg rounded block leading-normal"
            :class="{
              'dark:text-teal-700 dark:bg-teal-50 text-teal-900 bg-teal-50': openTab !== 1,
              'dark:text-teal-50 dark:bg-teal-700 text-teal-900 bg-teal-100': openTab === 1,
            }"
            @click="toggleTabs(1)"
          >
            プロフィールから探す
          </a>
        </li>
        <li class="-mb-px mr-2 last:mr-0 flex-auto text-center">
          <a
            class="text-xs lg:text-lg font-bold uppercase px-5 py-3 lg:py-5 shadow-lg rounded block leading-normal"
            :class="{
              'dark:text-teal-700 dark:bg-teal-50 text-teal-900 bg-teal-50': openTab !== 2,
              'dark:text-teal-50 dark:bg-teal-700 text-teal-900 bg-teal-100': openTab === 2,
            }"
            @click="toggleTabs(2)"
          >
            投稿記事から探す
          </a>
        </li>
      </ul>
      <div
        class="flex flex-col min-w-0 break-words bg-teal-100 dark:bg-teal-700 dark:text-teal-50 w-full mb-6 shadow-lg rounded"
      >
        <div class="px-4 py-5 flex-auto">
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
</template>
