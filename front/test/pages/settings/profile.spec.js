import Vuetify from 'vuetify'
import { createLocalVue, mount } from '@vue/test-utils'
import locales from '~/locales/ja.js'
import TwoColumnContainer from '~/components/molecules/containers/TwoColumnContainer.vue'
import TheLoading from '~/components/organisms/application/TheLoading.vue'
import TheMessage from '~/components/organisms/application/TheMessage.vue'
import SettingsMenusCard from '~/components/organisms/cards/settings/SettingsMenusCard.vue'
import SettingsProfileCard from '~/components/organisms/cards/settings/SettingsProfileCard.vue'
import Page from '~/pages/settings/profile.vue'

import { Helper } from '~/test/helper.js'
const helper = new Helper()

describe('profile.vue', () => {
  let authFetchUserMock, authRedirectMock, authLogoutMock, toastedErrorMock, toastedInfoMock, routerPushMock

  beforeEach(() => {
    authFetchUserMock = jest.fn()
    authRedirectMock = jest.fn()
    authLogoutMock = jest.fn()
    toastedErrorMock = jest.fn()
    toastedInfoMock = jest.fn()
    routerPushMock = jest.fn()
  })

  const mountFunction = (loggedIn, user) => {
    const localVue = createLocalVue()
    const vuetify = new Vuetify()
    const wrapper = mount(Page, {
      localVue,
      vuetify,
      stubs: {
        TwoColumnContainer: true,
        TheLoading: true,
        TheMessage: true,
        SettingsMenusCard: true,
        SettingsProfileCard: true
      },
      mocks: {
        $auth: {
          loggedIn,
          user: { ...user },
          fetchUser: authFetchUserMock,
          redirect: authRedirectMock,
          logout: authLogoutMock
        },
        $toasted: {
          error: toastedErrorMock,
          info: toastedInfoMock
        },
        $router: {
          push: routerPushMock
        }
      }
    })
    expect(wrapper.vm).toBeTruthy()
    return wrapper
  }

  const commonLoadingTest = (wrapper) => {
    // console.log(wrapper.html())
    expect(wrapper.findComponent(TheLoading).exists()).toBe(true)
  }
  const commonFetchUserCalledTest = (logoutCalled) => {
    expect(authFetchUserMock).toBeCalledTimes(1)
    expect(authLogoutMock).toBeCalledTimes(logoutCalled)
  }
  const commonViewTest = (wrapper) => {
    // console.log(wrapper.html())
    expect(wrapper.findComponent(TwoColumnContainer).exists()).toBe(true)
    expect(wrapper.findComponent(TheLoading).exists()).toBe(false)
    expect(wrapper.findComponent(TheMessage).exists()).toBe(true)
    expect(wrapper.findComponent(TheMessage).vm.$props.alert).toBe(null)
    expect(wrapper.findComponent(TheMessage).vm.$props.notice).toBe(null)
    expect(wrapper.findComponent(SettingsMenusCard).exists()).toBe(true)
    expect(wrapper.findComponent(SettingsProfileCard).exists()).toBe(true)
  }
  const commonToastedTest = (alert, notice) => {
    expect(toastedErrorMock).toBeCalledTimes(alert !== null ? 1 : 0)
    if (alert !== null) {
      expect(toastedErrorMock).toBeCalledWith(alert)
    }
    expect(toastedInfoMock).toBeCalledTimes(notice !== null ? 1 : 0)
    if (notice !== null) {
      expect(toastedInfoMock).toBeCalledWith(notice)
    }
  }
  const commonRedirectTest = (alert, notice, url, mock = routerPushMock) => {
    commonToastedTest(alert, notice)
    expect(mock).toBeCalledTimes(1)
    expect(mock).toBeCalledWith(url)
  }

  it('[???????????????]??????????????????????????????????????????', async () => {
    const wrapper = mountFunction(false)
    commonLoadingTest(wrapper)

    await helper.sleep(1)
    commonFetchUserCalledTest(0)
    commonRedirectTest(null, locales.auth.unauthenticated, 'login', authRedirectMock)
  })
  it('[???????????????]???????????????', async () => {
    const wrapper = mountFunction(true)
    commonLoadingTest(wrapper)

    await helper.sleep(1)
    commonFetchUserCalledTest(0)
    commonViewTest(wrapper)
  })

  describe('??????????????????API', () => {
    const user = Object.freeze()
    it('[???????????????]????????????????????????????????????????????????', async () => {
      authFetchUserMock = jest.fn(() => Promise.reject({ response: null }))
      const wrapper = mountFunction(true, user)
      commonLoadingTest(wrapper)

      await helper.sleep(1)
      commonFetchUserCalledTest(0)
      commonRedirectTest(locales.network.failure, null, { path: '/' })
    })
    it('[???????????????]????????????????????????????????????????????????????????????????????????????????????', async () => {
      authFetchUserMock = jest.fn(() => Promise.reject({ response: { status: 401 } }))
      const wrapper = mountFunction(true, user)
      commonLoadingTest(wrapper)

      await helper.sleep(1)
      commonFetchUserCalledTest(1)
      commonToastedTest(null, locales.auth.unauthenticated)
    })
    it('[????????????????????????]????????????????????????????????????????????????', async () => {
      authFetchUserMock = jest.fn(() => Promise.reject({ response: { status: 500 } }))
      const wrapper = mountFunction(true, user)
      commonLoadingTest(wrapper)

      await helper.sleep(1)
      commonFetchUserCalledTest(0)
      commonRedirectTest(locales.network.error, null, { path: '/' })
    })
  })
})
