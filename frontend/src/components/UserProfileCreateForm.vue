<script setup>
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const formDatas = reactive({
  status: '',
  startingAge: '',
  birth: '',
  residence: '',
  gender: '',
  introduction: '',
  hobby: '',
  github: '',
  twitter: '',
  qiita: '',
  wontedly: '',
  technology_used: '',
  study_period: '',
  study_method: '',
  teaching_materials: '',
  corporate_form: '',
  company_size: '',
  annual_income: '',
  entry: '',
  meet: '',
  accepted: '',
})
const {
  status,
  startingAge,
  birth,
  residence,
  gender,
  introduction,
  hobby,
  github,
  twitter,
  qiita,
  wontedly,
  technology_used,
  study_period,
  study_method,
  teaching_materials,
  corporate_form,
  company_size,
  annual_income,
  entry,
  meet,
  accepted,
} = toRefs(formDatas)

const responseMessage = reactive({
  error: '',
})

const router = useRouter()

const user = reactive({
  id: localStorage.getItem('user-id'),
})

const createProfile = () => {
  axios
    .post('/api/profiles', {
      status: formDatas.status,
      starting_age: formDatas.startingAge,
      birth: formDatas.birth,
      residence: formDatas.residence,
      gender: formDatas.gender,
      introduction: formDatas.introduction,
      hobby: formDatas.hobby,
      github: formDatas.github,
      twitter: formDatas.twitter,
      qiita: formDatas.qiita,
      wontedly: formDatas.wontedly,
      technology_used: formDatas.technology_used,
      study_period: formDatas.study_period,
      study_method: formDatas.study_method,
      teaching_materials: formDatas.teaching_materials,
      corporate_form: formDatas.corporate_form,
      company_size: formDatas.company_size,
      annual_income: formDatas.annual_income,
      entry: formDatas.entry,
      meet: formDatas.meet,
      accepted: formDatas.accepted,
    })
    .then((response) => {
      console.log('プロフィール登録成功')
      console.log({ response })
      router.push({
        path: `/myprofile/${user.id}`,
        query: { successMessage: 'プロフィール登録しました' },
      })
    })
    .catch((error) => {
      console.log('プロフィール登録失敗')
      console.log({ error })
      responseMessage.error = 'プロフィール登録が失敗しました'
    })
}

const selectTextColor = reactive({
  active: [
    'py-1',
    'px-4',
    'border',
    'rounded',
    'dark:bg-teal-100/20',
    'dark:border-none',
    'dark:text-teal-50',
    'dark:focus:outline-teal-500',
    'bg-white',
    'border-teal-400',
    'text-teal-900',
    'focus:outline-teal-500',
    'w-full',
  ],
  inactive: [
    'py-1',
    'px-4',
    'border',
    'rounded',
    'dark:bg-teal-100/20',
    'dark:border-none',
    'dark:text-teal-50/50',
    'dark:focus:outline-teal-500',
    'bg-white',
    'border-teal-400',
    'text-teal-900',
    'focus:outline-teal-500',
    'w-full',
  ],
})
</script>

