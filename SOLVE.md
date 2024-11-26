<!-- - install gemfill `bundle install --gemfile`
- start app with `rails s`
- create and update .env file

```env
DB_USER=postgres
DB_PASSWORD=your_password
DB_NAME=at_once_rails
```

- `rails db:create`
- `rails db:drop db:create db:migrate`
- `gem install pg`
- added this line in Gemfile in main directory and updated it

```rb
gem 'paranoia'
```

- updated Gemfile `bundle install --gemfile`

- DB Migration Remove the explicit t.uuid :id

  1. rails generate migration CreateOrders order_date:datetime status:string user_id:uuid deleted_at:datetime:index
  2. rails generate migration CreateOrderItems quantity:integer product_id:uuid order_id:uuid deleted_at:datetime:index
  3. rails generate migration CreateProducts name:string description:text price:decimal stock_quantity:integer category_id:uuid deleted_at:datetime:index
  4. rails generate migration CreateRoles name:string deleted_at:datetime:index
  5. rails generate migration CreateUsers name:string role_id:uuid deleted_at:datetime:index

  \*\*\* Instructions for migration
  To create this migration file, `create_orders`, follow the command:

```bash
rails generate migration CreateOrders
```

This will create a migration file in the `db/migrate` directory, where you can then paste the code you provided.

If you want to include the table creation logic directly while generating the migration, you can use:

```bash
rails generate migration CreateOrders order_date:datetime status:string user_id:uuid deleted_at:datetime:index
```

This generates a migration with columns and indices based on the provided options. You would then manually adjust the generated code to add the `unless table_exists?(:orders)` guard and the `id: :uuid` option, as Rails doesn't include those by default.

- User model connecting to devise `rails generate devise User`
- create devise view in `app/view/devise` using command `rails g devise:views`
- updated route `config\routes.rb` file

```rb
Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
end
```

- changed controller name HomepageController to HomePageController `app\controllers\home_page_controller.rb`
- for localization go through the following steps: (e.g., Spanish)

### 1. Add a New Locale File

In your Rails project under the `config/locales` folder:

- Create a new file for Spanish, e.g., `es.yml`.

Example content for `config/locales/es.yml`:

```yaml
es:
  hello: "Hola mundo"
  home:
    error: "Ocurrió un error"
    promotion:
      title: "Bienvenido a nuestro sitio"
      description: "Tenemos muchos productos excelentes para ti"
    hero:
      title: "Bienvenido a nuestro sitio"
      description: "Tenemos muchos productos excelentes para ti"
    featured:
      title: "Productos destacados"
    promotion:
      cta: "Ver todos los productos"
```

### 2. Enable I18n in Application

In the `config/application.rb` file:

- Set the available locales and the default locale.

```ruby
# config/application.rb
module YourAppName
  class Application < Rails::Application
    # Add available locales
    config.i18n.available_locales = [:en, :es]
    # Set default locale
    config.i18n.default_locale = :en
  end
end
```

### 3. Add a Language Switcher (Optional)

In your views, you can add a dropdown or links to let users switch between languages.

Example in `application.html.erb`:

```erb
<nav>
  <ul>
    <li><%= link_to "English", url_for(locale: :en) %></li>
    <li><%= link_to "Español", url_for(locale: :es) %></li>
  </ul>
</nav>
```

### 4. Set Up Locale Handling

To ensure the selected locale is used, update the `application_controller.rb`:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

Now, your app should support both English (`en.yml`) and Spanish (`es.yml`), and users can toggle between languages!

- update `app\controllers\home_page_controller.rb` controller, removed line

```rb
  validates :description, allow_nil: true, allow_blank: true
```

- tested `db/seed.rb` for creating roles in DB:

```rb
Role.create([
  { name: 'admin' },
  { name: 'user' },
  { name: 'guest' }
])
```

```bash
rails db:seed
```

