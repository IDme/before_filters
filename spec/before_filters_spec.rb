require "spec_helper"

class TestClass

  extend BeforeFilters

  attr_accessor :first_name
  attr_accessor :last_name

  # first arg is method to be called, second is array of methods that will have the before_filter ran
  # prior to calling the first arg
  before_filter :set_first_name, :only => [:set_last_name]

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def set_last_name(last_name = nil)
    puts "original method"
    self.last_name = last_name
  end

  def set_first_name
    puts "called during before_filter"
    self.first_name = "First"
  end

end

describe BeforeFilters do

  it "should run the before_filter method" do
    test = TestClass.new
    test.set_last_name("Last")

    expect(test.name).to eq("First Last")
  end

end
