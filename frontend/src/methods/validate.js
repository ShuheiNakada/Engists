import axios from 'axios'
import { ref } from 'vue'
import removeItem from './removeItem'

const authError = ref(null)

const validate = () => {
  authError.value = null
  const uid = window.localStorage.getItem('uid')
  const client = window.localStorage.getItem('client')
  const accessToken = window.localStorage.getItem('access-token')

  axios.get('/auth/validate_token', {
    headers: {
      uid: uid,
      client: client,
      'access-token': accessToken
    }
  })
  .then(response => {
    console.log(response)
  })
  .catch(error => {
    console.log(error)
    authError.value = '認証に失敗しました'
    removeItem()
  })
}

const useValidate = () => {
  return { authError, validate }
}

export default useValidate