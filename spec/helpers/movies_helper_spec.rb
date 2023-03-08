# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesHelper, type: :helper do
  describe '#oddness' do
    it "returns 'odd' for an odd number" do
      expect(helper.oddness(3)).to eq('odd')
      expect(helper.oddness(29)).to eq('odd')
      expect(helper.oddness(71)).to eq('odd')
    end

    it "returns 'even' for an even number" do
      expect(helper.oddness(4)).to eq('even')
      expect(helper.oddness(28)).to eq('even')
      expect(helper.oddness(80)).to eq('even')
    end
  end
end
