module BankExchangeApi
  class Config
    # Defines both class & instance methods
    # Works the same as *cattr_accessor* from *ActiveSupport*
    # on a class level (globally) and an instance level (locally)
    def self.conf_accessor(*names)
      names.each do |name|
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def #{name}
            @#{name} || self.class.#{name}
          end

          def #{name}!
            self.#{name} || self.class.#{name}!
          end

          def #{name}=(value)
            @#{name} = value
          end

          def self.#{name}
            @@#{name} if class_variable_defined?(:"@@#{name}")
          end

          def self.#{name}=(value)
            @@#{name} = value
          end

          def self.#{name}!
            self.#{name} || (raise ConfigurationError, "'#{name}' config param is required")
          end
        METHODS
      end
    end

    conf_accessor :api_token, :logger
  end
end
