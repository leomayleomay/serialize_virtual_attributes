require "active_support"
require "active_record"

require "serialize_virtual_attributes/version"

module SerializeVirtualAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def serialize_virtual_attrs(*attrs, opts)
      if attrs.nil? or (attrs.compact! and attrs.empty?)
        raise ArgumentError.new("No virtual attributes provided")
      end

      to = HashWithIndifferentAccess.new(opts).fetch(:to) rescue nil

      if to.blank?
        raise ArgumentError.new("No serialized column provided")
      end

      if self.column_names.index(to.to_s).nil?
        raise ArgumentError.new("`#{to}` is not a valid column of table `#{self.table_name}`")
      end

      attrs.each do |attr|
        if self.column_names.index(attr.to_s).present?
          raise ArgumentError.new("`#{attr}` is not supposed to be a virtual attribute")
        end

        define_method "#{attr}=" do |val|
          self.public_send(to).send('[]=', attr, val)
        end

        define_method attr do
          self.public_send(to).send('[]', attr)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, SerializeVirtualAttributes)
