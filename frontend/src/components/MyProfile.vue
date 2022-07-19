<script setup>
import { reactive, toRefs } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'
import dayjs from 'dayjs'
import ja from 'dayjs/locale/ja'
import { Icon } from '@iconify/vue'

dayjs.locale(ja)

// ユーザー情報の取得
const user = reactive({
  baseDatas: [],
  profileDatas: [],
  name: localStorage.getItem('name'),
  email: localStorage.getItem('uid'),
  id: localStorage.getItem('user-id'),
})
const { baseDatas, profileDatas } = toRefs(user)

const route = useRoute()

axios
  .get(`/api/users/${route.params.id}`)
  .then((response) => {
    console.log('自分のプロフィール情報を取得成功')
    console.log({ response })
    user.baseDatas = response.data.user_base
    user.profileDatas = response.data.user_profile
    const today = dayjs()
    const birthday = dayjs(user.profileDatas.birth)
    user.profileDatas.age = today.diff(birthday, 'year')
    if (window.localStorage.uid == 'test@user.com') {
      testUser.state = true
      console.log('テストユーザーであることを認識する')
    } else if (window.localStorage.uid == response.data.user_base.email) {
      correctUser.state = true
      console.log('正しいユーザーであることを認識する')
    } else {
      console.log('他ユーザーのプロフィールにアクセス中...')
    }
  })
  .catch((error) => {
    console.log('自分のプロフィール情報を取得失敗')
    console.log({ error })
  })

const testUser = reactive({
  state: '',
})
const correctUser = reactive({
  state: '',
})
</script>

