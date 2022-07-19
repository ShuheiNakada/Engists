<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'
import LikeButton from './LikeButton.vue'

dayjs.locale(ja)

const articleDetail = reactive({
  datas: [],
  visible: false,
})
const { datas, visible } = toRefs(articleDetail)

const route = useRoute()

axios
  .get(`/api/articles/${route.params.id}`)
  .then((response) => {
    console.log('投稿記事の詳細データを取得成功')
    console.log({ response })
    articleDetail.datas = response.data
    if (window.localStorage.getItem('user-id') == response.data.user_id) {
      articleDetail.visible = true
    }
  })
  .catch((error) => {
    console.log('投稿記事の詳細データを取得失敗')
    console.log({ error })
  })

const router = useRouter()

const editArticle = (article_id) => {
  router.push(`/articles/${article_id}/edit`)
}

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
  <p
    v-if="$route.query.successMessage"
    class="w-full text-lg text-center p-2 bg-teal-50/10"
  >
    {{ $route.query.successMessage }}
  </p>
  <div class="m-4 p-4 lg:m-8 lg:p-8 rounded dark:bg-teal-800 bg-teal-100">
    <div class="flex mt-2 lg:mt-4 lg:space-x-2">
      <Icon
        icon="bxs:user"
        :width="iconSize.width"
        :height="iconSize.height"
      />
      <router-link :to="`/users/${datas.user_id}`">
        <span class="underline hover:text-teal-500 text-xs lg:text-lg">
          {{ datas.user_name }}
        </span>
      </router-link>
    </div>
    <div class="flex space-x-4 lg:space-x-8 lg:mt-2">
      <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
        作成日<span class="ml-1 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
          dayjs(datas.created_at).format('YYYY年M月D日')
        }}</span>
      </p>
      <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
        更新日<span class="ml-1 md:ml-4 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
          dayjs(datas.updated_at).format('YYYY年M月D日')
        }}</span>
      </p>
    </div>
    <h2 class="mt-4 lg:mt-8 font-bold text-lg md:text-3xl lg:text-4xl">
      {{ datas.title }}
    </h2>
    <div class="flex">
      <Icon
        icon="fa-solid:tags"
        :width="iconSize.width"
        :height="iconSize.height"
      />
      <p class="px-2 lg:p-2 rounded dark:text-teal-50 text-sm md:text-base lg:text-xl">
        {{ datas.tag_name }}
      </p>
    </div>
    <div>
      <LikeButton />
    </div>
    <div class="mt-4 lg:mt-8 dark:bg-teal-700 rounded">
      <div class="dark:text-teal-50/80 border border-teal-500 rounded dark:border-none">
        <p
          class="p-4 lg:p-8 rounded dark:text-teal-50 text-sm md:text-base lg:text-xl whitespace-pre-line"
        >
          {{ datas.content }}
        </p>
      </div>
    </div>
    <div
      v-if="datas.image_path"
      class="p-2 md:p-4 lg:p-8 mt-4 lg:mt-8 rounded"
    >
      <img
        :src="datas.image_path"
        class="w-4/5 m-auto"
      >
    </div>
    <div class="text-center mt-4 lg:mt-8">
      <button
        v-if="visible === true"
        class="w-full max-w-xs text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
        @click="editArticle(datas.id)"
      >
        編集する
      </button>
    </div>
  </div>
</template>
