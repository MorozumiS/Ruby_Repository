source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# NOTE:
# アプリ起動時には読み込む必要がないものにrequire: falseを指定することで,
# 起動時のメモリ消費を抑え、アプリケーションの起動速度を向上させることができる。

ruby '2.7.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.4'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# ファイルアップロード
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'mini_magick'

# json整形
gem 'active_model_serializers'

# 認証
gem 'devise'

# 論理削除
gem 'discard'

# 日本語化対応
gem 'rails-i18n'

# ページネーション
gem 'kaminari'

# DB監視
gem 'audited'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # DBの情報をコメントとして書き込む
  gem 'annotate'
  # デバック
  gem 'pry-byebug'
  gem 'pry-rails'

  # コード規約
  # 生Rubyに関わる構文規則チェック
  gem 'rubocop', require: false
  # Railsに関わる構文規則チェック
  gem 'rubocop-rails', require: false

end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
