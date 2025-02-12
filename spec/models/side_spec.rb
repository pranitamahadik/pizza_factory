require 'rails_helper'
RSpec.describe Side, type: :model do

  let!(:side) { FactoryBot.create(:side, name: 'Cold drink', price: 55)}

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
