ActiveRecord::Schema.define do
  self.verbose = false

  create_table :people, force: true do |t|
    t.string :fullname

    t.timestamps
  end
end
