# encoding: utf-8
require 'rubygems'
require 'bundler/setup'

require 'serialize_virtual_attributes'

RSpec.configure do |config|
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html
end

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.dirname(__FILE__) + "/test.sqlite3"
)

load File.dirname(__FILE__) + '/support/schema.rb'
