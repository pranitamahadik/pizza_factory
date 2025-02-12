require 'rails_helper'
RSpec.describe Topping, type: :model do

  let!(:topping) { FactoryBot.create(:topping, name: 'Black Olive', category: 'veg', price: 20)}

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
