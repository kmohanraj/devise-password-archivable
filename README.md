# Devise Password Archivable


Create rails app,
```

rails new devise-password-archivable

```

### Devise

Add devise gem
```

gem 'devise'

``` 

Then bundle install and generate devise,
```

rails g devise:install

```

Then generate model,
```

rails g devise user

```

Then add authenticate_user to,

app/controllers/application_controller.rb
```

before_action :authenticate_user!


```


Then create and migrate database table,
```

rails db:create db:migrate

```

### Devise security extension

```

gem 'devise_security_extension', git: 'https://github.com/phatworx/devise_security_extension.git'

```

Then bundle install & devise security extension,
```

rails g devise_security_extension:install

```

Add password archivable to devise model,

```

devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :password_archivable

```

### Devise security extension configuration

Uncomment following configuration lines in the path,
 config/initializers/devise_security_extension.rb


```

Devise.setup do |config|
  # ==> Security Extension
  # Configure security extension for devise

  # How many passwords to keep in archive
  config.password_archiving_count = 5

  # Deny old password (true, false, count)
  config.deny_old_passwords = true


end

```

### Create Old Password Table

```

rails g migration CreateOldPasswordsTable

```

Migration edit like to,

```

class CreateOldPasswordsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :old_passwords do |t|
	  t.string :encrypted_password, :null => false
	  t.string :password_archivable_type, :null => false
	  t.integer :password_archivable_id, :null => false
	  t.datetime :created_at
	end

	add_index :old_passwords, [:password_archivable_type, :password_archivable_id], :name => :index_password_archivable
  end
end


``` 

Then migrate db,
```

rails db:migrate

```

### Then start rails server

```

rails s 

```




