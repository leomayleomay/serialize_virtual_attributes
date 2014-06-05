require 'spec_helper'

describe SerializeVirtualAttributes do
  describe ".serialize_virtual_attrs" do
    it "raises error if no virtual attributes provided" do
      expect do
        class Person < ActiveRecord::Base
          serialize_virtual_attrs nil, to: :fullname
        end
      end.to raise_error(
        ArgumentError,
        "No virtual attributes provided"
      )
    end

    it "raises error the virtual attributes are not that virtual" do
      expect do
        class Person < ActiveRecord::Base
          serialize_virtual_attrs :fullname, to: :fullname
        end
      end.to raise_error(
        ArgumentError,
        "`fullname` is not supposed to be a virtual attribute"
      )
    end

    it "raises error if no destination provided" do
      expect do
        class Person < ActiveRecord::Base
          serialize_virtual_attrs :first_name, :last_name, to: nil
        end
      end.to raise_error(
        ArgumentError,
        "No serialized column provided"
      )
    end

    it "raises error if the destination is not a field of the object" do
      expect do
        class Person < ActiveRecord::Base
          serialize_virtual_attrs :first_name, :last_name, to: :body
        end
      end.to raise_error(
        ArgumentError,
        "`body` is not a valid column of table `people`"
      )
    end

    it "appends the virtual attributes to the attr_accessible" do
      class Person < ActiveRecord::Base
        serialize_virtual_attrs :first_name, :last_name, to: :fullname
      end

      expect(Person.accessible_attributes).to include(:first_name)
      expect(Person.accessible_attributes).to include(:last_name)
    end

    it "saves the virtual attributes in the serialized column" do
      class Person < ActiveRecord::Base
        serialize :fullname, Hash
        serialize_virtual_attrs :first_name, :last_name, to: :fullname
      end

      person = Person.new(first_name: "hao", last_name: "liu")

      expect(person.fullname[:first_name]).to eq "hao"
      expect(person.fullname[:last_name]).to eq "liu"
    end

    it "loads the virtual attributes from the serialized column" do
      class Person < ActiveRecord::Base
        serialize :fullname, Hash
        serialize_virtual_attrs :first_name, :last_name, to: :fullname
      end

      person = Person.create(first_name: "hao", last_name: "liu")
      person.reload

      expect(person.first_name).to eq "hao"
      expect(person.last_name).to eq "liu"
    end
  end
end
