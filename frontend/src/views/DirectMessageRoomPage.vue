<script setup>
import axios from 'axios'
import VuexStore from '../components/VuexStore.vue'
import DirectMessageList from '../components/DirectMessageList.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}
</script>

<template>
  <VuexStore />
  <DirectMessageList />
</template>
