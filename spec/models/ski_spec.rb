require 'rails_helper'

RSpec.describe Ski, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:brand) }
  end
end
