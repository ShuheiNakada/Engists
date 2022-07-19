<script setup>
import { reactive, toRefs } from 'vue'
import { useRoute } from 'vue-router'
import { Icon } from '@iconify/vue'
import axios from 'axios'

const route = useRoute()

const like = reactive({
  message: '',
  alreadyLiked: '',
  my_article: '',
  count: '',
})
const { alreadyLiked, my_article } = toRefs(like)

axios
  .get(`/api/likes`, {
    params: {
      id: route.params.id,
    },
  })
  .then((response) => {
    console.log('既にいいねしている投稿記事IDの取得成功')
    console.log({ response })
    for (let i = 0; i < response.data.liked_ids.length; i++) {
      if (response.data.liked_ids[i] === Number(route.params.id)) {
        like.alreadyLiked = true
        break
      }
    }
    for (let i = 0; i < response.data.my_ids.length; i++) {
      if (response.data.my_ids[i] === Number(route.params.id)) {
        like.my_article = true
      }
    }
    like.count = response.data.count
  })
  .catch((error) => {
    console.log('既にいいねしている投稿記事IDの取得失敗')
    console.log({ error })
  })

const likeArticle = () => {
  axios
    .post(
      '/api/likes',
      {},
      {
        params: {
          id: route.params.id,
        },
      },
    )
    .then((response) => {
      console.log('いいね成功')
      console.log({ response })
      like.message = 'いいねしました'
      like.alreadyLiked = true
      like.count = response.data
    })
    .catch((error) => {
      console.log('いいね失敗')
      console.log({ error })
      like.message = 'いいね出来ませんでした'
    })
}
const unlikeArticle = () => {
  axios
    .delete(`/api/likes/${route.params.id}`)
    .then((response) => {
      console.log('いいね解除に成功')
      console.log({ response })
      like.message = 'いいね解除しました'
      like.alreadyLiked = false
      like.count = response.data
    })
    .catch((error) => {
      console.log('いいね解除に失敗')
      console.log({ error })
      like.message = 'いいね解除出来ませんでした'
    })
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
  <div v-if="!my_article">
    <p
      v-if="like.message"
      class="text-center rounded dark:bg-teal-50/10 bg-teal-900/10 p-1"
    >
      {{ like.message }}
    </p>
    <div
      v-show="!alreadyLiked"
      class="mt-1"
    >
      <button
        class="text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-xs px-2 py-1 md:px-4 md:py-2 lg:px-6 lg:py-3 rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
        @click="likeArticle"
      >
        <Icon
          icon="ant-design:like-filled"
          :width="iconSize.width"
          :height="iconSize.height"
        />
      </button>
      <p class="pl-3 md:pl-5 lg:pl-7 md:text-lg lg:text-xl dark:text-teal-300">
        {{ like.count }}
      </p>
    </div>
    <div
      v-show="alreadyLiked"
      class="mt-1"
    >
      <button
        class="text-white bg-stone-500 hover:bg-stone-600 active:bg-stone-700 text-xs px-2 py-1 md:px-4 md:py-2 lg:px-6 lg:py-3 rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
        @click="unlikeArticle"
      >
        <Icon
          icon="ant-design:like-filled"
          :width="iconSize.width"
          :height="iconSize.height"
        />
      </button>
      <p class="pl-3 md:pl-5 lg:pl-7 md:text-lg lg:text-xl dark:text-teal-300">
        {{ like.count }}
      </p>
    </div>
  </div>
</template>
