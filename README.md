# Let's Buld: With Ruby on Rails - eCommerce Music Shop

```
cd workspace
rails new flanger
cd flanger
git init
git add .
git commit -m "initial commit"
git remote add origin https://github.com/shenzhoudance/flanger-clone.git
git push -u origin master
```
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq1taxssr4j312i0xghas.jpg)

# 安装 gems
```
git checkout -b gems
---
gem 'bulma-rails', '~> 0.6.1'
gem 'simple_form', '~> 3.5'
gem 'devise', '~> 4.4'
gem 'gravatar_image_tag', '~> 1.2'
gem 'carrierwave'
gem 'mini_magick'
---
group :development, :test do
---
gem 'better_errors', '~> 2.4'
gem 'guard', '~> 2.14', '>= 2.14.1'
gem 'guard-livereload', '~> 2.5', '>= 2.5.2'
---
bundle install
rails generate simple_form:install
rails generate devise:install
rails generate devise User
rake db:migrate
rails g migration add_name_to_users name:string
rake db:migrate
---
config/routes.rb
---
Rails.application.routes.draw do
  devise_for :users, conrollers: {
    registrations: 'registrations'
  }
end
---
app/controllers/registrations_controller.rb
---
class RegistrationsController < Devise::RegistrationsController

 private

 def sign_up_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end

 def account_update_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
 end

end
---
```

# 新建 store index
```
rails g controller store index
---
config/routes.rb
---
Rails.application.routes.draw do
  root 'store#index'
end


app/assets/stylesheets/application.scss
---
@import "bulma";

app/views/layouts/application.html.erb
---
<!DOCTYPE html>
<html>
  <head>
    <title>Flanger</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
---
<!DOCTYPE html>
<html>
  <head>
    <title>Flanger</title>
    <%= csrf_meta_tags %>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%= stylesheet_link_tag 'https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' %>
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application' %>
  </head>

  <body class="<%= yield (:body_class) %>">
    <% if flash[:notice] %>
      <div class="notification is-success global-notification">
        <p class="notice"><%= notice %></p>
      </div>
    <% end %>
    <% if flash[:alert] %>
    <div class="notification is-danger global-notification">
      <p class="alert"><%= alert %></p>
    </div>
    <% end %>
     <nav class="navbar is-warning" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <%= link_to root_path, class:"navbar-item" do %>
          <h1 class="title is-5">Flanger</h1>
        <% end  %>
      <div class="navbar-burger burger" data-target="navbar">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>

      <div id="navbar" class="navbar-menu">
        <div class="navbar-end">
          <div class="navbar-item">
            <div class="field is-grouped">

            <%# if cart_has_items %>
              <%#= link_to cart_path(@cart), class:"navbar-item button is-warning" do %>
          <!--    <span class="icon is-small">
                <i class="fa fa-shopping-cart"></i>
              </span>
              <span>Cart
                <%#= cart_count_over_one %>
              </span> -->
              <%# end %>
            <%# end %>

            <% if user_signed_in? %>
              <%= link_to 'Sell', new_instrument_path, class: "navbar-item button is-dark" %>

              <div class="navbar-item has-dropdown is-hoverable">
                <%= link_to 'Account', edit_user_registration_path, class: "navbar-link" %>
                <div class="navbar-dropdown is-right">
                  <%= link_to current_user.name, edit_user_registration_path, class:"navbar-item" %>
                  <%= link_to "Log Out", destroy_user_session_path, method: :delete, class:"navbar-item" %>
                </div>
              </div>
            <% else %>

            <%= link_to "Sign In", new_user_session_path, class:"navbar-item button is-warning" %>
            <%= link_to "Sign up", new_user_registration_path, class:"navbar-item button is-warning"%>

            <% end %>

            </div>
          </div>
        </div>
    </div>
  </nav>

  <%= yield(:header) %>

  <div class="container">

    <%= yield %>

  </div>

  </body>
</html>
---
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq1u99xq0qj31kw07pgmc.jpg)

```
app/assets/stylesheets/_functions.scss
---
:root {
 --spacing-none: 0;
 --spacing-extra-small: .25rem;
 --spacing-small: .5rem;
 --spacing-medium: 1rem;
 --spacing-large: 2rem;
 --spacing-extra-large: 4rem;
 --spacing-extra-extra-large: 8rem;
 --spacing-extra-extra-extra-large: 16rem;
}

