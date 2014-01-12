module Helpers

  module Blog

    def self.applyHashToAttributes(bag, attrs, prefix="")
      bag.each do |key, value|
        if key != 'id'
          if value.is_a?(Hash)
            unless attrs.has_key?(key)
              raise ArgumentError, "Key is undefined. Must be set before merging. Key was: #{prefix}#{key}"
            end
            Helpers::Blog.applyHashToAttributes(value, attrs[key], "#{prefix}#{key}.")
          else
            Chef::Log.info("setting from databag: #{prefix}#{key}")
            attrs[key] = value
          end
        end
      end
    end

  end
end
