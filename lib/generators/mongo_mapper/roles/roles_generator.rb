require 'rails3_artifactor'
require 'logging_assist'

module MongoMapper 
  module Generators
    class RolesGenerator < Rails::Generators::Base      
      desc "Add role strategy to a MongoMapper User model" 

      argument     :user_class,   :type => :string,   :default => 'User',           :desc => "User class name"
      
      class_option :strategy,     :type => :string,   :aliases => "-s",   :default => 'role_string', 
                   :desc => "Role strategy to use (admin_flag, role_string, roles_string, role_strings, one_role, many_roles, roles_mask)"


      class_option :roles,        :type => :array,    :aliases => "-r",   :default => [],     :desc => "Valid roles" 
      class_option :role_class,   :type => :string,   :aliases => "-rc",  :default => 'Role', :desc => "Role class"      

      class_option :logfile,      :type => :string,   :aliases => "-l",   :default => nil,    :desc => "Logfile location"

      def apply_role_strategy
        logger.add_logfile :logfile => logfile if logfile
        logger.debug "apply_role_strategy for : #{strategy} in model #{user_class}"

        if !valid_strategy?
          say "Strategy '#{strategy}' is not valid. The valid strategies are: #{valid_strategies.join(', ')}", :red
          return
        end

        if !has_model_file?(user_class)
          say "User model #{user_class} not found", :red
          return 
        end

        if !is_mongo_mapper_model?(user_class)
          say "User model #{user_class} is not a Mongo Mapper Document", :red
          return 
        end
        
        begin 
          logger.debug "Trying to insert roles code into #{user_class}"     
                   
          insert_into_model user_class, :after => /include MongoMapper::\w+/ do
            insertion_text
          end     
        rescue Exception => e
          logger.debug"Error: #{e.message}"
        end 
        
        copy_role_class if role_class_strategy?
      end 
      
      protected                  

      extend Rails3::Assist::UseMacro
      include Rails3::Assist::BasicLogger

      use_orm :mongo_mapper

      def is_mongo_mapper_model? name
        read_model(name) =~ /include MongoMapper::\w+/
      end

      def role_class_strategy? 
        # :embed_one_role, :embed_many_roles
        [:one_role, :many_roles].include? strategy.to_sym
      end

      def valid_strategy?
        valid_strategies.include? strategy.to_sym
      end

      def valid_strategies
        # :embed_many_roles, :embed_one_role, 
        [:admin_flag, :one_role, :role_string, :many_roles, :role_strings, :roles_mask]
      end


      def copy_role_class
        logger.debug "copy_role_class: #{role_class.underscore}"
        template 'role.rb', "app/models/#{role_class.underscore}.rb"
      end

      def logfile
        options[:logfile]
      end

      def orm
        :mongo_mapper
      end

      def default_roles
        [:admin, :guest]        
      end

      def roles_to_add
        @roles_to_add ||= default_roles.concat(options[:roles]).to_symbols.uniq
      end

      def roles        
        roles_to_add.map{|r| ":#{r}" }
      end

      def role_class
        options[:role_class].classify || 'Role'
      end

      def role_strategy_statement 
        "strategy :#{strategy} #{strategy_options}"
      end

      def valid_roles_statement
        return '' if has_valid_roles_statement?
        roles ? "valid_roles_are #{roles.join(', ')}" : ''
      end

      def strategy_options
        return ", :role_class => :#{role_class.to_s.underscore}" if role_class_strategy? && role_class.to_s != 'Role'
        ''
      end

      def has_valid_roles_statement? 
        !(read_model(user_class) =~ /valid_roles_are/).nil?
      end

      def insertion_text
        %Q{include Roles::#{orm.to_s.camelize} 
  #{role_strategy_statement}
  #{valid_roles_statement}}
      end

      def strategy
        options[:strategy]                
      end
    end
  end
end