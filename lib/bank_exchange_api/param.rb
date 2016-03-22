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
              when 'String'
                String(@#{name}) if @#{name}
              when 'Integer'
                Integer(@#{name}) if @#{name}
              when 'Date'
                if @#{name}
                  @#{name}.is_a?(Date) ? @#{name} : Date.parse(@#{name}.to_s)
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
