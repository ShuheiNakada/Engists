import axios from 'axios'
import _ from 'lodash';

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}

const state = {
  unread: [],
}

const getters = {
  unread: state => state.unread
}

const mutations = {
  setDatas: (state, unreadNotifications) => (state.unread = unreadNotifications),
  deleteDatas: (state) => (state.unread = ''),
}

const actions = {
  async getDatas({commit}){
    const response = await axios.get('api/notifications')
    const unreadNotifications = _.filter(response.data, notification => {
      return (notification.checked === false)
    })
    commit('setDatas', unreadNotifications)
    console.log('未読の通知情報の取得をactionsで実行')
    console.log({response})
  },
  deleteDatas({commit}){
    commit('deleteDatas')
    console.log('通知情報の削除をactionsで実行')
    localStorage.clear()
  },
}

export default{
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}