<script setup>
import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue'
import { Icon } from '@iconify/vue'
import { reactive, computed } from 'vue'
import { useStore } from 'vuex'

const user = reactive({
  id: localStorage.getItem('user-id'),
})

const iconSize = reactive({
  width: '24',
  height: '24',
})
if (window.innerWidth >= 768) {
  iconSize.width = '24'
  iconSize.height = '24'
}
if (window.innerWidth >= 1024) {
  iconSize.width = '36'
  iconSize.height = '36'
}

const store = useStore()

const userInfo = computed(() => {
  console.log('Vuexストアから認証情報を取得する')
  return store.getters['auth/userInfo']
})
</script>

<template>
  <div class="text-right">
    <Menu
      as="div"
      class="relative inline-block text-left"
    >
      <div>
        <MenuButton
          class="inline-flex justify-center w-full px-2 py-1 md:px-4 md:py-2 lg:px-8 lg:py-4 text-sm font-medium text-teal-50 bg-black rounded-md dark:bg-opacity-20 bg-opacity-60 hover:bg-opacity-30 focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75"
        >
          <div v-if="!userInfo.iconPath">
            <Icon
              icon="carbon:user-avatar-filled"
              :width="iconSize.width"
              :height="iconSize.height"
            />
          </div>
          <div v-else>
            <img
              :src="userInfo.iconPath"
              class="object-cover w-8 h-8 md:w-10 md:h-10 lg:w-12 lg:h-12 m-auto rounded-full"
            >
          </div>
          <Icon icon="gridicons:dropdown" />
        </MenuButton>
      </div>

      <transition
        enter-active-class="transition duration-100 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <MenuItems
          class="absolute right-0 w-44 lg:w-80 mt-2 origin-top-right bg-teal-50 divide-y divide-teal-500/30 rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
        >
          <div class="p-1 lg:p-4">
            <MenuItem v-slot="{ active }">
              <router-link :to="`/myprofile/${user.id}`">
                <button
                  :class="[
                    active ? 'bg-teal-500 text-teal-50' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <Icon
                    icon="carbon:user-profile-alt"
                    :active="active"
                    :width="iconSize.width"
                    :height="iconSize.height"
                    class="text-teal-700"
                    aria-hidden="true"
                  />
                  <span class="text-xs lg:text-lg lg:ml-4">プロフィール</span>
                </button>
              </router-link>
            </MenuItem>
            <MenuItem v-slot="{ active }">
              <router-link :to="`/follow/users/${user.id}`">
                <button
                  :class="[
                    active ? 'bg-teal-500 text-teal-50' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <Icon
                    icon="clarity:users-line"
                    :active="active"
                    :width="iconSize.width"
                    :height="iconSize.height"
                    class="text-teal-700"
                    aria-hidden="true"
                  />
                  <span class="text-xs lg:text-lg lg:ml-4">フォローしたユーザー</span>
                </button>
              </router-link>
            </MenuItem>
          </div>
          <div class="px-1 py-1 lg:px-4 lg:py-4">
            <MenuItem v-slot="{ active }">
              <router-link to="/myarticles">
                <button
                  :class="[
                    active ? 'bg-teal-500 text-teal-50' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <Icon
                    icon="ri:article-fill"
                    :active="active"
                    :width="iconSize.width"
                    :height="iconSize.height"
                    class="text-teal-700"
                    aria-hidden="true"
                  />
                  <span class="text-xs lg:text-lg lg:ml-4">投稿した記事</span>
                </button>
              </router-link>
            </MenuItem>
            <MenuItem v-slot="{ active }">
              <router-link to="/like/articles">
                <button
                  :class="[
                    active ? 'bg-teal-500 text-teal-50' : 'text-gray-900',
                    'group flex rounded-md items-center w-full px-2 py-2 text-sm',
                  ]"
                >
                  <Icon
                    icon="ant-design:like-filled"
                    :active="active"
                    :width="iconSize.width"
                    :height="iconSize.height"
                    class="text-teal-700"
                    aria-hidden="true"
                  />
                  <span class="text-xs lg:text-lg lg:ml-4">いいねした記事</span>
                </button>
              </router-link>
            </MenuItem>
          </div>
        </MenuItems>
      </transition>
    </Menu>
  </div>
</template>
