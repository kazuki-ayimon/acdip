json.success true

json.required_point @required_point

json.genre do
  json.id @genre.id
  json.name @genre.name
  json.image_url do
    json.large "#{Settings['base_image_url']}#{@genre.image_url(:large)}"
    json.xlarge "#{Settings['base_image_url']}#{@genre.image_url(:xlarge)}"
    json.xxlarge "#{Settings['base_image_url']}#{@genre.image_url(:xxlarge)}"
  end
end

if @articles.exists?
  json.article do
    json.total_count @articles.total_count
    json.current_page @articles.current_page
    json.total_pages @articles.total_pages
    json.limit_value @articles.limit_value
  end
  
  json.articles do
    json.array! @articles do |article|
      json.id article.id
      json.title article.title
      json.content article.content
      json.genres do
        json.array! article.genres do |genre|
          json.id genre.id
          json.name genre.name
        end
      end
      json.thumbnail_url do
        json.large "#{Settings['base_image_url']}#{article.thumbnail_url(:large)}"
        json.xlarge "#{Settings['base_image_url']}#{article.thumbnail_url(:xlarge)}"
        json.xxlarge "#{Settings['base_image_url']}#{article.thumbnail_url(:xxlarge)}"
      end
      json.created_at article.created_at
      json.updated_at article.updated_at
    end
  end
end
if @favorite_articles.exists?
  json.favorite_article do
    json.total_count @favorite_articles.total_count
    json.current_page @favorite_articles.current_page
    json.total_pages @favorite_articles.total_pages
    json.limit_value @favorite_articles.limit_value
  end

  json.favorite_articles do
    json.array! @favorite_articles do |article|
      json.id article.id
      json.title article.title
      json.content article.content
      json.thumbnail_url do
        json.large "#{Settings['base_image_url']}#{article.thumbnail_url(:large)}"
        json.xlarge "#{Settings['base_image_url']}#{article.thumbnail_url(:xlarge)}"
        json.xxlarge "#{Settings['base_image_url']}#{article.thumbnail_url(:xxlarge)}"
      end
      json.created_at article.created_at
      json.updated_at article.updated_at
    end
  end
end
