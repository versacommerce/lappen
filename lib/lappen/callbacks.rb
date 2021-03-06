require 'active_support/callbacks'

module Lappen
  module Callbacks
    def self.included(base)
      base.include(ActiveSupport::Callbacks)
      base.prepend(InstanceMethods)
      base.extend(ClassMethods)

      base.define_callbacks(:perform, :filter)
    end

    module InstanceMethods
      def perform(*)
        run_callbacks(:perform) { super }
      end
    end

    module ClassMethods
      [:before, :around, :after].each do |callback|
        define_method "#{callback}_perform" do |*names, &block|
          set_callback(:perform, callback, *names, &block)
        end
      end
    end
  end
end
