require 'rails_helper'
RSpec.describe Pizza, type: :model do

  let!(:pizza) { FactoryBot.create(:pizza, name: 'Deluxe Veggie', category: 'veg', price_regular: 150, price_medium: 200, price_large: 325)}

  describe 'Validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:price_regular) }
    it { is_expected.to validate_presence_of(:price_medium) }
    it { is_expected.to validate_presence_of(:price_large) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:order_pizzas) }
  end
end
