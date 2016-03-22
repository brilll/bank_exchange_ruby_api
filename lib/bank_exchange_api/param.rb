module BankExchangeApi
  module Param
    def param(*names, klass)
      names.each do |name|
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def #{name}=(value)
            @#{name}=value
          end

          def #{name}
            @_#{name}_ ||= case #{klass}.name
              when 'Array'
                Array(@#{name})
              else
                raise UnsupportedParamClass, "Provide #{klass} class processing"
            end
          end
        METHODS
      end
    end
  end
end
