require 'spec_helper'

describe Lappen::Callbacks do
  describe 'included' do
    let(:pipeline) do
      Class.new(Lappen::Pipeline).tap do |klass|
        klass.__send__(:include, described_class)
      end
    end

    [:before, :around, :after].each do |callback|
      method_name = "#{callback}_perform"

      it "adds a #{method_name} method" do
        expect(pipeline).to respond_to(method_name)
      end
    end
  end
end
