<script setup>
import axios from 'axios'
import { reactive } from 'vue'
import { useRouter } from 'vue-router'

const user = reactive({
  initialValue: [],
  id: localStorage.getItem('user-id'),
})

axios
  .get(`/api/users/${user.id}`)
  .then((response) => {
    console.log('ユーザー情報を取得成功')
    console.log({ response })
    user.initialValue = response.data.user_profile
  })
  .catch((error) => {
    console.log('ユーザー情報を取得失敗')
    console.log({ error })
  })

const router = useRouter()

const editProfile = (profileId) => {
  axios
    .put(`/api/profiles/${profileId}`, {
      status: user.initialValue.status,
      starting_age: user.initialValue.startingAge,
      birth: user.initialValue.birth,
      residence: user.initialValue.residence,
      gender: user.initialValue.gender,
      introduction: user.initialValue.introduction,
      hobby: user.initialValue.hobby,
      github: user.initialValue.github,
      twitter: user.initialValue.twitter,
      qiita: user.initialValue.qiita,
      wontedly: user.initialValue.wontedly,
      technology_used: user.initialValue.technology_used,
      study_period: user.initialValue.study_period,
      study_method: user.initialValue.study_method,
      teaching_materials: user.initialValue.teaching_materials,
      corporate_form: user.initialValue.corporate_form,
      company_size: user.initialValue.company_size,
      annual_income: user.initialValue.annual_income,
      entry: user.initialValue.entry,
      meet: user.initialValue.meet,
      accepted: user.initialValue.accepted,
    })
    .then((response) => {
      console.log('プロフィール更新成功')
      console.log({ response })
      router.push({ name: 'MyProfile', params: { successMessage: 'プロフィール更新しました' } })
    })
    .catch((error) => {
      console.log('プロフィール更新失敗')
      console.log({ error })
    })
}
</script>

<template>
  <form
    class="m-4 p-4"
    @submit.prevent="editProfile(user.initialValue.profile_id)"
  >
    <div>
      <h2 class="p-2 text-center text-lg w-full rounded">
        プロフィール編集フォーム
        <span class="block text-base">(変更する項目のみは操作してください)</span>
      </h2>
      <div class="mt-2 p-4 border rounded-lg dark:border-teal-50 border-teal-900">
        <div>
          <label for="status">ステータス</label>
          <select
            id="status"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="status"
            :value="user.initialValue.status"
            @input="user.initialValue.status = $event.target.value"
          >
            <option>学習中</option>
            <option>就職活動中</option>
            <option>就職済み</option>
            <option>中止</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="starting_age">開始年齢</label>
          <select
            id="starting_age"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="starting_age"
            :value="user.initialValue.starting_age"
            @input="user.initialValue.starting_age = $event.target.value"
          >
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
          <label for="birth">生年月日</label><span class="ml-4 text-sm dark:text-teal-50/80">(例)1980-01-01</span>
          <input
            id="birth"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.birth"
            @input="user.initialValue.birth = $event.target.value"
          >
        </div>
        <div>
          <label for="status">ステータス</label>
          <select
            id="status"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="status"
            :value="user.initialValue.gender"
            @input="user.initialValue.gender = $event.target.value"
          >
            <option>男性</option>
            <option>女性</option>
          </select>
        </div>
        <div class="mt-4">
          <label for="residence">居住地</label>
          <select
            id="residence"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="residence"
            :value="user.initialValue.residence"
            @input="user.initialValue.residence = $event.target.value"
          >
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
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full whitespace-pre-line h-60"
            name="introduction"
            :value="user.initialValue.introduction"
            @input="user.initialValue.introduction = $event.target.value"
          />
        </div>
        <div class="mt-4">
          <label for="hobby">趣味</label>
          <input
            id="hobby"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.hobby"
            @input="user.initialValue.hobby = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="github">GitHub</label>
          <input
            id="github"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="url"
            :value="user.initialValue.github"
            @input="user.initialValue.github = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="twitter">Twitter</label>
          <input
            id="twitter"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="url"
            :value="user.initialValue.twitter"
            @input="user.initialValue.twitter = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="qiita">Qiita</label>
          <input
            id="qiita"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="url"
            :value="user.initialValue.qiita"
            @input="user.initialValue.qiita = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="wontedly">Wontedly</label>
          <input
            id="wontedly"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="url"
            :value="user.initialValue.wontedly"
            @input="user.initialValue.wontedly = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="technology_used">ポートフォリオ使用技術</label>
          <input
            id="technology_used"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.technology_used"
            @input="user.initialValue.technology_used = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="study_period">学習期間 (単位: 月)</label>
          <input
            id="study_period"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.study_period"
            @input="user.initialValue.study_period = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="study_method">学習方法 </label>
          <select
            id="study_method"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="study_method"
            :value="user.initialValue.study_method"
            @input="user.initialValue.study_method = $event.target.value"
          >
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
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.teaching_materials"
            @input="user.initialValue.teaching_materials = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="corporate_form">会社形態 </label>
          <select
            id="corporate_form"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="corporate_form"
            :value="user.initialValue.corporate_form"
            @input="user.initialValue.corporate_form = $event.target.value"
          >
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
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="company_size"
            :value="user.initialValue.company_size"
            @input="user.initialValue.company_size = $event.target.value"
          >
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
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            name="annual_income"
            :value="user.initialValue.annual_income"
            @input="user.initialValue.annual_income = $event.target.value"
          >
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
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.entry"
            @input="user.initialValue.entry = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="meet">面接企業数</label>
          <input
            id="meet"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.meet"
            @input="user.initialValue.meet = $event.target.value"
          >
        </div>
        <div class="mt-4">
          <label for="accepted">内定企業数</label>
          <input
            id="accepted"
            class="py-1 px-4 border rounded dark:bg-teal-100/20 dark:border-none dark:text-teal-50 dark:focus:outline-teal-500 bg-white border-teal-400 text-teal-900 focus:outline-teal-500 w-full"
            type="text"
            :value="user.initialValue.accepted"
            @input="user.initialValue.accepted = $event.target.value"
          >
          <p class="text-center mt-8">
            <button
              class="w-full max-w-xs py-4 text-white bg-emerald-500 hover:bg-emerald-600 active:bg-emerald-700 text-xs rounded shadow hover:shadow-md outline-none focus:outline-none ease-linear transition-all duration-150"
            >
              更新する
            </button>
          </p>
        </div>
      </div>
    </div>
  </form>
</template>
