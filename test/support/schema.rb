require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end