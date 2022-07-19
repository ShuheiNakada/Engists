import axios from 'axios'

axios.defaults.headers.common = {
  uid: window.localStorage.getItem('uid'),
  'access-token': window.localStorage.getItem('access-token'),
  client: window.localStorage.getItem('client'),
}

const state = {
  userDatas: [],
}

const getters = {
  userInfo: state => state.userDatas,
}

const mutations = {
  setDatas: (state, responseDatas) => (state.userDatas = {
    userId: responseDatas.user.id,
    login: responseDatas.user.login,
    iconPath: responseDatas.user.icon_path,
    profileExist: responseDatas.profile_exist,
  }),
  deleteDatas: (state) => (state.userDatas = ''),
}

const actions = {
  async getDatas({commit}){
    const response = await axios.get('api/my_profile')
    localStorage.setItem('user-id', response.data.user.id)
    commit('setDatas', response.data)
    console.log('ユーザー認証情報の取得をactionsで実行')
    console.log({response})
  },
  deleteDatas({commit}){
    commit('deleteDatas')
    console.log('ユーザー認証情報の削除をactionsで実行')
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