<template>
  <form
    class="m-4 p-4"
    @submit.prevent="createProfile"
  >
    <div>
      <h2 class="p-2 text-center w-full rounded bg-red-500 dark:text-teal-50 text-white">
        以下項目を入力してください
      </h2>
      <div class="mt-2 p-4 border rounded-lg dark:border-teal-50 border-teal-900">
        <div>
          <label for="status">ステータス</label>
          <select
            id="status"
            v-model="status"
            :class="status == '' ? selectTextColor.inactive : selectTextColor.active"
            name="status"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>学習中</option>
            <option>就職活動中</option>
            <option>就職済み</option>
            <option>中止</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="starting_age">年齢 (学習開始時)</label>
          <select
            id="starting_age"
            v-model="startingAge"
            :class="startingAge == '' ? selectTextColor.inactive : selectTextColor.active"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>20-24歳</option>
            <option>25-29歳</option>
            <option>30-34歳</option>
            <option>35-39歳</option>
            <option>40-44歳</option>
            <option>45-49歳</option>
            <option>50-54歳</option>
            <option>55-59歳</option>
            <option>60-64歳</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="birth">生年月日</label>
          <input
            id="birth"
            v-model="birth"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="(例)1980-01-01"
          >
        </div>
        <div class="mt-4">
          <label for="gender">性別</label><br>
          <input
            id="gender"
            v-model="gender"
            class="ml-4"
            type="radio"
            name="gender"
            value="男性"
          >男性 <input
            id="gender"
            v-model="gender"
            type="radio"
            name="gender"
            value="女性"
          >女性
        </div>
        <div class="mt-4">
          <label for="residence">居住地</label>
          <select
            id="residence"
            v-model="residence"
            :class="residence == '' ? selectTextColor.inactive : selectTextColor.active"
            name="residence"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>北海道</option>
            <option>青森県</option>
            <option>岩手県</option>
            <option>宮城県</option>
            <option>秋田県</option>
            <option>山形県</option>
            <option>福島県</option>
            <option>茨城県</option>
            <option>栃木県</option>
            <option>群馬県</option>
            <option>埼玉県</option>
            <option>千葉県</option>
            <option>東京都</option>
            <option>神奈川県</option>
            <option>新潟県</option>
            <option>富山県</option>
            <option>石川県</option>
            <option>福井県</option>
            <option>山梨県</option>
            <option>長野県</option>
            <option>岐阜県</option>
            <option>静岡県</option>
            <option>愛知県</option>
            <option>三重県</option>
            <option>滋賀県</option>
            <option>京都府</option>
            <option>大阪府</option>
            <option>兵庫県</option>
            <option>奈良県</option>
            <option>和歌山県</option>
            <option>鳥取県</option>
            <option>島根県</option>
            <option>岡山県</option>
            <option>広島県</option>
            <option>山口県</option>
            <option>徳島県</option>
            <option>香川県</option>
            <option>愛媛県</option>
            <option>高知県</option>
            <option>福岡県</option>
            <option>佐賀県</option>
            <option>長崎県</option>
            <option>熊本県</option>
            <option>大分県</option>
            <option>宮崎県</option>
            <option>鹿児島県</option>
            <option>沖縄県</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="introduction">紹介文</label>
          <textarea
            id="introduction"
            v-model="introduction"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            name="introduction"
            cols="30"
            rows="5"
            placeholder="入力してください"
          />
        </div>
        <div class="mt-4">
          <label for="hobby">趣味</label>
          <input
            id="hobby"
            v-model="hobby"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="github">GitHub</label>
          <input
            id="github"
            v-model="github"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="url"
            placeholder="URLを入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="twitter">Twitter</label>
          <input
            id="twitter"
            v-model="twitter"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50 dark:placeholder:text-teal-50"
            type="url"
            placeholder="URLを入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="qiita">Qiita</label>
          <input
            id="qiita"
            v-model="qiita"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="url"
            placeholder="URLを入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="wontedly">Wontedly</label>
          <input
            id="wontedly"
            v-model="wontedly"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="url"
            placeholder="URLを入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="technology_used">ポートフォリオ使用技術</label>
          <input
            id="technology_used"
            v-model="technology_used"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="study_period">学習期間(月)</label>
          <input
            id="study_period"
            v-model="study_period"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="半角数字を入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="study_method">学習方法 </label>
          <select
            id="study_method"
            v-model="study_method"
            :class="study_method == '' ? selectTextColor.inactive : selectTextColor.active"
            name="study_method"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>独学</option>
            <option>プログラミングスクール</option>
            <option>メンター契約</option>
            <option>職業訓練校</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="teaching_materials">参考教材</label>
          <input
            id="teaching_materials"
            v-model="teaching_materials"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="corporate_form">会社形態 </label>
          <select
            id="corporate_form"
            v-model="corporate_form"
            :class="corporate_form == '' ? selectTextColor.inactive : selectTextColor.active"
            name="corporate_form"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>自社開発</option>
            <option>受託開発</option>
            <option>SES</option>
            <option>その他</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="company_size">会社規模(従業員数)</label>
          <select
            id="company_size"
            v-model="company_size"
            :class="company_size == '' ? selectTextColor.inactive : selectTextColor.active"
            name="company_size"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>10名以下</option>
            <option>11-30名</option>
            <option>31-50名</option>
            <option>51名以上</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="annual_income">年収 </label>
          <select
            id="annual_income"
            v-model="annual_income"
            :class="status == '' ? selectTextColor.inactive : selectTextColor.active"
            name="annual_income"
          >
            <option
              disabled
              value=""
            >
              選択してください
            </option>
            <option>299万円以下</option>
            <option>300-350万円</option>
            <option>351-400万円</option>
            <option>401-450万円</option>
            <option>451-500万円</option>
            <option>501万円以上</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="entry">エントリー企業数</label>
          <input
            id="entry"
            v-model="entry"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="半角数字で入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="meet">面接企業数</label>
          <input
            id="meet"
            v-model="meet"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="半角数字で入力してください"
          >
        </div>
        <div class="mt-4">
          <label for="accepted">内定企業数</label>
          <input
            id="accepted"
            v-model="accepted"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full dark:placeholder:text-teal-50/50"
            type="text"
            placeholder="半角数字で入力してください"
          >
          <p class="text-center mt-8">
            <button
              class="w-full max-w-xs py-4 text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-xs rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
            >
              登録する
            </button>
          </p>
        </div>
        <p>{{ responseMessage.error }}</p>
      </div>
    </div>
  </form>
</template>
