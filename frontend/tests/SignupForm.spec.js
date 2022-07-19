import { shallowMount } from "@vue/test-utils"
import SignupForm from "../src/components/SignupForm.vue"
import { reactive, toRefs } from 'vue'
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
  it("名前が未入力である", () => {
    const wrapper = shallowMount(SignupForm);
    const nameInput = wrapper.get("#name").element.value;

    expect(nameInput).toBe("");
  });

  it("メールアドレスが未入力である", () => {
    const wrapper = shallowMount(SignupForm);
    const emailInput = wrapper.get("#email").element.value;

    expect(emailInput).toBe("");
  });

  it("パスワードが未入力である", () => {
    const wrapper = shallowMount(SignupForm);
    const passwordInput = wrapper.get("#password").element.value;

    expect(passwordInput).toBe("");
  });

  it("再確認用のパスワードが未入力である", () => {
    const wrapper = shallowMount(SignupForm);
    const passwordConfirmationInput = wrapper.get("#passwordConfirmation").element.value;

    expect(passwordConfirmationInput).toBe("");
  });
})

describe("フォームの入力テスト(v-model)", () => {
  it("変数`name`に「Shuhei Nakada」を代入すると、inputに「Shuhei Nakada」という値が入る", () => {
    const wrapper = shallowMount(SignupForm, {
      setup(){
        const userDatas = reactive({
          name: "Shuhei Nakada",
        });

        return { ...toRefs(userDatas) }
      },
    });

    const nameInput = wrapper.get("#name").element.value

    expect(nameInput).toBe("Shuhei Nakada")
  })

  it("変数`email`に「engine@mail.com」を代入すると、inputに「engine@mail.com」という値が入る", () => {
    const wrapper = shallowMount(SignupForm, {
      setup(){
        const userDatas = reactive({
          email: "engine@mail.com",
        });

        return { ...toRefs(userDatas) }
      },
    });

    const emailInput = wrapper.get("#email").element.value

    expect(emailInput).toBe("engine@mail.com")
  })

  it("変数`password`に「pass1234」を代入すると、inputに「pass1234」という値が入る", () => {
    const wrapper = shallowMount(SignupForm, {
      setup(){
        const userDatas = reactive({
          password: "pass1234",
        });

        return { ...toRefs(userDatas) }
      },
    });

    const passwordInput = wrapper.get("#password").element.value

    expect(passwordInput).toBe("pass1234")
  })

  it("変数`passwordConfirmation`に「pass1234」を代入すると、inputに「pass1234」という値が入る", () => {
    const wrapper = shallowMount(SignupForm, {
      setup(){
        const userDatas = reactive({
          passwordConfirmation: "pass1234",
        });

        return { ...toRefs(userDatas) }
      },
    });

    const passwordConfirmationInput = wrapper.get("#passwordConfirmation").element.value

    expect(passwordConfirmationInput).toBe("pass1234")
  })
})