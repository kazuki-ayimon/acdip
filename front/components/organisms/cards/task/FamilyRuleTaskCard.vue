<template>
  <v-card v-if="familyRule !== null" outlined tile>
    <TheProcessing v-if="processing" />
    <!-- <v-img :src="familyRule.image_url.xlarge" max-height="256" /> -->
    <v-col cols="12">
      <v-card-text>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <div class="mx-2 my-2" v-html="familyRule.contact_means_memo" />
      </v-card-text>
      <v-card-text>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <div class="mx-2 my-2" v-html="familyRule.refuge_memo" />
      </v-card-text>
      <v-card-text>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <div class="mx-2 my-2" v-html="familyRule.family_role_memo" />
      </v-card-text>
      <v-card-text>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <div class="mx-2 my-2" v-html="familyRule.emergency_measure_memo" />
      </v-card-text>
      <v-card-text>
        <!-- eslint-disable-next-line vue/no-v-html -->
        <div class="mx-2 my-2" v-html="familyRule.leave_home_memo" />
      </v-card-text>
      <v-divider class="my-5" />
      <div class="text-center">
        <DeleteConfirmDialog title="家族会議のメモをリセット" @click="onFamilyRuleDelete" />
      </div>
    </v-col>
  </v-card>
</template>

<script>
import Application from '~/plugins/application.js'
import DeleteConfirmDialog from '~/components/organisms/dialogs/DeleteConfirmDialog.vue'

export default {
  name: 'FamilyRuleTaskCard',

  components: {
    DeleteConfirmDialog
  },

  mixins: [Application],

  data () {
    return {
      familyRule: null
    }
  },

  async created () {
    await this.$axios.get(this.$config.apiBaseURL + this.$config.familyRuleUrl)
      .then((response) => {
        if (response.data == null) {
          this.$toasted.error(this.$t('system.error'))
          return this.$router.push({ path: '/' })
        } else {
          this.familyRule = response.data.family_rule
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
    async onFamilyRuleDelete () {
      this.processing = true

      await this.$axios.post(this.$config.apiBaseURL + this.$config.familyRuleDeleteUrl)
        .then((response) => {
          if (response.data == null) {
            this.$toasted.error(this.$t('system.error'))
          } else {
            this.$toasted.error(response.data.alert)
            this.$toasted.info(response.data.notice)
            this.$router.push({ path: '/tasks/family_rule/edit' })
          }
        },
        (error) => {
          if (error.response == null) {
            this.$toasted.error(this.$t('network.failure'))
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
