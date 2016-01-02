require 'test_helper'
# Requires the User Repository class
require_relative '../../../app/repositories/user_repository'

class UserRepositoryTest < ActiveSupport::TestCase
 # Prepare test data
 setup do
  # Define repository instances
  @user_repository = UserRepository.new
 end

 test "Should initialize User Repository instance" do
  instance = UserRepository.new
  
  # Assert that the User Repository instance is not nil
  assert_not_equal(nil, instance)

  # Assert that the instance is of type UserRepository
  assert_equal(UserRepository, instance.class)

  # Assert that the instance's parent class is of type Repository
  assert_equal(Repository, instance.class.superclass)

  # Assert that the instance's parent class' @class_type variable is equal to 'User'
  # i.e. that we've instanciated the correct repository type for the User class
  assert_equal(User, instance.class_type)
 end

test "create user" do
    # Create the user
    user = create_x_users 1

    # Assert that there are NO errors
    assert_equal(0, user.errors.count)
  end

  test "find user" do
    # Create the user
    user = create_x_users 1

    # Get the user by id
    found_user = @user_repository.find(user.id)

    # Assert that the found user is not nil
    assert_not_equal(found_user, nil)

    # Assert that the found user is of type 'User'
    assert_equal(found_user.class, User)
  end

  test "find user by attribute" do
    # Create a user
    user = create_x_users 1

    # Assert that the email is not nil
    assert_not_equal(nil, user.email)

    # Get the user by email
    found_user = @user_repository.find_by(email: user.email)

    # Assert that the found user is not nil
    assert_not_equal(nil, found_user)

    # Assert that the found user is of type 'User'
    assert_equal(found_user.class, User)
  end

  test "count users" do
    number_of_existing_users = User.count
    number_of_users_to_create = 100

    # Create 100 users
    create_x_users number_of_users_to_create

    # Test the user count
    desired_number_of_users = number_of_existing_users + number_of_users_to_create
    assert_equal(desired_number_of_users, @user_repository.count)
  end

  test "destroy all users" do
    number_of_existing_users = @user_repository.count
    number_of_users_to_create = 100

    # Create 100 users
    create_x_users number_of_users_to_create

    # Test the user count
    desired_number_of_users = number_of_existing_users + number_of_users_to_create
    assert_equal(desired_number_of_users, @user_repository.count)


    # Destroy the users
    @user_repository.destroy_all

    # Test the user count again
    assert_equal(0, @user_repository.count)
  end

  test "get all users" do
    # Delete all users
    @user_repository.destroy_all

    assert_equal(0, @user_repository.count)

    # Create 10 users
    create_x_users 10

    # Assert that there is 10 Users
    assert_equal(10, @user_repository.count)
  end

  test "should return 1 error" do
    # Create a new user
    user = create_x_users 1

    # Remove the username (set to nil)
    @user_repository.update(user, username: nil)

    @user_repository.save(user)

    # Test the number of errors (should be 1)
    assert_equal(1, @user_repository.errors(user).count)
  end

  test "save user" do
    # Create a user
    user = create_x_users 1

    # save the user
    @user_repository.save(user)


    assert_equal(0, @user_repository.errors(user).count)
  end


  test "update user" do
    # Create a user
    user = create_x_users 1

    original_username = user.username
    new_username = 'NewUsersUsername'

    @user_repository.update(user, username: new_username)

    @user_repository.save(user)

    # Get the user instance again
    updated_user = @user_repository.find(user.id)
  

    # Compare the new and old usernames
    assert_equal(new_username, updated_user.username)
  end

  test "increment user attribute" do
    # Create a user
    user = create_x_users 1

    # Get number of sign_ins
    existing_number_sign_ins = user.sign_in_count

    @user_repository.increment(user, :sign_in_count, 1)

    # Get the new number of sign_ins
    new_number_sign_ins = user.sign_in_count

    assert_equal(existing_number_sign_ins + 1, new_number_sign_ins)

  end

  test "initialize new User instance (User.new)" do
    # Initialize new user with no params
    user = @user_repository.new_cls_instance

    # Test whether the instance is of type, User
    assert_equal(User, user.class)
  end
 
end
