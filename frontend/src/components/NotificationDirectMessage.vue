<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import _ from 'lodash'

const notification = reactive({
  datas: [],
  unread: [],
  groupByUser: [],
})
const { unread, groupByUser } = toRefs(notification)

axios
  .get('api/notifications')
  .then((response) => {
    console.log('それぞれの通知情報を取得する')
    console.log({ response })
    notification.datas = response.data
    notification.unread = _.filter(notification.datas, (data) => {
      return data.checked === false
    })
    console.log('未読DMのみ抽出する')
    console.log(notification.unread)
    notification.groupByUser = _.groupBy(notification.unread, 'name')
    console.log('更にメッセージをグループ化')
    console.log(notification.groupByUser)
  })
  .catch((error) => {
    console.log('それぞれの通知情報の取得に失敗')
    console.log({ error })
  })

const router = useRouter()

const moveToDirectRoom = (notification_ids, room_id) => {
  axios
    .put('/api/dm_notifications/all_read', {
      ids: notification_ids,
    })
    .then((response) => {
      console.log('全ての未読を既読に変更することに成功(DMルームに移動)')
      console.log({ response })
      router.push(`/rooms/${room_id}`)
    })
    .catch((error) => {
      console.log('全ての未読を既読に変更することに失敗')
      console.log({ error })
    })
}
</script>

<template>
  <div class="m-4 lg:m-8">
    <div
      v-if="unread.length === 0"
      class="dark:bg-teal-50/10 bg-teal-900/10 rounded p-8 font-bold text-center"
    >
      未読DMはありません
    </div>
    <div v-if="!(unread.length === 0)">
      <p class="text-xs md:text-base lg:text-xl dark:text-teal-50/80">
        未読DM件数:<span class="ml-2 text-sm md:text-lg lg:text-3xl font-bold dark:text-teal-50">{{
          unread.length
        }}</span>
      </p>
      <ul>
        <li
          v-for="notificationData in groupByUser"
          :key="notificationData.id"
          class="m-4 p-4 lg:m-8 lg:p-8 border rounded bg-teal-100 border-teal-200 dark:border-none dark:bg-teal-800"
        >
          <p class="text-sm md:text-lg lg:text-2xl">
            {{ notificationData[0].name }}
            <span class="ml-2 mr-1 lg:ml-4 text-xs md:text-sm lg:text-base dark:text-teal-50/80">未読数</span>{{ notificationData.length }}件
          </p>
          <div class="flex space-x-4 lg:space-x-8 text-xs md:text-sm lg:text-lg mt-4">
            <button
              class="ml-4 px-2 py-1 md:px-4 md:py-2 lg:px-8 lg:py-4 rounded text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 disabled:opacity-50"
              @click="
                moveToDirectRoom(
                  notificationData.map((obj) => obj.id),
                  notificationData[0].room_id,
                )
              "
            >
              DMルームへ
            </button>
            <router-link
              class="ml-4 px-2 py-1 md:px-4 md:py-2 lg:px-8 lg:py-4 rounded text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 disabled:opacity-50"
              :to="`/users/${notificationData[0].visitor_id}`"
            >
              ユーザー詳細へ
            </router-link>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
