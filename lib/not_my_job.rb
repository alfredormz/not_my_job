module NotMyJob
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def delegate(method, options)
      to = options.fetch(:to)
      with_prefix = options.fetch(:with_prefix) { true }

      method_prefix = with_prefix ? "#{to}_" : ""
      method_name = "#{method_prefix}#{method}"

      define_method method_name do
        object = instance_variable_get "@#{to}"
        object.public_send method
      end
    end
  end
end
