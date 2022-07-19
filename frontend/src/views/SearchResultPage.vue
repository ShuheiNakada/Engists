<script setup>
import SearchProfileResult from '../components/SearchProfileResult.vue'
import SearchArticleResult from '../components/SearchArticleResult.vue'
import { reactive } from 'vue'
import VuexStore from '../components/VuexStore.vue'

const props = defineProps({
  model: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  category: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  word1: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  word2: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  word3: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  word4: {
    type: String,
    required: false,
    default: 'initialValue',
  },
  sort: {
    type: String,
    required: false,
    default: 'initialValue',
  },
})

const search = reactive({
  words: [],
  setItems: [],
  conditions: [],
  jsonParse: [],
})

if (
  props.model == 'initialValue' &&
  props.category == 'initialValue' &&
  props.sort == 'initialValue'
) {
  search.conditions = localStorage.getItem('search-conditions')
  search.jsonParse = JSON.parse(search.conditions)
} else {
  search.words = {
    model: props.model,
    category: props.category,
    word1: props.word1,
    word2: props.word2,
    word3: props.word3,
    word4: props.word4,
    sort: props.sort,
  }
  search.setItems = JSON.stringify(search.words)
  localStorage.setItem('search-conditions', search.setItems)

  search.conditions = localStorage.getItem('search-conditions')
  search.jsonParse = JSON.parse(search.conditions)
}

const formDatas = reactive({
  model: search.jsonParse.model,
  category: search.jsonParse.category,
  word1: search.jsonParse.word1,
  word2: search.jsonParse.word2,
  word3: search.jsonParse.word3,
  word4: search.jsonParse.word4,
  sort: search.jsonParse.sort,
})

const showTarget = reactive({
  profile: '',
  article: '',
})

if (formDatas.model == 'profile' || formDatas.model == 'user') {
  showTarget.profile = true
} else if (formDatas.model == 'article') {
  showTarget.article = true
}
</script>

<template>
  <VuexStore />
  <div v-if="showTarget.profile == true">
    <SearchProfileResult :search-conditions="formDatas" />
  </div>
  <div v-else-if="showTarget.article == true">
    <SearchArticleResult :search-conditions="formDatas" />
  </div>
</template>
