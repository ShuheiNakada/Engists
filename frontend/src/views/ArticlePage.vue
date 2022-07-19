<script setup>
import ArticleDetail from '../components/ArticleDetail.vue'
import axios from 'axios'
import VuexStore from '../components/VuexStore.vue'
import ArticleCommentList from '../components/ArticleCommentList.vue'
import ArticleCommentForm from '../components/ArticleCommentForm.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}
</script>

<template>
  <VuexStore />
  <ArticleDetail />
  <ArticleCommentList />
  <ArticleCommentForm />
</template>
