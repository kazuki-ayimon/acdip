<template>
  <ValidationObserver v-slot="{ invalid }" ref="observer">
    <TheProcessing v-if="processing" />
    <v-form autocomplete="off">
      <v-row justify="center">
        <v-col cols="12">
          <v-sheet outlined class="mt-5">
            <BaseImageFileInput
              v-model="image"
              :old-src="getImage"
              label="画像を選択してください。"
              title="image"
              rules="size_20MB:20480"
            />
          </v-sheet>
        </v-col>
        <v-col cols="12">
          <v-sheet outlined class="pa-2" height="60">
            <BaseTextField
              v-model="name"
              name="name"
              label="ジャンル名"
            />
          </v-sheet>
        </v-col>
        <div class="text-center">
          <RedBtn
            id="genre_update_btn"
            :disabled="invalid || processing"
            @click="onGenreUpdate"
          >
            作成
          </RedBtn>
          <DeleteConfirmDialog title="ジャンル削除" @click="onGenreDelete" />
        </div>
      </v-row>
    </v-form>
  </ValidationObserver>
</template>

<script>
import { ValidationObserver } from 'vee-validate'
import Application from '~/plugins/application.js'
import BaseImageFileInput from '~/components/molecules/fileInputs/BaseImageFileInput.vue'
import BaseTextField from '~/components/molecules/textFields/BaseTextField.vue'
import RedBtn from '~/components/atoms/btns/RedBtn.vue'
import DeleteConfirmDialog from '~/components/organisms/dialogs/DeleteConfirmDialog.vue'

export default {
  name: 'GenreEditForm',

  components: {
    ValidationObserver,
    BaseImageFileInput,
    BaseTextField,
    RedBtn,
    DeleteConfirmDialog
  },

  mixins: [Application],

  props: {
    errors: {
      type: Object,
      default: undefined
    },
    genre: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      image: null,
      name: ''
    }
  },
  computed: {
    getImage () {
      return (this.genre && this.genre.image_url.xlarge) || undefined
    }
  },
  created () {
    this.name = this.name || this.genre.name
    this.processing = false
  },
  methods: {
    onGenreUpdate () {
      const genreInfo = {
        image: this.image,
        name: this.name
      }
      this.$emit('genre-update', genreInfo)
    },
    onGenreDelete () {
      this.$emit('genre-delete')
    }
  }
}
</script>
