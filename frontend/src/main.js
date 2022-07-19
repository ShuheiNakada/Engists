import { createApp } from 'vue'
import App from './App.vue'
import './assets/index.css'
import router from './router'
import store from './store'
import axios from 'axios'

if(import.meta.env.DEV){
  axios.defaults.baseURL = "http://localhost:80";
}else if(import.meta.env.PROD){
  axios.defaults.baseURL = "https://engists.com";
}

createApp(App).use(store).use(router).mount('#app')