<template>
  <div
    v-if="$route.params.successMessage || $route.query.successMessage"
    class="p-2 lg:p-4 w-full text-center bg-teal-100/20"
  >
    {{ $route.params.successMessage }}
    {{ $route.query.successMessage }}
  </div>

  <div class="m-4 lg:m-8">
    <h2 class="text-lg lg:text-2xl md:text-xl mb-2 text-center font-bold">
      プロフィール
    </h2>
    <div class="rounded p-4 lg:p-8 border border-teal-500/80 dark:bg-teal-800 dark:border-none">
      <p
        class="text-sm md:text-lg lg:text-2xl underline decoration-4 decoration-teal-500 underline-offset-1"
      >
        ユーザー情報
      </p>
      <div
        class="flex space-x-4 md:space-x-12 lg:space-x-20 items-center mt-2 pl-2 lg:mt-4 lg:pl-4"
      >
        <div>
          <div
            v-if="!baseDatas.icon_name"
            class="flex flex-col items-center mt-2 md:mt-4 space-x-2 md:space-x-4"
          >
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80 my-auto">
              アイコン
            </p>
            <div class="flex flex-col items-center">
              <Icon
                icon="bxs:user"
                class="object-cover w-12 h-12 md:w-24 md:h-24 lg:w-36 lg:h-36 rounded-full"
              />
              <span class="text-xs md:text-base lg:text-xl">(デフォルト)</span>
            </div>
          </div>
          <div
            v-else
            class="flex flex-col items-center mt-2 md:mt-4"
          >
            <img
              :src="baseDatas.icon_path"
              class="object-cover w-12 h-12 md:w-24 md:h-24 lg:w-36 lg:h-36 rounded-full"
            >
            <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
              アイコン
            </p>
          </div>
        </div>
        <div>
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            ユーザー名<span
              class="ml-2 md:ml-8 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >{{ user.name }}</span>
          </p>
          <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
            メールアドレス<span
              class="ml-2 md:ml-8 lg:ml-6 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
            >{{ user.email }}</span>
          </p>
        </div>
      </div>
      <div class="mt-4 lg:mt-8">
        <div v-if="testUser.state == true">
          <p class="dark:bg-stone-900 bg-stone-200 rounded-full text-center lg:text-xl lg:p-2">
            テストユーザーは編集できません
          </p>
        </div>
        <div
          v-else-if="user.id == route.params.id"
          class="text-center"
        >
          <router-link
            class="text-emerald-50 font-bold text-xs md:text-sm lg:text-lg px-4 py-2 lg:px-8 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
            :to="`/users/${baseDatas.id}/edit`"
          >
            <button class="mt-8 lg:mt-10 w-20 md:w-40 lg:w-60">
              編集する
            </button>
          </router-link>
        </div>
      </div>
    </div>

    <div
      class="mt-4 p-4 lg:mt-8 lg:p-8 border rounded border-teal-500/80 dark:bg-teal-800 dark:border-none"
    >
      <h2
        class="text-sm md:text-lg lg:text-2xl underline decoration-4 decoration-teal-500 underline-offset-1"
      >
        基本情報
      </h2>
      <div class="mt-2 pl-2 lg:mt-4 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          ステータス<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.status
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          年齢(学習開始時)<span
            class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.starting_age }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          現在の年齢<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.age }}歳</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          性別<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.gender
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          居住地<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.residence
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          趣味<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.hobby
          }}</span>
        </p>
        <div class="text-xs md:text-sm lg:text-lg mt-2 dark:text-teal-50/80">
          自己紹介文
          <p
            v-if="profileDatas.introduction"
            class="p-2 mt-1 lg:p-4 lg:mt-2 rounded dark:text-teal-50 text-xs md:text-sm lg:text-lg whitespace-pre-line dark:bg-teal-700 bg-teal-200/50"
          >
            {{ profileDatas.introduction }}
          </p>
        </div>
      </div>
      <h2
        class="mt-6 text-sm md:text-lg lg:text-2xl underline decoration-4 decoration-teal-500 underline-offset-1"
      >
        各種リンク
      </h2>
      <div class="mt-2 px-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          GitHub
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-8 lg:ml-12 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.github }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Twitter
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-8 lg:ml-12 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.twitter }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Qiita
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-8 lg:ml-12 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.qiita }}
          </a>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          Wontedly
          <a
            :href="profileDatas.github"
            class="ml-2 md:ml-8 lg:ml-12 text-sm md:text-lg lg:text-2xl underline hover:text-teal-500 active:text-teal-600"
          >
            {{ profileDatas.wontedly }}
          </a>
        </p>
      </div>
      <h2
        class="mt-6 text-sm md:text-lg lg:text-2xl underline decoration-4 decoration-teal-500 underline-offset-1"
      >
        ポートフォリオ
      </h2>
      <div class="mt-2 pl-2 lg:mt-4 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          使用技術<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.technology_used
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          学習期間<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.study_period }}ヶ月</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          勉強方法<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.study_method
          }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          参考教材<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{
            profileDatas.teaching_materials
          }}</span>
        </p>
      </div>
      <h2
        class="mt-6 text-sm md:text-lg lg:text-2xl underline decoration-4 decoration-teal-500 underline-offset-1"
      >
        就職活動
      </h2>
      <div class="mt-2 pl-2 lg:mt-4 lg:pl-4">
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          転職先の企業形態<span
            class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl"
          >{{ profileDatas.corporate_form }}</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          企業規模<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">従業員 {{ profileDatas.company_size }} 名</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          年収<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.annual_income }}万円</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          応募企業数<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.entry }}社</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          面接企業数<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.meet }}社</span>
        </p>
        <p class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80">
          内定企業数<span class="ml-2 md:ml-8 dark:text-teal-50 text-sm md:text-lg lg:text-2xl">{{ profileDatas.accepted }}社</span>
        </p>
      </div>
      <div class="mt-4 lg:mt-8">
        <div v-if="testUser.state == true">
          <p class="dark:bg-stone-900 bg-stone-200 rounded-full text-center lg:text-lg lg:p-2">
            テストユーザーは編集できません
          </p>
        </div>
        <div
          v-else-if="correctUser.state == true"
          class="text-center"
        >
          <router-link
            class="text-emerald-50 font-bold text-xs lg:text-lg md:text-sm px-4 py-2 lg:px-8 lg:py-4 rounded bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700"
            :to="`/mypages/${baseDatas.id}/edit`"
          >
            <button class="mt-8 w-20 md:w-40 lg:w-60">
              編集する
            </button>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>
