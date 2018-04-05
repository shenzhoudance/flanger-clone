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
