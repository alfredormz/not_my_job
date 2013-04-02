module NotMyJob

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def delegate(*methods, options, &block)

      unless options.is_a? Hash
        raise ArgumentError, "At least one method and the :to option are required."
      end

      to = options.fetch(:to) do
        raise ArgumentError, "The :to option is required."
      end

      with_prefix = options.fetch(:with_prefix, true)
      method_prefix = with_prefix ? "#{to}_" : ""

      methods.each do |method|
        method_name = "#{method_prefix}#{method}"

        define_method method_name do
          object = instance_variable_get("@#{to}") || self.send(to)
          begin
            object.public_send method
          rescue NoMethodError
            block_given? ? yield : raise
          end
        end
      end
    end

  end

end
