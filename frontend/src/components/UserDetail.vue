<script setup>
import axios from 'axios'
import { reactive, toRefs } from 'vue'
import { useRoute } from 'vue-router'
import { Icon } from '@iconify/vue'
import FollowButton from './FollowButton.vue'
import DirectMessageButton from './DirectMessageButton.vue'
import UserProfileCreateForm from './UserProfileCreateForm.vue'

const user = reactive({
  baseDatas: [],
  profileDatas: [],
  age: '',
  room_id: '',
})
const { baseDatas, profileDatas, age, room_id } = toRefs(user)

const route = useRoute()

const conditions = reactive({
  roomCreated: false,
  profileRegistered: false,
  myselfCheck: false,
})
const { roomCreated, profileRegistered, myselfCheck } = toRefs(conditions)

axios
  .get(`/api/users/${route.params.id}`)
  .then((response) => {
    console.log('ユーザー情報を取得成功')
    console.log({ response })
    user.baseDatas = response.data.user_base
    user.profileDatas = response.data.user_profile

    // 誕生日から年齢を算出する
    const birthDate = response.data.user_profile.birth
    const ageCalculation = (birthDate, nowDate) => {
      const age = nowDate.getFullYear() - birthDate.getFullYear()
      const thisYearBirthday = new Date(
        nowDate.getFullYear(),
        birthDate.getMonth(),
        birthDate.getDate(),
      )
      return age + (thisYearBirthday.getTime() > nowDate.getTime() ? -1 : 0)
    }
    const calculatedAge = ageCalculation(new Date(birthDate), new Date())
    user.age = calculatedAge

    if (response.data.user_profile.profile_id != '') {
      conditions.profileRegistered = true
    }

    // メールアドレスが一致するなら自分自身と認識する
    if (window.localStorage.getItem('uid') == response.data.user_base.email) {
      conditions.myselfCheck = true
    }

    // DMルームを作成済みなら直接ルームに移動できるようデータを変更する
    if (response.data.dm_room_check == true) {
      conditions.roomCreated = true
      user.room_id = response.data.room_id
    }
  })
  .catch((error) => {
    console.log('ユーザー情報を取得失敗')
    console.log({ error })
  })

const message = reactive({
  follow: '',
})
const setMessage = (param) => (message.follow = param)

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
  <div v-if="profileRegistered == false && myselfCheck">
    <UserProfileCreateForm />
  </div>
  <div class="m-4 p-4 lg:m-8 lg:p-8 rounded dark:bg-teal-800 bg-teal-100">
    <h2 class="font-bold text-lg md:text-2xl lg:text-4xl">
      プロフィール
    </h2>
    <div class="m-4 lg:m-8">
      <div class="flex flex-col mb-2 lg:mb-4">
        <div v-if="!baseDatas.icon_name">
          <Icon
            icon="bxs:user"
            :width="iconSize.width"
            :height="iconSize.height"
            class="object-cover w-24 h-24 md:w-48 md:h-48 lg:w-72 lg:h-72 m-auto rounded-full"
          />
        </div>
        <div v-else>
          <img
            :src="baseDatas.icon_path"
            class="object-cover w-24 h-24 md:w-48 md:h-48 lg:w-72 lg:h-72 m-auto rounded-full"
          >
        </div>
        <span class="py-1 text-base md:text-lg lg:text-2xl text-center">{{ baseDatas.name }}</span>
      </div>
      <p
        v-if="message.follow"
        class="rounded text-center mb-1 dark:bg-teal-700 bg-teal-900/10 lg:text-lg lg:p-2"
      >
        {{ message.follow }}
      </p>
      <div
        v-if="myselfCheck == false"
        class="flex"
      >
        <FollowButton
          :user-id="Number(baseDatas.id)"
          @follow-message="setMessage"
        />
        <div v-if="roomCreated == false">
          <DirectMessageButton />
        </div>
        <p
          v-else-if="roomCreated == true"
          class="ml-4 md:ml-6 flex flex-col items-center"
        >
          <router-link
            :to="`/rooms/${room_id}`"
            class="text-emerald-50 font-bold px-4 py-2 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
          >
            <Icon
              icon="cil:room"
              :width="iconSize.width"
              :height="iconSize.height"
            />
          </router-link>
          <span class="text-xs md:text-sm lg:text-lg dark:font-thin text-center">DM-Room</span>
        </p>
      </div>
      <div
        v-if="myselfCheck == true"
        class="rounded w-full text-center dark:bg-teal-100/20 bg-teal-200 lg:p-2"
      >
        自分のプロフィールです
      </div>
    </div>
    <div class="rounded p-4 lg:p-8 border border-teal-500/80 dark:bg-teal-700 dark:border-none">
      <h2 class="text-sm md:text-lg lg:text-2xl">
        基本情報
      </h2>
      <div class="pl-2 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          ステータス<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.status }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          年齢(学習開始時)<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.starting_age }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          現在の年齢<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ age }}歳</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          性別<span class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.gender
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          居住地<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.residence }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          趣味<span class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.hobby
          }}</span>
        </p>
        <div class="text-xs md:text-sm mt-2 dark:text-teal-50/80">
          自己紹介文
          <p
            class="p-2 mt-1 lg:p-4 lg:mt-2 rounded dark:text-teal-50 text-xs md:text-sm lg:text-lg whitespace-pre-line dark:bg-teal-600 bg-teal-200/50"
          >
            {{ profileDatas.introduction }}
          </p>
        </div>
      </div>
    </div>
    <div
      class="rounded p-4 lg:p-8 mt-4 lg:mt-8 border border-teal-500/80 dark:bg-teal-700 dark:border-none"
    >
      <h2 class="text-sm md:text-lg lg:text-2xl">
        各種リンク
      </h2>
      <div class="px-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          GitHub
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-4 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.github }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Twitter
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-4 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.twitter }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Qiita
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-4 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.qiita }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Wontedly
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-4 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.wontedly }}
          </a>
        </p>
      </div>
    </div>
    <div
      class="rounded p-4 lg:p-8 mt-4 lg:mt-8 border border-teal-500/80 dark:bg-teal-700 dark:border-none"
    >
      <h2 class="text-sm md:text-lg lg:text-2xl">
        ポートフォリオ
      </h2>
      <div class="pl-2 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          使用技術<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.technology_used }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          学習期間<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.study_period }}ヶ月</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          勉強方法<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.study_method }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          参考教材<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.teaching_materials }}</span>
        </p>
      </div>
    </div>
    <div
      class="rounded p-4 lg:p-8 mt-4 lg:mt-8 border border-teal-500/80 dark:bg-teal-700 dark:border-none"
    >
      <h2 class="text-sm md:text-lg lg:text-2xl">
        就職活動
      </h2>
      <div class="pl-2 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          転職先の企業形態<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.corporate_form }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          企業規模<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >従業員 {{ profileDatas.company_size }}名</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          年収<span class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.annual_income }}万円</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          応募企業数<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.entry }}社</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          面接企業数<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.meet }}社</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          内定企業数<span
            class="ml-2 md:ml-4 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.accepted }}社</span>
        </p>
      </div>
    </div>
  </div>
</template>
