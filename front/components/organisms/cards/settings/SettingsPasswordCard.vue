<template>
  <BaseTitleCard v-if="user != null" title="パスワード変更">
    <v-row>
      <v-col cols="auto">
        <UserPasswordForm
          :user="user"
          :processing="processing"
          @user-update="onUserUpdate"
        />
      </v-col>
    </v-row>
  </BaseTitleCard>
</template>

<script>
import Application from '~/plugins/application.js'
import BaseTitleCard from '~/components/molecules/cards/BaseTitleCard.vue'
import UserPasswordForm from '~/components/organisms/form/UserPasswordForm.vue'

export default {
  name: 'SettingsPasswordCard',

  components: {
    BaseTitleCard,
    UserPasswordForm
  },

  mixins: [Application],

  data () {
    return {
      user: null
    }
  },

  async created () {
    await this.$axios.get(this.$config.apiBaseURL + this.$config.userShowUrl.replace('_username', this.$auth.user.username))
      .then((response) => {
        if (response.data == null) {
          this.$toasted.error(this.$t('system.error'))
          return this.$router.push({ path: '/' })
        } else {
          this.user = response.data.user
        }
      },
      (error) => {
        if (error.response == null) {
          this.$toasted.error(this.$t('network.failure'))
        } else if (error.response.status === 401) {
          return this.signOut()
        } else {
          this.$toasted.error(this.$t('network.error'))
        }
        return this.$router.push({ path: '/' })
      })

    this.processing = false
  },
  methods: {
    async onUserUpdate (userInfo) {
      this.processing = true

      await this.$axios.post(this.$config.apiBaseURL + this.$config.userUpdateUrl, {
        current_password: userInfo.current_password,
        password: userInfo.password,
        password_confirmation: userInfo.password_confirmation
      })
        .then((response) => {
          if (response.data == null) {
            this.$toasted.error(this.$t('system.error'))
          } else {
            this.$auth.setUser(response.data.user)
            if (this.$auth.loggedIn) {
              return this.redirectSuccess(response.data.alert, response.data.notice)
            } else {
              return this.redirectSignIn(response.data.alert, response.data.notice)
            }
          }
        },
        (error) => {
          if (error.response == null) {
            this.$toasted.error(this.$t('network.failure'))
          } else if (error.response.status === 401) {
            return this.signOut()
          } else if (error.response.data == null) {
            this.$toasted.error(this.$t('network.error'))
          } else {
            this.$emit('alert', error.response.data.alert)
            this.$emit('notice', error.response.data.notice)
          }
        })

      this.processing = false
    }
  }
}
</script>
