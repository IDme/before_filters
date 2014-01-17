require "before_filters/version"

module BeforeFilters

  # method that is invoked when a new instance method is added  to class
  def method_added(method_name)

    # do not add to filer chain on a method if it already exists on the method
    return unless self.instance_methods(false).include?(method_name)
    return if filters.keys.include?(method_name) || filtered_methods.include?(method_name)
    return unless filters.keys.select { |key| filters[key].include?(instance_method(method_name).name) }

    add_filters_to(method_name)
  end

  # DSL method that classes use to add before filters
  def before_filter(method_name, options = {})
    raise StandardError, "List of filters must be a whitelist"  unless options.has_key?(:only)
    raise StandardError, "List of filters must be an array"     unless options[:only].kind_of?(Array)
    filters[method_name] = options[:only]
  end

  # keeps track of all before filters
  def filters
    @filters ||= {}
  end

  private

  # keeps track of all currently filtered methods
  def filtered_methods
    @filtered_methods ||= []
  end

  def add_filters_to(method_name)
    # add this method to known hook mappings to avoid infinite
    # recursion when we redefine the method below
    filtered_methods << method_name

    original_method = instance_method(method_name)

    define_method(method_name) do |*args, &block|
      # invoke the filter methods
      self.class.filters.each do |filter|
        method(filter[0]).call if filter[1].include?(original_method.name)
      end

      # now invoke the original method
      original_method.bind(self).call(*args, &block)
    end
  end

end