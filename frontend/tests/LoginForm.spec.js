import { shallowMount } from "@vue/test-utils"
import LoginForm from "../src/components/LoginForm.vue"
import { reactive, toRefs } from "vue"
import axios from "axios"

jest.mock("axios")

describe("正しくモックができる", () => {
  it("axiosをモックしてaxios.postを呼び出すと、ダミーの認証情報を返すように設定", async () => {
    const dummyResponse = {headers: {
      accessToken: 'dummyxxxtoken',
      client: 'dummyxxxclient',
      uid: 'dummyxxxemail',
    }}
    axios.post.mockResolvedValue(dummyResponse)
    const response = await axios.post()

    expect(response.headers.accessToken).toBe('dummyxxxtoken')
    expect(response.headers.client).toBe('dummyxxxclient')
    expect(response.headers.uid).toBe('dummyxxxemail')
  })
})

describe("初期状態のテスト", () => {
  it("メールアドレスが未入力である", () => {
    const wrapper = shallowMount(LoginForm)
    const emailInput = wrapper.get("#email").element.value

    expect(emailInput).toBe("")
  })

  it("パスワードが未入力である", () => {
    const wrapper = shallowMount(LoginForm)
    const passwordInput = wrapper.get("#password").element.value

    expect(passwordInput).toBe("")
  })
})

describe("フォームの入力テスト(v-model)", () => {
  it("変数`email`に「test@user.com」を入力すると、inputに「test@user.com」という値が入る",() => {
    const wrapper = shallowMount(LoginForm, {
      setup(){
        const userDatas = reactive({
          email: "test@user.com",
        })

        return { ...toRefs(userDatas) }
      },
    })

    const emailInput = wrapper.get("#email").element.value

    expect(emailInput).toBe("test@user.com")
  })

  it("変数`password`に「pass1234」を入力すると、inputに「pass1234」という値が入る",() => {
    const wrapper = shallowMount(LoginForm, {
      setup(){
        const userDatas = reactive({
          password: "pass1234",
        })

        return { ...toRefs(userDatas) }
      },
    })

    const passwordInput = wrapper.get("#password").element.value

    expect(passwordInput).toBe("pass1234")
  })
})