/* Functional Styles: http://tachyons.io/docs/ */

/* Padding http://tachyons.io/docs/layout/spacing/ */
.pa0 { padding: var(--spacing-none); }
.pa1 { padding: var(--spacing-extra-small); }
.pa2 { padding: var(--spacing-small); }
.pa3 { padding: var(--spacing-medium); }
.pa4 { padding: var(--spacing-large); }
.pa5 { padding: var(--spacing-extra-large); }
.pa6 { padding: var(--spacing-extra-extra-large); }
.pa7 { padding: var(--spacing-extra-extra-extra-large); }

.pl0 { padding-left: var(--spacing-none); }
.pl1 { padding-left: var(--spacing-extra-small); }
.pl2 { padding-left: var(--spacing-small); }
.pl3 { padding-left: var(--spacing-medium); }
.pl4 { padding-left: var(--spacing-large); }
.pl5 { padding-left: var(--spacing-extra-large); }
.pl6 { padding-left: var(--spacing-extra-extra-large); }
.pl7 { padding-left: var(--spacing-extra-extra-extra-large); }

.pr0 { padding-right: var(--spacing-none); }
.pr1 { padding-right: var(--spacing-extra-small); }
.pr2 { padding-right: var(--spacing-small); }
.pr3 { padding-right: var(--spacing-medium); }
.pr4 { padding-right: var(--spacing-large); }
.pr5 { padding-right: var(--spacing-extra-large); }
.pr6 { padding-right: var(--spacing-extra-extra-large); }
.pr7 { padding-right: var(--spacing-extra-extra-extra-large); }

.pb0 { padding-bottom: var(--spacing-none); }
.pb1 { padding-bottom: var(--spacing-extra-small); }
.pb2 { padding-bottom: var(--spacing-small); }
.pb3 { padding-bottom: var(--spacing-medium); }
.pb4 { padding-bottom: var(--spacing-large); }
.pb5 { padding-bottom: var(--spacing-extra-large); }
.pb6 { padding-bottom: var(--spacing-extra-extra-large); }
.pb7 { padding-bottom: var(--spacing-extra-extra-extra-large); }

.pt0 { padding-top: var(--spacing-none); }
.pt1 { padding-top: var(--spacing-extra-small); }
.pt2 { padding-top: var(--spacing-small); }
.pt3 { padding-top: var(--spacing-medium); }
.pt4 { padding-top: var(--spacing-large); }
.pt5 { padding-top: var(--spacing-extra-large); }
.pt6 { padding-top: var(--spacing-extra-extra-large); }
.pt7 { padding-top: var(--spacing-extra-extra-extra-large); }

.pv0 {
 padding-top: var(--spacing-none);
 padding-bottom: var(--spacing-none);
}
.pv1 {
 padding-top: var(--spacing-extra-small);
 padding-bottom: var(--spacing-extra-small);
}
.pv2 {
 padding-top: var(--spacing-small);
 padding-bottom: var(--spacing-small);
}
.pv3 {
 padding-top: var(--spacing-medium);
 padding-bottom: var(--spacing-medium);
}
.pv4 {
 padding-top: var(--spacing-large);
 padding-bottom: var(--spacing-large);
}
.pv5 {
 padding-top: var(--spacing-extra-large);
 padding-bottom: var(--spacing-extra-large);
}
.pv6 {
 padding-top: var(--spacing-extra-extra-large);
 padding-bottom: var(--spacing-extra-extra-large);
}

.pv7 {
 padding-top: var(--spacing-extra-extra-extra-large);
 padding-bottom: var(--spacing-extra-extra-extra-large);
}

.ph0 {
 padding-left: var(--spacing-none);
 padding-right: var(--spacing-none);
}

.ph1 {
 padding-left: var(--spacing-extra-small);
 padding-right: var(--spacing-extra-small);
}

.ph2 {
 padding-left: var(--spacing-small);
 padding-right: var(--spacing-small);
}

.ph3 {
 padding-left: var(--spacing-medium);
 padding-right: var(--spacing-medium);
}

