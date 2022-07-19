<script setup>
import axios from 'axios'
import VuexStore from '../components/VuexStore.vue'
import FollowUserRank from '../components/FollowUserRank.vue'
import LikeArticleRank from '../components/LikeArticleRank.vue'
import SearchFormSwitch from '../components/SearchFormSwitch.vue'
import DevelopmentNews from '../components/DevelopmentNews.vue'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}
</script>

<template>
  <div>
    <VuexStore />
    <DevelopmentNews />
    <SearchFormSwitch />
    <FollowUserRank />
    <LikeArticleRank />
  </div>
</template>
