module BankExchangeApi
  module Param
    def param(*names, klass)
      names.each do |name|
        class_eval <<-METHODS, __FILE__, __LINE__ + 1
          def #{name}=(value)
            @#{name}=value
          end

          def #{name}
            value = @#{name} if defined?(@#{name})

            @_#{name}_ ||= case #{klass}.name
              when 'Array'
                Array(value)
              when 'String'
                String(value) if value
              when 'Integer'
                Integer(value) if value
              when 'Date'
                if value
                  value.is_a?(Date) ? value : Date.parse(value.to_s)
                end
              else
                raise UnsupportedParamClass, "Provide #{klass} class processing"
            end
          end

          def #{name}!
            self.#{name} || (raise MissingRequiredParam, "Param '#{name}' is required but missing")
          end
        METHODS
      end
    end
  end
end