.ph4 {
 padding-left: var(--spacing-large);
 padding-right: var(--spacing-large);
}

.ph5 {
 padding-left: var(--spacing-extra-large);
 padding-right: var(--spacing-extra-large);
}

.ph6 {
 padding-left: var(--spacing-extra-extra-large);
 padding-right: var(--spacing-extra-extra-large);
}

.ph7 {
 padding-left: var(--spacing-extra-extra-extra-large);
 padding-right: var(--spacing-extra-extra-extra-large);
}
.ma0  {  margin: var(--spacing-none); }
.ma1 {  margin: var(--spacing-extra-small); }
.ma2  {  margin: var(--spacing-small); }
.ma3  {  margin: var(--spacing-medium); }
.ma4  {  margin: var(--spacing-large); }
.ma5  {  margin: var(--spacing-extra-large); }
.ma6 {  margin: var(--spacing-extra-extra-large); }
.ma7 { margin: var(--spacing-extra-extra-extra-large); }

.ml0  {  margin-left: var(--spacing-none); }
.ml1 {  margin-left: var(--spacing-extra-small); }
.ml2  {  margin-left: var(--spacing-small); }
.ml3  {  margin-left: var(--spacing-medium); }
.ml4  {  margin-left: var(--spacing-large); }
.ml5  {  margin-left: var(--spacing-extra-large); }
.ml6 {  margin-left: var(--spacing-extra-extra-large); }
.ml7 { margin-left: var(--spacing-extra-extra-extra-large); }

.mr0  {  margin-right: var(--spacing-none); }
.mr1 {  margin-right: var(--spacing-extra-small); }
.mr2  {  margin-right: var(--spacing-small); }
.mr3  {  margin-right: var(--spacing-medium); }
.mr4  {  margin-right: var(--spacing-large); }
.mr5  {  margin-right: var(--spacing-extra-large); }
.mr6 {  margin-right: var(--spacing-extra-extra-large); }
.mr7 { margin-right: var(--spacing-extra-extra-extra-large); }

.mb0  {  margin-bottom: var(--spacing-none); }
.mb1 {  margin-bottom: var(--spacing-extra-small); }
.mb2  {  margin-bottom: var(--spacing-small); }
.mb3  {  margin-bottom: var(--spacing-medium); }
.mb4  {  margin-bottom: var(--spacing-large); }
.mb5  {  margin-bottom: var(--spacing-extra-large); }
.mb6 {  margin-bottom: var(--spacing-extra-extra-large); }
.mb7 { margin-bottom: var(--spacing-extra-extra-extra-large); }

.mt0  {  margin-top: var(--spacing-none); }
.mt1 {  margin-top: var(--spacing-extra-small); }
.mt2  {  margin-top: var(--spacing-small); }
.mt3  {  margin-top: var(--spacing-medium); }
.mt4  {  margin-top: var(--spacing-large); }
.mt5  {  margin-top: var(--spacing-extra-large); }
.mt6 {  margin-top: var(--spacing-extra-extra-large); }
.mt7 { margin-top: var(--spacing-extra-extra-extra-large); }

.mv0   {
 margin-top: var(--spacing-none);
 margin-bottom: var(--spacing-none);
}
.mv1  {
 margin-top: var(--spacing-extra-small);
 margin-bottom: var(--spacing-extra-small);
}
.mv2   {
 margin-top: var(--spacing-small);
 margin-bottom: var(--spacing-small);
}
.mv3   {
 margin-top: var(--spacing-medium);
 margin-bottom: var(--spacing-medium);
}
.mv4   {
 margin-top: var(--spacing-large);
 margin-bottom: var(--spacing-large);
}
.mv5   {
 margin-top: var(--spacing-extra-large);
 margin-bottom: var(--spacing-extra-large);
}
.mv6  {
 margin-top: var(--spacing-extra-extra-large);
 margin-bottom: var(--spacing-extra-extra-large);
}
.mv7  {
 margin-top: var(--spacing-extra-extra-extra-large);
 margin-bottom: var(--spacing-extra-extra-extra-large);
}

