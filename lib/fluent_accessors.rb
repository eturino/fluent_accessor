require "fluent_accessors/version"

module FluentAccessors
  def fluent_accessor(*fields, set_method: true, writer_method: true)
    Runner.new(self, fields, set_method, writer_method).call
  end

  class Runner
    attr_reader :klass, :fields, :setter_enabled, :writer_enabled

    def initialize(klass, fields, setter_enabled, writer_enabled)
      @klass          = klass
      @fields         = fields
      @setter_enabled = setter_enabled
      @writer_enabled = writer_enabled
    end

    def call
      create_writer
      fields.each do |field|
        deal_with_field(field)
      end
    end

    private
    def create_writer
      if writer_enabled
        klass.send :attr_writer, *fields
      end
    end

    def deal_with_field(field)
      getter        = field
      normal_setter = "#{field}="
      fluent_setter = "set_#{field}"
      instance_var  = "@#{field}"

      create_setter(fluent_setter, normal_setter)
      create_fluent(fluent_setter, getter, instance_var, normal_setter)
    end

    def create_fluent(fluent_setter, getter, instance_var, normal_setter)
      klass.send :define_method, getter do |*args, &block|
        if args.empty?
          instance_variable_get instance_var
        else
          if respond_to? fluent_setter
            send fluent_setter, *args, &block
          elsif respond_to? normal_setter
            send normal_setter, *args, &block
          else
            instance_variable_set instance_var, args.first
          end

          self
        end
      end
    end

    def create_setter(fluent_setter, normal_setter)
      if setter_enabled
        # fluent setter that calls the normal setter and returns self
        klass.send :define_method, fluent_setter do |value, &block|
          send normal_setter, value, &block
          self
        end
      end
    end

  end
end
