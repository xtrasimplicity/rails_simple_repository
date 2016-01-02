ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# require Open3 (to assist with clearing database tables, in empty_test_tables())
require 'open3'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # Empty all test database tables before each test
  # Sourced from somewhere on StackOverflow, but I can't find the source. :/
  config = ActiveRecord::Base.configurations[::Rails.env]
  connection = ActiveRecord::Base.connection
  connection.disable_referential_integrity do
    connection.tables.each do |table_name|
      next if connection.select_value("SELECT count(*) FROM #{table_name}") == 0
      case config["adapter"]
        when "mysql", "mysql2", "postgresql"
          connection.execute("TRUNCATE #{table_name}")
        when "sqlite", "sqlite3"
          connection.execute("DELETE FROM #{table_name}")
          connection.execute("DELETE FROM sqlite_sequence where name='#{table_name}'")
      end
    end
    connection.execute("VACUUM") if config["adapter"] == "sqlite3"
  end 


  def create_x_users(number_of_users)
    # Define repository instances
    @user_repository = UserRepository.new

    # Build new_user parameters
    params = {
            username: 'username',
            email: 'username@domain.com',
        }

    if number_of_users.is_a?(Integer)
      last_created_user = nil

      number_of_users.times do |i|
        # Build the user params
        params[:username] = "user#{i}"
        params[:email] = "user@xyz#{i}.com"

        last_created_user = @user_repository.create(params)
      end

      return last_created_user if number_of_users == 1
    end
  end

end