.mh0   {
 margin-left: var(--spacing-none);
 margin-right: var(--spacing-none);
}
.mh1   {
 margin-left: var(--spacing-extra-small);
 margin-right: var(--spacing-extra-small);
}
.mh2   {
 margin-left: var(--spacing-small);
 margin-right: var(--spacing-small);
}
.mh3   {
 margin-left: var(--spacing-medium);
 margin-right: var(--spacing-medium);
}
.mh4   {
 margin-left: var(--spacing-large);
 margin-right: var(--spacing-large);
}
.mh5   {
 margin-left: var(--spacing-extra-large);
 margin-right: var(--spacing-extra-large);
}
.mh6  {
 margin-left: var(--spacing-extra-extra-large);
 margin-right: var(--spacing-extra-extra-large);
}
.mh7  {
 margin-left: var(--spacing-extra-extra-extra-large);
 margin-right: var(--spacing-extra-extra-extra-large);
}

/* Color */
.bg-gray { background-color: #f8f8f8; }

/* Font Size */
.f1 { font-size: 3rem; }
.f2 { font-size: 2.25rem; }
.f3 { font-size: 1.5rem; }
.f4 { font-size: 1.25rem; }
.f5 { font-size: 1rem; }
.f6 { font-size: .875rem; }
.f7 { font-size: .75rem; } /* Small and hard to read for many people so use with extreme caution */

/* Font Weight */
.fw4 { font-weight: 400; }
.fw5 { font-weight: 500; }
.fw6 { font-weight: 600; }
.fw7 { font-weight: 600; }

/* Border */
.border-light { border: 1px solid #dddddd; }
.border { border: 1px solid #dedede; }
.border-bottom { border-bottom: 1px solid #dddddd; }
.border-top { border-top: 1px solid #dddddd; }
.border-right { border-right: 1px solid #dddddd; }

.border-radius-3 { border-radius: 3px; }

.justify-center { justify-content: center; }
.align-items-center { align-items: center; }

/* Display */
.inline-block { display: inline-block; }
.block { display: block; }

/* Background */
.bg-white { background-color: white; }
.bg-light { background-color: #F1F1F1; }
---
app/assets/stylesheets/application.scss
---
$link: #444;
$link-hover: #222;

@import "bulma";
@import "functions";


.notification {
  border-radius: 0;
}

.notification:not(:last-child) {
  margin-bottom: 0;
}

.instrument-index-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));

  .instrument {
    border-left: 0;
    border-top: 0;
    position: relative;
    min-height: 375px;

    .title {
      line-height: 1.6rem;
    }
    .price {
      position: absolute;
      bottom: 10px;
      right: 10px;
    }
  }

  .instrument-thumb {
    position: relative;
    max-height: 150px;
    overflow: hidden;

    img {
      max-width: 100%;
      width: 100%;
      &:hover {
        opacity: .9;
      }
    }

    .condition {
      position: absolute;
      bottom: 10px;
      right: 9px;
    }
  }
}
---
```
```
git add .
git commit -m "add devise & index & scss"
git push origin gems
```
```
git checkout -b scaffold
rails g scaffold Instrument brand:string model:string description:text condition:string finish:string title:string price:decimal
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq1upzy85dj31hi0m8tea.jpg)
---
```
db/migrate/20180405081601_create_instruments.rb
---
class CreateInstruments < ActiveRecord::Migration[5.1]
  def change
    create_table :instruments do |t|
      t.string :brand
      t.string :model
      t.text :description
      t.string :condition
      t.string :finish
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
---
class CreateInstruments < ActiveRecord::Migration[5.1]
  def change
    create_table :instruments do |t|
      t.string :brand
      t.string :model
      t.text :description
      t.string :condition
      t.string :finish
      t.string :title
      t.decimal :price, precision: 5, scale: 2, default: 0

      t.timestamps
    end
  end
end
---
rake db:migrate
rails server
http://localhost:3000/instruments/new
---
```
![image](https://ws1.sinaimg.cn/large/006tNc79gy1fq1uulkmgoj31kw0hj41e.jpg)
```
---
config/routes.rb
---
Rails.application.routes.draw do
  resources :instruments
  devise_for :users, conrollers: {
    registrations: 'registrations'
  }
  root 'store#index'
end

---
Rails.application.routes.draw do
  resources :instruments
  devise_for :users, conrollers: {
    registrations: 'registrations'
  }
  root 'instruments#index'
end
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq1uxhkvp1j31kw09rq48.jpg)
```
git add .
git commit -m "add instruments root index"
git push origin scaffold
```
# 添加图片上传功能
```
git checkout -b uploader
rails generate uploader Image
---
app/uploaders/image_uploader.rb
---
include CarrierWave::MiniMagick

version :thumb do
   process resize_to_fit: [400, 300]
end

version :default do
   process resize_to_fit: [800, 600]
end

def extension_whitelist
   %w(jpg jpeg gif png)
end

```
```
rails g migration add_image_to_instruments image:string
rake db:migrate
```
![image](https://ws4.sinaimg.cn/large/006tNc79gy1fq1vaak9ldj31hg0lk7ak.jpg)

```
app/models/instrument.rb
---
class Instrument < ApplicationRecord
  mount_uploader :image, ImageUploader
  serialize :image, JSON # If you use SQLite, add this line
  belongs_to :user, optional: true

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum aloud. "}
  validates :price, length: { maximum: 7 }

  BRAND = %w{ Fender Gibson Epiphone ESP Martin Dean Taylor Jackson PRS  Ibanez Charvel Washburn }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

end
---
app/models/user.rb
---
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :instruments

end

app/controllers/instruments_controller.rb
---
class InstrumentsController < ApplicationController
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]

  # GET /instruments
  # GET /instruments.json
  def index
    @instruments = Instrument.all
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = Instrument.new
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = Instrument.new(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: 'Instrument was successfully created.' }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1
  # PATCH/PUT /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: 'Instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @instrument.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: 'Instrument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition, :finish, :title, :price)
    end
end

---
class InstrumentsController < ApplicationController
  before_action :set_instrument, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /instruments
  # GET /instruments.json
  def index
    @instruments = Instrument.all.order("created_at desc")
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = current_user.instruments.build
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = current_user.instruments.build(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: 'Instrument was successfully created.' }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1
  # PATCH/PUT /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: 'Instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @instrument.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: 'Instrument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instrument_params
      params.require(:instrument).permit(:brand, :model, :description, :condition, :finish, :title, :price, :image)
    end
end
---
```
#修改表单样式
```
app/views/instruments/_form.html.erb
---

<%= simple_form_for(@instrument) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :brand %>
    <%= f.input :model %>
    <%= f.input :description %>
    <%= f.input :condition %>
    <%= f.input :finish %>
    <%= f.input :title %>
    <%= f.input :price %>
  </div>

  <div class="form-actions">
    <%= f.button :submit %>
  </div>
<% end %>
---
<div class="columns">
  <div class="column is-8 is-centered">

    <%= simple_form_for @instrument, html: { multipart: true } do |f| %>
      <%= f.error_notification %>

        <div class="columns">

          <div class="field column is-9">
            <div class="control">
              <%= f.input :title , required: true, input_html: { class: "input"}, wrapper: false, label_html: { class:"label" } %>
            </div>
          </div>

          <div class="field column">
            <div class="control">
              <%= f.input :price, required: true, input_html: { class:"input", maxlength: 7  }, wrapper: false, label_html: { class:"label" } %>
            </div>
          </div>

        </div>

        <div class="field">
          <div class="control">
            <%= f.input :model, required: true, input_html: { class:"input" }, wrapper: false, label_html: { class:"label" } %>
          </div>
        </div>

        <div class="field">
          <div class="control">
            <%= f.input :description, required: true, input_html: { class:"textarea" }, wrapper: false, label_html: { class:"label" } %>
          </div>
        </div>

        <div class="columns">
          <div class="field column is-4">
            <div class="control">
              <label class="label">Brand</label>
              <div class="control has-icons-left">
                <span class="select">
                  <%= f.input_field :brand, collection: Instrument::BRAND, prompt: "Select brand" %>
                </span>
                <span class="icon is-small is-left">
                  <i class="fa fa-tag"></i>
                </span>
              </div>
            </div>
           </div>

          <div class="field column is-4">
            <div class="control">
              <label class="label">Finish</label>
              <div class="control has-icons-left">
                <span class="select">
                  <%= f.input_field :finish, collection: Instrument::FINISH, prompt: "Select finish" %>
                </span>
                <span class="icon is-small is-left">
                  <i class="fa fa-paint-brush"></i>
                </span>
              </div>
            </div>
           </div>

          <div class="field column is-4">
            <div class="control">
              <label class="label">Condition</label>
              <div class="control has-icons-left">
                <span class="select">
                  <%= f.input_field :condition, collection: Instrument::CONDITION, prompt: "Select condition" %>
                </span>
                <span class="icon is-small is-left">
                  <i class="fa fa-paint-brush"></i>
                </span>
              </div>
            </div>
           </div>
         </div>

        <div class="field">
          <div class="control">
            <label class="label">Add images</label>
              <div class="file">
              <label class="file-label">
                <%= f.input :image, as: :file, input_html: { class:"file-input instrument-image" }, label: false, wrapper: false %>
                  <span class="file-cta">
                    <span class="file-icon"><i class="fa fa-upload"></i></span>
                    <span class="file-label">Choose a file…</span>
                  </span>
              </label>
              </div>
            </div>
          </div>
          <output id="list"></output>
        <hr />

        <div class="field is-grouped">
          <div class="control">
            <%= f.button :submit, class: 'button is-warning' %>
            <%= link_to 'Cancel', instruments_path, class:'button is-light' %>
          </div>
        </div>

      <% end %>
  </div>
</div>
---
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq1vqkftt3j31kw0u378t.jpg)

```
app/views/instruments/new.html.erb
---
<h1>New Instrument</h1>

<%= render 'form', instrument: @instrument %>

<%= link_to 'Back', instruments_path %>

---
<% content_for :header do %>
<section class="hero is-warning">
  <div class="hero-body">
    <div class="container">
      <h1 class="title">
        Sell an Instrument
      </h1>
    </div>
  </div>
</section>
<% end %>

<div class="pv4">
  <%= render 'form', instrument: @instrument %>
</div>
---
```
![image](https://ws3.sinaimg.cn/large/006tNc79gy1fq1vtch7ddj31kw0u0jvg.jpg)

```
app/assets/javascripts/instruments.js
---
document.addEventListener("turbolinks:load", function() {

  var instrumentImage = document.querySelector('.instrument-image');

  function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          var span = document.createElement('span');
          span.innerHTML = ['<img class="instrument-preview-thumb" src="', e.target.result,
            '" title="', escape(theFile.name), '"/>'
          ].join('');
          document.getElementById('list').insertBefore(span, null);
        };
      })(f);
      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  if (instrumentImage) {
    this.addEventListener('change', handleFileSelect, false);
  }

});
---
```
```
git add .
git commit -m "add instrument form & new"
git push origin uploader

```
```
app/views/instruments/index.html.erb
---
<p id="notice"><%= notice %></p>

<h1>Instruments</h1>

<table>
  <thead>
    <tr>
      <th>Brand</th>
      <th>Model</th>
      <th>Description</th>
      <th>Condition</th>
      <th>Finish</th>
      <th>Title</th>
      <th>Price</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @instruments.each do |instrument| %>
      <tr>
        <td><%= instrument.brand %></td>
        <td><%= instrument.model %></td>
        <td><%= instrument.description %></td>
        <td><%= instrument.condition %></td>
        <td><%= instrument.finish %></td>
        <td><%= instrument.title %></td>
        <td><%= instrument.price %></td>
        <td><%= link_to 'Show', instrument %></td>
        <td><%= link_to 'Edit', edit_instrument_path(instrument) %></td>
        <td><%= link_to 'Destroy', instrument, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Instrument', new_instrument_path %>
---
<% content_for :header do %>
<section class="hero is-warning">
  <div class="hero-body">
    <div class="container">
      <h1 class="title">
        Browse the latest instruments on Flanger
      </h1>
    </div>
  </div>
</section>
<% end %>

<div class="instrument-index-grid pt4">
  <% @instruments.each do |instrument| %>

    <div class="instrument border-light">
      <div class="instrument-thumb">
      <%= link_to image_tag(instrument.image_url(:thumb)), instrument %>

      <% if instrument.condition? %>
        <div class="condition">
          <span class="tag is-dark"><%= instrument.condition %></span>
        </div>
      <% end %>
      </div>


    <div class="pa3">

      <h3 class="fw7 f4 title"><%= link_to instrument.title, instrument %></h3>

      <p class="has-text-gray fg pt1">Sold by <%= instrument.user.name %></p>

      <p class="f3 fw6 has-text-right pt2 price"><%= number_to_currency(instrument.price) %></p>

      <% if instrument_author(instrument) %>
         <%= link_to 'Edit', edit_instrument_path(instrument), class: "button is-small" %>
         <%= link_to 'Delete', instrument, method: :delete, data: { confirm: "Are you sure ?" }, class: "button is-small" %>
      <% end %>

    </div>
  </div>
  <% end %>
</div>
---
app/views/instruments/show.html.erb
---
<p id="notice"><%= notice %></p>

<p>
  <strong>Brand:</strong>
  <%= @instrument.brand %>
</p>

<p>
  <strong>Model:</strong>
  <%= @instrument.model %>
</p>

<p>
  <strong>Description:</strong>
  <%= @instrument.description %>
</p>

<p>
  <strong>Condition:</strong>
  <%= @instrument.condition %>
</p>

<p>
  <strong>Finish:</strong>
  <%= @instrument.finish %>
</p>

<p>
  <strong>Title:</strong>
  <%= @instrument.title %>
</p>

<p>
  <strong>Price:</strong>
  <%= @instrument.price %>
</p>

<%= link_to 'Edit', edit_instrument_path(@instrument) %> |
<%= link_to 'Back', instruments_path %>
---
<% content_for :body_class, 'bg-light' %>

<section class="section instrument-show">
  <div class="columns">
    <div class="column is-8">
      <h1 class="title is-2"><%= @instrument.title %></h1>

      <ul class="pv1">
        <% if @instrument.brand? %>
        <li class="inline-block pr3"><%= @instrument.brand %></li>
        <% end %>

        <li class="inline-block pr3"><%= @instrument.model %></li>

        <% if @instrument.condition? %>
        <li class="inline-block pr3"><%= @instrument.condition %></li>
        <% end %>
      </ul>

      <div class="feature-image">
        <%= image_tag(@instrument.image_url(:default)) %>
      </div>

      <div class="content pa4 mt3 bg-white border-radius-3">

      <h3 class="subtitle is-4">Description</h3>
      <%= @instrument.description %>


      <h3 class="subtitle is-4 pt5">Product Specs</h3>

      <table class="table is-narrow">
        <% if @instrument.condition %>
        <tr>
          <td class="has-text-weight-bold">Condition:</td>
          <td><%= @instrument.condition %></td>
        </tr>
        <% end %>

        <% if @instrument.finish %>
          <tr>
            <td class="has-text-weight-bold">Finish:</td>
            <td><%= @instrument.finish %></td>
          </tr>
        <% end %>

        <% if @instrument.brand %>
          <tr>
            <td class="has-text-weight-bold">Brand:</td>
            <td><%= @instrument.brand %></td>
          </tr>
        <% end %>

        <tr>
          <td class="has-text-weight-bold">Model:</td>
          <td><%= @instrument.model %></td>
        </tr>
      </table>
    </div>
    </div>
    <div class="column is-3 is-offset-1">
      <div class="bg-white pa4 border-radius-3">
        <h4 class="title is-5 has-text-centered"><%= number_to_currency(@instrument.price) %></h4>
        <p class="has-text-centered mb4">Sold by <%= @instrument.user.name %></p>
        <%= button_to 'Add to cart', line_items_path(instrument_id: @instrument), class: 'button is-warning add-to-cart' %>
      </div>
    </div>
  </div>

  <% if instrument_author(@instrument) %>
    <%= link_to 'Edit', edit_instrument_path(@instrument), class: 'button' %>
  <% end %>
</section>
---
app/helpers/instruments_helper.rb
---
module InstrumentsHelper

  def instrument_author(instrument)
    user_signed_in? && current_user.id == instrument.user_id
  end

end
---
```
![image](https://ws3.sinaimg.cn/large/006tNc79ly1fq23oidipcj31kw0np1hr.jpg)
![image](https://ws2.sinaimg.cn/large/006tNc79ly1fq23omp06qj31kw0l7af2.jpg)