- Tailwind CSS correction
  i. Add Tailwind CSS via CDN in the file app/views/layouts/application.html.erb

  ```html
  <link
    href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css"
    rel="stylesheet"
  />
  ```

  ii. update `config/importmap.rb`, `app/assets/config/manifest.js`

  ```rb
  # config/importmap.rb

  pin_all_from "app/javascript/controllers", under: "controllers"
  pin_all_from "app/javascript/components", under: "components"
  pin "application", preload: true
  ```

  ```js
  // app/assets/config/manifest.js

  //= link_tree ../images
  //= link_directory ../stylesheets .css
  //= link_tree ../builds
  //= link application.css
  //= link app.css
  ``` -->

# Rails Application Setup and Configuration Guide

This documentation provides step-by-step instructions for setting up a Rails application, configuring essential features, and implementing additional functionalities.

---

## Contents

1. [Environment Setup](#environment-setup)
2. [Database Configuration](#database-configuration)
3. [Gem Installation](#gem-installation)
4. [Database Migrations](#database-migrations)
5. [Devise User Authentication](#devise-user-authentication)
6. [Localization (i18n)](#localization-i18n)
7. [Role Seeding](#role-seeding)
8. [Tailwind CSS Integration](#tailwind-css-integration)

---

## Environment Setup

1. Install project dependencies using the following command:

   ```bash
   bundle install --gemfile
   ```

2. Start the Rails application:

   ```bash
   rails s
   ```

3. Create and update the `.env` file in the root directory with the following content:
   ```env
   DB_USER=postgres
   DB_PASSWORD=your_password
   DB_NAME=at_once_rails
   ```

---

## Database Configuration

1. Create the database:

   ```bash
   rails db:create
   ```

2. Drop, recreate, and migrate the database (useful for resetting):

   ```bash
   rails db:drop db:create db:migrate
   ```

3. Install the `pg` gem (PostgreSQL support):
   ```bash
   gem install pg
   ```

---

## Gem Installation

1. Add the `paranoia` gem for soft deletes in the `Gemfile`:

   ```ruby
   gem 'paranoia'
   ```

2. Update the Gemfile:
   ```bash
   bundle install --gemfile
   ```

---

## Database Migrations

### Creating Tables with Migrations

Run the following commands to generate migration files:

1. **Orders Table**

   ```bash
   rails generate migration CreateOrders order_date:datetime status:string user_id:uuid deleted_at:datetime:index
   ```

2. **Order Items Table**

   ```bash
   rails generate migration CreateOrderItems quantity:integer product_id:uuid order_id:uuid deleted_at:datetime:index
   ```

3. **Products Table**

   ```bash
   rails generate migration CreateProducts name:string description:text price:decimal stock_quantity:integer category_id:uuid deleted_at:datetime:index
   ```

4. **Roles Table**

   ```bash
   rails generate migration CreateRoles name:string deleted_at:datetime:index
   ```

5. **Users Table**
   ```bash
   rails generate migration CreateUsers name:string role_id:uuid deleted_at:datetime:index
   ```

#### Notes for Migration

- Ensure to include `id: :uuid` for UUID-based primary keys and add `unless table_exists?` guards manually where needed. Check the following example:

```rb
class CreateRoles < ActiveRecord::Migration[8.0]
  unless table_exists?(:roles)   # added the unless table_exists
    create_table :roles, id: :uuid do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :roles, :deleted_at
  end
end
```

---

## Devise User Authentication

1. Generate the Devise User model:

   ```bash
   rails generate devise User
   ```

2. Generate Devise views:

   ```bash
   rails g devise:views
   ```

3. Update the `config/routes.rb` file:

   ```ruby
   Rails.application.routes.draw do
     devise_for :users

     root 'home#index'
   end
   ```

4. Update devise view files like `app\views\devise\registrations\new.html.erb`:

   ```html.erb
   <!-- keep top codes  -->

   <!-- Name Field -->
   <div class="field">
     <%= f.label :name, "Full Name" %><br />
     <%= f.text_field :name, autofocus: true %>
   </div>

   <!-- keep middle codes  -->

   <!-- Role ID Field -->
   <div class="field">
     <%= f.label :role_id, "Role" %><br />
     <%= f.select :role_id, Role.all.collect { |r| [r.name, r.id] }, { prompt: "Select a Role" } %>
   </div>

   <!-- keep bottom codes  -->
   ```

---

## Localization (i18n)

### 1. Add Locale Files

Create a `config/locales/es.yml` file for Spanish translations:

```yaml
es:
  hello: "Hola mundo"
  home:
    error: "Ocurrió un error"
    promotion:
      title: "Bienvenido a nuestro sitio"
      description: "Tenemos muchos productos excelentes para ti"
    hero:
      title: "Bienvenido a nuestro sitio"
      description: "Tenemos muchos productos excelentes para ti"
    featured:
      title: "Productos destacados"
    promotion:
      cta: "Ver todos los productos"
```

### 2. Update Application Config

Modify `config/application.rb` to enable i18n:

```ruby
# config/application.rb
module YourAppName
  class Application < Rails::Application
    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :en
  end
end
```

### 3. Add a Language Switcher

Add links to toggle languages in `application.html.erb`:

```erb
<nav>
  <ul>
    <li><%= link_to "English", url_for(locale: :en) %></li>
    <li><%= link_to "Español", url_for(locale: :es) %></li>
  </ul>
</nav>
```

### 4. Set Locale in Controller

Update `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
```

---

## Role Seeding

1. Populate roles in the `db/seeds.rb` file:

   ```ruby
   Role.create([
     { name: 'admin' },
     { name: 'user' },
     { name: 'guest' }
   ])
   ```

2. Run the seed script:
   ```bash
   rails db:seed
   ```

---

## Tailwind CSS Integration

1. Add Tailwind CSS via CDN in `app/views/layouts/application.html.erb`:

   ```html
   <link
     href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css"
     rel="stylesheet"
   />
   ```

2. Update/add lines in the `config/importmap.rb` file:

   ```ruby
   pin_all_from "app/javascript/controllers", under: "controllers"
   pin_all_from "app/javascript/components", under: "components"
   pin "application", preload: true
   ```

3. Update the `app/assets/config/manifest.js` file:

   ```javascript
   // app/assets/config/manifest.js

   //= link_tree ../images
   //= link_directory ../stylesheets .css
   //= link_tree ../builds
   //= link application.css
   //= link app.css
   ```

4. It will enable `app\assets\stylesheets\application.css` file as global css file. Check it adding simple css in this file:

   ```css
   body {
     color: red;
   }
   ```

---

## Few Other Changes

i. Updated `app\views\product_page\index.html.erb` file link url to root route.

```html.erb
<%= link_to t('home_page.cta'), root_path, class: 'bg-blue-500 text-white px-6
py-3 rounded-full inline-block hover:bg-blue-600 transition-colors duration-300'%>
```

ii. for uuid setup visited `config\application.rb` and updated it with

```rb
config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
```

---

Here are suggestions for improving the setup and optimizing the workflow described in your documentation:

---

### **1. Environment Setup**

- **Optimization**: Use `dotenv-rails` for managing environment variables securely instead of manually creating a `.env` file. This ensures better integration and management of sensitive data.

  Add `dotenv-rails` to your Gemfile:

  ```ruby
  gem 'dotenv-rails', groups: [:development, :test]
  ```

  Then, create a `.env` file:

  ```env
  DB_USER=postgres
  DB_PASSWORD=your_password
  DB_NAME=at_once_rails
  ```

  Load it automatically by restarting the Rails server. Sensitive values remain secure and outside version control.

---

### **2. Gem Installation**

- **Optimization**: Instead of running `bundle install --gemfile` repeatedly, run `bundle install` directly. Bundler detects the `Gemfile` in the root directory.

- **Suggestion**: Consider adding essential gems during development:
  - **`annotate`**: Automatically adds comments to models and schema.
  - **`pry-rails`**: A better debugging tool than `byebug`.
  - **`bullet`**: Identifies N+1 queries and unused eager loading.

---

### **3. Database Configuration**

- **Better Alternative**: Use database configuration for UUIDs in the Rails initializer instead of manually specifying `id: :uuid` in migrations.

  Add this to `config/initializers/active_record_uuid.rb`:

  ```ruby
  Rails.application.config.active_record.primary_key = :uuid
  ```

  This ensures all future migrations automatically use UUID as the default primary key type without explicitly defining it.

- **Command Improvement**: Instead of using `rails db:drop db:create db:migrate` repeatedly during resets, consider:

  ```bash
  rails db:reset
  ```

  This command drops, creates, and migrates the database in a single step.

---

### **4. Database Migrations**

- **Optimization**: Combine multiple migrations into a single file to reduce migration clutter and ensure atomic operations:

  ```bash
  rails generate migration CreateInitialTables
  ```

  Then, in the generated file, define all tables:

  ```ruby
  class CreateInitialTables < ActiveRecord::Migration[7.0]
    def change
      create_table :orders, id: :uuid do |t|
        t.datetime :order_date
        t.string :status
        t.uuid :user_id
        t.datetime :deleted_at, index: true
      end

      create_table :order_items, id: :uuid do |t|
        t.integer :quantity
        t.uuid :product_id
        t.uuid :order_id
        t.datetime :deleted_at, index: true
      end

      # Other tables here...
    end
  end
  ```

---

### **5. Devise User Authentication**

- **Improvement**: Add role-based access control directly to Devise:

  - Add a `role` column to the `users` table:
    ```bash
    rails generate migration AddRoleToUsers role:string
    ```
  - Define a `role` in the `User` model and set default values:
    ```ruby
    class User < ApplicationRecord
      enum role: { admin: 'admin', user: 'user', guest: 'guest' }
      after_initialize { self.role ||= :user if new_record? }
    end
    ```

- **Alternative**: Use `cancancan` for more robust authorization management:
  ```ruby
  gem 'cancancan', '~> 3.0'
  ```

---

### **6. Localization (i18n)**

- **Improvement**: Dynamically load all locale files instead of manually managing them in the `config/locales` directory.

  Update `config/application.rb`:

  ```ruby
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  ```

- **Suggestion**: Use the `rails-i18n` gem for common translations:

  ```ruby
  gem 'rails-i18n'
  ```

  It provides pre-translated Rails texts (e.g., validation messages) for multiple locales.

---

### **7. Role Seeding**

- **Optimization**: Check for existing roles before creating them in `db/seeds.rb`:

  ```ruby
  roles = %w[admin user guest]
  roles.each do |role|
    Role.find_or_create_by(name: role)
  end
  ```

  This prevents duplicate entries during subsequent seed executions.

---

### **8. Tailwind CSS Integration**

- **Better Option**: Use Tailwind CSS via PostCSS for full customization instead of CDN. Install it properly:

  ```bash
  rails new myapp --css tailwind
  ```

  Alternatively, if the project already exists:

  ```bash
  rails css:install:tailwind
  ```

  This sets up Tailwind CSS properly within the Rails asset pipeline.

- **Improvement**: Remove unnecessary CDN links for a cleaner setup, as PostCSS provides a more maintainable Tailwind workflow.

---

### **9. Application Performance**

- **Optimization**: Use eager loading to minimize N+1 query problems. Add this in `config/application.rb`:

  ```ruby
  config.eager_load_paths += %W[#{config.root}/lib]
  ```

- **Improvement**: Add caching for roles or other frequently accessed data to improve performance:
  ```ruby
  Rails.cache.fetch('roles') { Role.pluck(:name) }
  ```

---

### **10. Miscellaneous Improvements**

- **Controller Best Practices**: Use strong parameters to avoid potential mass-assignment vulnerabilities:

  ```ruby
  def role_params
    params.require(:role).permit(:name)
  end
  ```

- **Cleaner Code**: Replace manual validation removal (e.g., in `HomePageController`) with concise model updates:

  ```ruby
  validates :description, presence: false
  ```

- **Modern Rails Practices**: Consider using ViewComponents for reusable and clean UI components:
  ```bash
  bundle add view_component
  ```

---

### **Conclusion**

These suggestions will make the application setup more robust, maintainable, and performant. The optimizations reduce manual overhead and help follow modern Rails best practices.
