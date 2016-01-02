# rails_simple_repository
A simple Rails Repository pattern implementation

# Purpose
The purpose of the repository pattern is "to separate the logic that retrieves the data and maps it to the entity model from the business logic that acts on the model. The business logic should be agnostic to the type of data that comprises the data source layer. For example, the data source layer can be a database, a SharePoint list, or a Web service.
The repository mediates between the data source layer and the business layers of the application. It queries the data source for the data, maps the data from the data source to a business entity, and persists changes in the business entity to the data source. A repository separates the business logic from the interactions with the underlying data source or Web service. The separation between the data and business tiers has three benefits:
It centralizes the data logic or Web service access logic.
It provides a flexible architecture that can be adapted as the overall design of the application evolves."
Source: [https://msdn.microsoft.com/en-us/library/ff649690.aspx](https://msdn.microsoft.com/en-us/library/ff649690.aspx)


# Usage
1. Create a base repository with all the **generic** methods you require (i.e. ones that will apply to every model)
  i.e. 
  ```
    # app/repositories/repository.rb
    class Repository
      attr_accessor :class_type

      def initialize(cls_type)
        raise 'Unable to initialize Repository. A class type must be specified!' if cls_type.nil?
    
        @class_type = cls_type
      end

      def find(id)
        @class_type.find(id)
      end
      
      def find_by(hash_arg)
        @class_type.find_by(hash_arg)
      end

      def all
        @class_type.all
      end
    
      def create(attributes={})
        @class_type.create(attributes)
      end
    
      def update(instance, attrs={})
        instance.update(attrs)
      end
    
      def save(instance)
        instance.save
      end
      
      # Add more methods here
      
    end
  ```

  See [Repository.rb](/example/app/repositories/repository.rb) for a working example.
2. Create a repository for each model type that you would like to use, that inherits from the recently created repository
  i.e.
  ```
    class UserRepository < Repository
      def initialize
        super(User) # pass the Model's class to the parent Repository instance, using super()
      end
      
      # Add methods here that are only relevant to the User model
      # Add method overrides here, too
      
    end
  ```
  
  See [user_repository.rb](/example/app/repositories/user_repository.rb) for a working example.
3. Include the repository in your controller, like so:
  ```
    class UsersController < ApplicationController
      before_action :initialize_repositories
      
      def edit
        @user = @user_repository.find(params[:id])
      end
      
      
      private
      
      def initialize_repositories
       # require the user repository
       require_relative '../repositories/user_repository'
       
       # Define the repostiory instance
       @user_repository = UserRepository.new
      end
      
    end
  ```
  See [users_controller.rb](/example/app/controllers/users_controller.rb) for a working example.
4. Rather than calling ```Model.method``` (i.e. ```User.find()```), call ```@user_repository.find()```
5. If you want to use a different database for a particular model, say, Users, simply override the appropriate methods in the UsersRepository, with the new database calls, etc.
i.e.
  ```
      class UserRepository < Repository
        def initialize
          super(NewUserModel)
        end
        
        def find_by()
          # New method for find_by()
        end
      end
  ```
  This means you can switch to a new database for a particular model, without having to change every single reference to the models' ActiveRecord methods.
  
# Example
An example application can be found in the ```example``` directory.
Please note that this application does not do anything, and is only useful as a demonstration of how I have implemented this pattern.
Model tests have been added to further demonstrate a repository's functionality.

# Contributing
If you find any errors/issues with this implementation, please feel free to:

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

