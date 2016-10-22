require 'test_helper'

class CognitivebingTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Cognitivebing::VERSION
  end

  def test_constructor
    bing = CognitiveBing.new('testkey', {:SomeParam => 'test'})
    assert_equal(true, bing.respond_to?(:account_key))
    assert_equal(true, bing.respond_to?(:params))
  end
  
  
  def test_search    
    web = CognitiveBing.new(key)
    results = web.search("tiger")
    assert results[0][:_type]=~/SearchResponse/i
  end
end
