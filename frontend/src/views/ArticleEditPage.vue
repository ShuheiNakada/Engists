<script setup>
import axios from 'axios'
import ArticleEditForm from '../components/ArticleEditForm.vue'
import VuexStore from '../components/VuexStore.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}
</script>

<template>
  <ArticleEditForm />
  <VuexStore />
</template>
