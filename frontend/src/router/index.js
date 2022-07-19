import { createRouter, createWebHistory } from 'vue-router'
import useValidate from '../methods/validate'
import Welcome from '../views/WelcomePage.vue'
import Home from '../views/HomePage.vue'
import Post from '../views/PostPage.vue'
import Search from '../views/SearchPage.vue'
import SearchResult from '../views/SearchResultPage.vue'
import SearchResultByTag from '../views/SearchResultByTagPage.vue'
import User from '../views/UserPage.vue'
import MyProfile from '../views/MyProfilePage.vue'
import FollowUsers from '../views/FollowUsersPage.vue'
import Article from '../views/ArticlePage.vue'
import MyArticles from '../views/MyArticlesPage.vue'
import LikeArticles from '../views/LikeArticlesPage.vue'
import UserProfileEdit from '../views/UserProfileEditPage.vue'
import UserCoreEdit from '../views/UserCoreEditPage.vue'
import ArticleEdit from '../views/ArticleEditPage.vue'
import DirectMessageRoom from '../views/DirectMessageRoomPage.vue'
import DirectMessageIndex from '../views/DirectMessageIndexPage.vue'
import Notification from '../views/NotificationPage.vue'

// 未ログイン/サインアップのユーザーは認証させる
const { authError, validate } = useValidate()

const requireAuth = async(to, from, next) => {
  const uid = window.localStorage.getItem('uid')
  const client = window.localStorage.getItem('client')
  const accessToken = window.localStorage.getItem('access-token')
  
  if(!uid || !client || !accessToken){
    console.log('認証情報なし')
    alert('認証失敗: ログインまたはサインアップしてください')
    next({name: 'Welcome'})
    return
  }

  await validate()

  if(authError.value){
    console.log('認証失敗')
    alert('認証失敗: ログインまたはサインアップしてください')
    next({name: 'Welcome'})
  }else{
    console.log('認証成功')
    next()
  }
}

// 認証済みのユーザーはTopページに遷移させる
const noRequireAuth = async(to, from, next) => {
  const uid = window.localStorage.getItem('uid')
  const client = window.localStorage.getItem('client')
  const accessToken = window.localStorage.getItem('access-token')

  if(!uid && !client && !accessToken){
    next()
    return
  }

  await validate()

  if(!authError.value){
    next({name: 'Home'})
  }else{
    next()
  }
}

const routes = [
  {
    path: '/',
    name: 'Welcome',
    component: Welcome,
    beforeEnter: noRequireAuth
  },
  {
    path: '/home',
    name: 'Home',
    component: Home,
    beforeEnter: requireAuth
  },
  {
    path: '/post',
    name: 'Post',
    component: Post,
    beforeEnter: requireAuth
  },
  {
    path: '/search',
    name: 'Search',
    component: Search,
    beforeEnter: requireAuth
  },
  {
    path: '/search/tag/result',
    name: 'SearchResultByTag',
    component: SearchResultByTag,
    beforeEnter: requireAuth
  },
  {
    path: '/search/result',
    name: 'SearchResult',
    component: SearchResult,
    props: route => ({
      model: route.params.model,
      category: route.params.category,
      word1: route.params.word1,
      word2: route.params.word2,
      word3: route.params.word3,
      word4: route.params.word4,
      sort: route.params.sort,
    }),
    beforeEnter: requireAuth
  },
  {
    path: '/users/:id',
    name: 'User',
    component: User,
    beforeEnter: requireAuth
  },
  {
    path: '/users/:id/edit',
    name: 'UserCoreEdit',
    component: UserCoreEdit,
    beforeEnter: requireAuth
  },
  {
    path: '/articles/:id',
    name: 'Article',
    component: Article,
    beforeEnter: requireAuth
  },
  {
    path: '/articles/:id/edit',
    name: 'ArticleEdit',
    component: ArticleEdit,
    beforeEnter: requireAuth
  },
  {
    path: '/myprofile/:id',
    name: 'MyProfile',
    component: MyProfile,
    beforeEnter: requireAuth
  },
  {
    path: '/follow/users/:id',
    name: 'FollowUsers',
    component: FollowUsers,
    beforeEnter: requireAuth
  },
  {
    path: '/myarticles',
    name: 'MyArticles',
    component: MyArticles,
    beforeEnter: requireAuth
  },
  {
    path: '/like/articles',
    name: 'LikeArticles',
    component: LikeArticles,
    beforeEnter: requireAuth
  },
  {
    path: '/mypages/:id/edit',
    name: 'UserProfileEdit',
    component: UserProfileEdit,
    beforeEnter: requireAuth
  },
  {
    path: '/rooms/:id',
    name: 'DirectMessageRoom',
    component: DirectMessageRoom,
    beforeEnter: requireAuth
  },
  {
    path: '/rooms/index',
    name: 'DirectMessageIndex',
    component: DirectMessageIndex,
    beforeEnter: requireAuth
  },
  {
    path: '/notifications',
    name: 'Notification',
    component: Notification,
    beforeEnter: requireAuth
  },
]

const scrollBehavior = (to, from, savedPosition) => {
  if(savedPosition){
    return savedPosition
  }else{
    return{ top: 0 }
  }
}

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior,
})

export default router