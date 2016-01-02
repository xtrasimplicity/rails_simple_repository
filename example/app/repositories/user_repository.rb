class UserRepository < Repository
  def initialize
    super(User) # Initialize a new instancce of the Repository class, passing 'User' as a parameter, which will be initialized as the @class_type variable within the Repository class
  end

  # Only overrides or methods that ONLY relate to the User class need to go here. #
  # All other methods are inherited from the Repository class. #
  
  # Example of an override
  def example_override(id)
    # code goes here
  end
end
