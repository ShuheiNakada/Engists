<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { Icon } from '@iconify/vue'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'
import DirectMessageForm from './DirectMessageForm.vue'

dayjs.locale(ja)

const directMessage = reactive({
  users: '',
  myUserId: localStorage.getItem('user-id'),
  contents: [],
})
const { users, myUserId, contents } = toRefs(directMessage)

const route = useRoute()
const router = useRouter()

const correctUser = reactive({
  check: '',
  errorMessage: '',
})

axios
  .get(`/api/rooms/${route.params.id}`)
  .then((response) => {
    console.log('DM送信先ユーザー情報と送信済みメッセージの取得成功')
    console.log({ response })
    directMessage.users = response.data.joined_user
    directMessage.contents = response.data.content
    correctUser.check = true
  })
  .catch((error) => {
    console.log('DM送信先ユーザー情報と送信済みメッセージの取得失敗')
    console.log({ error })
    correctUser.check = false
    correctUser.errorMessage = '正しいユーザーではありません'
  })

const updateNotification = (notification_id) => {
  axios
    .put(`api/notifications/${notification_id}`)
    .then((response) => {
      console.log('通知情報のステータスを更新する')
      console.log({ response })
      router.go({ path: router.currentRoute.path, force: true })
    })
    .catch((error) => {
      console.log('通知情報のステータスの更新失敗')
      console.log({ error })
    })
}

const deleteMessage = (message_id) => {
  axios
    .delete(`api/messages/${message_id}`, {
      params: {
        room_id: route.params.id,
      },
    })
    .then((response) => {
      console.log('メッセージの削除に成功')
      console.log({ response })
      router.go({ path: router.currentRoute.path, force: true })
    })
    .catch((error) => {
      console.log('メッセージの削除に失敗')
      console.log({ error })
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
  {{ $route.query.successMessage }}
  <div v-if="correctUser.check == true">
    <div class="m-4 p-4 lg:m-8 lg:p-8 dark:bg-teal-100/10 bg-teal-900/10 rounded-lg">
      <p class="text-xs lg:text-lg dark:text-teal-50/50">
        DM送信先
      </p>
      <ul>
        <li
          v-for="user in users"
          :key="user.id"
          class="pl-4 lg:pl-6 underline dark:text-teal-50 decoration-2 hover:decoration-teal-500 dark:hover:text-teal-500 hover:text-teal-500"
        >
          <router-link
            v-if="!(user.id == myUserId)"
            :to="`/users/${user.id}`"
            class="lg:text-2xl"
          >
            {{ user.name }}
          </router-link>
        </li>
      </ul>
    </div>
    <div class="m-4 p-4 lg:m-8 lg:p-8 rounded-lg">
      <p class="text-lg lg:text-2xl">
        メッセージ
      </p>
      <ul>
        <li
          v-for="content in contents"
          :key="content.id"
          class="mb-6 lg:mb-10"
        >
          <div
            v-if="!(content.user_id == myUserId)"
            class="flex justify-end text-teal-100"
          >
            <div class="w-4/5 md:w-3/5 p-4 lg:p-8 dark:bg-teal-100/10 bg-teal-900/10 rounded">
              <div
                v-if="content.checked == 0"
                class="text-right"
              >
                <button
                  class="py-1 px-2 lg:py-2 lg:px-4 text-center text-white rounded dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300"
                  @click="updateNotification(content.notification_id)"
                >
                  未読
                </button>
              </div>
              <div
                v-else-if="content.checked == 1"
                class="text-right"
              >
                <button
                  class="py-1 px-2 lg:py-2 lg:px-4 text-center text-white rounded dark:bg-stone-500 dark:hover:bg-stone-600 dark:active:bg-stone-700 bg-stone-500 hover:bg-stone-400 active:bg-stone-300"
                  @click="updateNotification(content.notification_id)"
                >
                  既読
                </button>
              </div>
              <div class="flex space-x-2 lg:space-x-4 dark:text-teal-100 text-teal-900">
                <Icon
                  icon="bx:user"
                  :width="iconSize.width"
                  :height="iconSize.height"
                />
                <p class="text-xs lg:text-lg lg:py-1">
                  相手：
                </p>
              </div>
              <p
                class="mt-1 lg:mt-4 text-lg lg:text-xl pl-2 lg:pl-4 whitespace-pre-line dark:text-teal-100 text-teal-900"
              >
                {{ content.content }}
              </p>
              <p
                class="text-xs lg:text-sm mt-1 lg:mt-2 dark:text-teal-100/80 text-teal-900/80 text-right"
              >
                送信日時：{{ dayjs(content.created_at).format('YYYY年M月D日(ddd) HH:mm') }}
              </p>
            </div>
          </div>
          <div
            v-else-if="content.user_id == myUserId"
            class="flex justify-start text-teal-50"
          >
            <div class="w-4/5 md:w-3/5 p-4 lg:p-8 dark:bg-teal-100/10 bg-teal-900/10 rounded">
              <div class="text-right">
                <button
                  class="py-1 px-2 lg:py-2 lg:px-4 text-center text-white rounded dark:bg-red-500 dark:hover:bg-red-600 dark:active:bg-red-700 bg-red-500 hover:bg-red-400 active:bg-red-300"
                  @click="deleteMessage(content.id)"
                >
                  削除
                </button>
              </div>
              <div class="flex space-x-2 lg:space-x-4 dark:text-teal-50 text-teal-900">
                <Icon
                  icon="bxs:user"
                  :width="iconSize.width"
                  :height="iconSize.height"
                />
                <p class="text-xs lg:text-lg lg:py-1">
                  あなた：
                </p>
              </div>
              <p
                class="mt-1 lg:mt-4 text-lg lg:text-xl pl-2 lg:pl-4 whitespace-pre-line dark:text-teal-50 text-teal-900"
              >
                {{ content.content }}
              </p>
              <p
                class="text-xs lg:text-sm mt-1 lg:mt-2 dark:text-teal-100/80 text-teal-900/80 text-right"
              >
                送信日時：{{ dayjs(content.created_at).format('YYYY年M月D日(ddd) HH:mm') }}
              </p>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <DirectMessageForm />
  </div>
  <div v-else-if="correctUser.check == false">
    <p class="bg-stone-500 text-stone-100 rounded text-center mx-8 my-4 lg:mx-12 lg:my-8 lg:p-2">
      {{ correctUser.errorMessage }}
    </p>
    <p class="text-center mt-8">
      <router-link
        class="py-2 px-4 lg:py-4 lg:px-8 text-white rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 disabled:opacity-50"
        to="/rooms/index"
      >
        対象DMルームへ移動
      </router-link>
    </p>
  </div>
</template>
