require 'test/unit'
require 'fileutils'

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../../lib"

# For this while, let's load all generators by hand
require 'generator/generators/app'

class GeneratorTestCase < Test::Unit::TestCase
  include FileUtils

  def destination_root
    "#{File.dirname(__FILE__)}/../fixtures/tmp"
  end

  def setup
    mkdir_p(destination_root)
    rm_rf(destination_root)
  end

  def test_truth
    # don't complain, test/unit
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure 
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
  alias :silence :capture
end