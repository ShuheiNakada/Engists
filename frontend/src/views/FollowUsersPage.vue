<script setup>
import axios from 'axios'
import VuexStore from '../components/VuexStore.vue'
import FollowUsersList from '../components/FollowUsersList.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}
</script>

<template>
  <VuexStore />
  <FollowUsersList />
</template>
