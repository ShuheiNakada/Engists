<script setup>
import { reactive, toRefs } from 'vue'
import axios from 'axios'
import { Icon } from '@iconify/vue'
import { useRoute } from 'vue-router'

const props = defineProps({
  userId: {
    type: Number,
    required: true,
  },
})

const route = useRoute()

axios
  .get(`/api/users/${route.params.id}/followers`)
  .then((response) => {
    console.log('フォローされているユーザー情報の取得成功')
    console.log({ response })
    for (let i = 0; i < response.data.length; i++) {
      if (response.data[i].email === window.localStorage.getItem('uid')) {
        follow.visible = false
        break
      }
    }
  })
  .catch((error) => {
    console.log('フォローされているユーザー情報の取得失敗')
    console.log({ error })
  })

const follow = reactive({
  message: '',
  visible: true,
})
const { visible } = toRefs(follow)

const emit = defineEmits(['followMessage'])

const followUser = (user_id) => {
  console.log(user_id)
  axios
    .post(
      '/api/relationships',
      {},
      {
        params: {
          followed_id: user_id,
        },
      },
    )
    .then((response) => {
      console.log('フォロー成功')
      console.log({ response })
      follow.message = 'フォローしました'
      follow.visible = false
      emit('followMessage', follow.message)
    })
    .catch((error) => {
      console.log('フォロー失敗')
      console.log({ error })
      follow.message = 'フォロー出来ませんでした'
      emit('followMessage', follow.message)
    })
}
const unfollowUser = (user_id) => {
  console.log(user_id)
  console.log(`/api/relationships/${user_id}`)
  axios
    .delete(`/api/relationships/${user_id}`)
    .then((response) => {
      console.log('フォロー解除成功')
      console.log({ response })
      follow.message = 'フォロー解除しました'
      follow.visible = true
      emit('followMessage', follow.message)
    })
    .catch((error) => {
      console.log('フォロー解除失敗')
      console.log({ error })
      follow.message = 'フォロー解除が出来ませんでした'
      emit('followMessage', follow.message)
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
  <p
    v-show="visible"
    class="flex flex-col items-center text-base"
  >
    <button
      class="text-emerald-50 font-bold px-4 py-2 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
      @click="followUser(userId)"
    >
      <Icon
        icon="carbon:user-follow"
        :width="iconSize.width"
        :height="iconSize.height"
      />
    </button>
    <span class="text-xs md:text-sm lg:text-lg dark:font-thin text-center">Follow</span>
  </p>
  <p
    v-show="!visible"
    class="flex flex-col items-center text-base"
  >
    <button
      class="text-emerald-50 font-bold px-4 py-2 rounded bg-stone-500 hover:bg-stone-600 active:bg-stone-700"
      @click="unfollowUser(userId)"
    >
      <Icon
        icon="ri:user-unfollow-line"
        :width="iconSize.width"
        :height="iconSize.height"
      />
    </button>
    <span class="text-xs md:text-sm lg:text-lg dark:font-thin text-center">Unfollow</span>
  </p>
</template>
