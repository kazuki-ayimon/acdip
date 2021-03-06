<template>
  <BaseTitleCard v-if="genre != null" :title="cardTitle">
    <v-row>
      <v-col cols="12">
        <v-img :src="genre.image_url.xlarge" max-height="150" gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.3)">
          <v-card-title class="genre-name mt-8 white--text justify-center align-center text-shadow">{{ genre.name }}</v-card-title>
        </v-img>
      </v-col>
      <v-col v-if="canAction" cols="12" class="text-right">
        <RedBtn class="mb-4 mr-5" to="/articles/new">記事を作成する</RedBtn>
      </v-col>
    </v-row>
    <v-tabs v-model="tab" background-color="#FFFCFC" color="#ef5350" class="mt-4" grow>
      <v-tab v-for="title in titles" :key="title.name">{{ title.name }}</v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <ArticleListCardWithTab
          :processing="processing"
          :articles="articles"
          :info="articleInfo"
          @pagination="onArticlePagination"
        />
      </v-tab-item>
      <v-tab-item>
        <ArticleListCardWithTab
          :processing="processing"
          :articles="favoriteArticles"
          :info="favoriteArticleInfo"
          @pagination="onFavoriteArticlePagination"
        />
      </v-tab-item>
    </v-tabs-items>
  </BaseTitleCard>
</template>

<script>
import Application from '~/plugins/application.js'
import BaseTitleCard from '~/components/molecules/cards/BaseTitleCard.vue'
import ArticleListCardWithTab from '~/components/organisms/tabItem/ArticleListCardWithTab.vue'
import RedBtn from '~/components/atoms/btns/RedBtn.vue'

export default {
  name: 'UsersArticleListCard',

  components: {
    BaseTitleCard,
    ArticleListCardWithTab,
    RedBtn
  },

  mixins: [Application],

  data () {
    return {
      user: null,
      tab: null,
      titles: [
        { name: '執筆' },
        { name: 'お気に入り' }
      ],
      articlePage: 1,
      favoriteArticlePage: 1,
      articleInfo: null,
      favoriteArticleInfo: null,
      articles: null,
      favoriteArticles: null,
      genre: null,
      requiredPoint: 0
    }
  },
  computed: {
    authUsername () {
      return this.$auth.user.username
    },
    canAction () {
      return this.$auth.loggedIn
        ? this.currentUsername === this.authUsername
        : false
    },
    currentUsername () {
      return this.$route.params.username
    },
    currentName () {
      return (this.user && this.user.name) || this.$auth.user.name
    },
    cardTitle () {
      return (this.canAction ? 'あなた' : this.currentName) + 'の災害時役立つ記事'
    }
  },
  async created () {
    await this.$axios.get(this.$config.apiBaseURL + this.$config.userShowUrl.replace('_username', this.currentUsername))
      .then((response) => {
        if (response.data == null) {
          this.$toasted.error(this.$t('system.error'))
          return this.$router.push({ path: '/' })
        } else {
          this.user = response.data.user
          this.requiredPoint = response.data.required_point
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

    await this.onArticlePagination(this.articlePage)
    await this.onFavoriteArticlePagination(this.favoriteArticlePage)
    this.processing = false
  },
  methods: {
    async onArticlePagination (articlePage) {
      this.processing = true
      await this.$axios.get(this.$config.apiBaseURL + this.$config.userGenreArticlesUrl.replace('_username', this.currentUsername).replace('_id', this.$route.params.id), {
        params: { page: articlePage }
      })
        .then((response) => {
          if (response.data == null) {
            this.$toasted.error(this.$t('system.error'))
            if (this.articleInfo == null) {
              return this.$router.push({ path: '/' })
            }
            this.articlePage = this.articleInfo.current_page
          } else {
            this.genre = response.data.genre
            this.articleInfo = response.data.article
            this.articles = response.data.articles
          }
        },
        (error) => {
          this.$toasted.error(this.$t(error.response == null ? 'network.failure' : 'network.error'))
          if (this.articleInfo == null) {
            return this.$router.push({ path: '/' })
          }
          this.articlePage = this.articleInfo.current_page
        })

      this.processing = false
    },

    async onFavoriteArticlePagination (favoriteArticlePage) {
      this.processing = true
      await this.$axios.get(this.$config.apiBaseURL + this.$config.userGenreArticlesUrl.replace('_username', this.currentUsername).replace('_id', this.$route.params.id), {
        params: { page: favoriteArticlePage, favorite: true }
      })
        .then((response) => {
          if (response.data == null) {
            this.$toasted.error(this.$t('system.error'))
            if (this.favoriteArticleInfo == null) {
              return this.$router.push({ path: '/' })
            }
            this.favoriteArticlePage = this.favoriteArticleInfo.current_page
          } else {
            this.genre = response.data.genre
            this.favoriteArticleInfo = response.data.article
            this.favoriteArticles = response.data.articles
          }
        },
        (error) => {
          this.$toasted.error(this.$t(error.response == null ? 'network.failure' : 'network.error'))
          if (this.favoriteArticleInfo == null) {
            return this.$router.push({ path: '/' })
          }
          this.favoriteArticlePage = this.favoriteArticleInfo.current_page
        })

      this.processing = false
    }
  }
}
</script>
