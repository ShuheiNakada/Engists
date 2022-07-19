<script setup>
import { reactive, toRefs } from 'vue'
import { useRouter } from 'vue-router'

const formDatas = reactive({
  category: 'initialValue',
  word1: 'initialValue',
  word2: 'initialValue',
  word3: 'initialValue',
  word4: 'initialValue',
  sort: 'initialValue',
})
const { category, word1, word2, word3, word4, sort } = toRefs(formDatas)

const router = useRouter()

const moveToSearchResult = () => {
  if (formDatas.sort == 'follower_number desc') {
    router.push({
      name: 'SearchResult',
      params: {
        model: 'user',
        category: formDatas.category,
        word1: formDatas.word1,
        word2: formDatas.word2,
        word3: formDatas.word3,
        word4: formDatas.word4,
        sort: formDatas.sort,
      },
    })
  } else {
    router.push({
      name: 'SearchResult',
      params: {
        model: 'profile',
        category: formDatas.category,
        word1: formDatas.word1,
        word2: formDatas.word2,
        word3: formDatas.word3,
        word4: formDatas.word4,
        sort: formDatas.sort,
      },
    })
  }
}
</script>

<template>
  <form @submit.prevent="moveToSearchResult">
    <div>
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70"
        for="status"
      >ステータス</label>
      <select
        id="status"
        v-model="word1"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500"
        name="status"
      >
        <option
          disabled
          value="initialValue"
        >
          選択してください
        </option>
        <option value="学習中">
          学習中
        </option>
        <option value="就職活動中">
          就職活動中
        </option>
        <option value="就職済み">
          就職済み
        </option>
        <option value="中止">
          中止
        </option>
      </select>
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70"
        for="starting_age"
      >年齢 (学習開始時)</label>
      <select
        id="starting_age"
        v-model="word2"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500"
        name="starting_age"
      >
        <option
          disabled
          value="initialValue"
        >
          選択してください
        </option>
        <option value="20-24歳">
          20-24歳
        </option>
        <option value="25-29歳">
          25-29歳
        </option>
        <option value="30-34歳">
          30-34歳
        </option>
        <option value="35-39歳">
          35-39歳
        </option>
        <option value="40-44歳">
          40-44歳
        </option>
        <option value="45-49歳">
          45-49歳
        </option>
        <option value="50-54歳">
          50-54歳
        </option>
        <option value="55-59歳">
          55-59歳
        </option>
        <option value="60-64歳">
          60-64歳
        </option>
      </select>
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/80"
        for="gender"
      >性別</label><br>
      <input
        id="gender"
        v-model="word3"
        class="ml-2"
        type="radio"
        name="gender"
        value="男性"
      ><span class="dark:text-teal-50 text-sm md:text-base lg:text-xl lg:ml-1">男性</span>
      <input
        id="gender"
        v-model="word3"
        class="ml-4"
        type="radio"
        name="gender"
        value="女性"
      ><span class="dark:text-teal-50 text-sm md:text-base lg:text-xl lg:ml-1">女性</span>
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70"
        for="residence"
      >居住地</label>
      <select
        id="residence"
        v-model="word4"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500"
        name="residence"
      >
        <option
          disabled
          value="initialValue"
        >
          選択してください
        </option>
        <option value="北海道">
          北海道
        </option>
        <option value="青森県">
          青森県
        </option>
        <option value="岩手県">
          岩手県
        </option>
        <option value="宮城県">
          宮城県
        </option>
        <option value="秋田県">
          秋田県
        </option>
        <option value="山形県">
          山形県
        </option>
        <option value="福島県">
          福島県
        </option>
        <option value="茨城県">
          茨城県
        </option>
        <option value="栃木県">
          栃木県
        </option>
        <option value="群馬県">
          群馬県
        </option>
        <option value="埼玉県">
          埼玉県
        </option>
        <option value="千葉県">
          千葉県
        </option>
        <option value="東京都">
          東京都
        </option>
        <option value="神奈川県">
          神奈川県
        </option>
        <option value="新潟県">
          新潟県
        </option>
        <option value="富山県">
          富山県
        </option>
        <option value="石川県">
          石川県
        </option>
        <option value="福井県">
          福井県
        </option>
        <option value="山梨県">
          山梨県
        </option>
        <option value="長野県">
          長野県
        </option>
        <option value="岐阜県">
          岐阜県
        </option>
        <option value="静岡県">
          静岡県
        </option>
        <option value="愛知県">
          愛知県
        </option>
        <option value="三重県">
          三重県
        </option>
        <option value="滋賀県">
          滋賀県
        </option>
        <option value="京都府">
          京都府
        </option>
        <option value="大阪府">
          大阪府
        </option>
        <option value="兵庫県">
          兵庫県
        </option>
        <option value="奈良県">
          奈良県
        </option>
        <option value="和歌山県">
          和歌山県
        </option>
        <option value="鳥取県">
          鳥取県
        </option>
        <option value="島根県">
          島根県
        </option>
        <option value="岡山県">
          岡山県
        </option>
        <option value="広島県">
          広島県
        </option>
        <option value="山口県">
          山口県
        </option>
        <option value="徳島県">
          徳島県
        </option>
        <option value="香川県">
          香川県
        </option>
        <option value="愛媛県">
          愛媛県
        </option>
        <option value="高知県">
          高知県
        </option>
        <option value="福岡県">
          福岡県
        </option>
        <option value="佐賀県">
          佐賀県
        </option>
        <option value="長崎県">
          長崎県
        </option>
        <option value="熊本県">
          熊本県
        </option>
        <option value="大分県">
          大分県
        </option>
        <option value="宮崎県">
          宮崎県
        </option>
        <option value="鹿児島県">
          鹿児島県
        </option>
        <option value="沖縄県">
          沖縄県
        </option>
      </select>
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70"
        for="category"
      >検索方法</label><br>
      <input
        id="category"
        v-model="category"
        class="ml-2"
        type="radio"
        name="category"
        value="basic_perfect"
      ><span class="dark:text-teal-50 text-sm md:text-base lg:text-xl lg:ml-1">全一致</span>
      <input
        id="category"
        v-model="category"
        class="ml-4"
        type="radio"
        name="category"
        value="basic_partial"
      ><span class="dark:text-teal-50 text-sm md:text-base lg:text-xl lg:ml-1">部分一致</span>
    </div>
    <div class="mt-2 lg:mt-4">
      <label
        class="text-xs md:text-sm lg:text-lg dark:text-teal-50/70"
        for="sort"
      >並び順</label>
      <select
        id="sort"
        v-model="sort"
        class="w-full rounded block text-sm md:text-base lg:text-xl p-1 lg:p-4 dark:text-teal-50 dark:bg-teal-100/20 dark:focus:outline-teal-500"
        name="sort"
      >
        <option
          disabled
          value="initialValue"
        >
          選択してください
        </option>
        <option value="created_at desc">
          作成日が新しい
        </option>
        <option value="updated_at desc">
          更新日が新しい
        </option>
        <option value="follower_number desc">
          フォロワーが多い
        </option>
      </select>
    </div>
    <div class="text-center mt-6 lg:mt-10">
      <button
        class="w-full max-w-xs text-emerald-50 dark:bg-emerald-500 dark:hover:bg-emerald-600 dark:active:bg-emerald-700 bg-emerald-500 hover:bg-emerald-400 active:bg-emerald-300 font-bold uppercase text-xs md:text-sm lg:text-lg px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-noneease-linear transition-all duration-150"
      >
        検索する
      </button>
    </div>
  </form>
</template>
