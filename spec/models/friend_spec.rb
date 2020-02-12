require 'rails_helper'
describe Friend do
  describe 'relationships' do
    it { should belong_to :friender }
    it { should belong_to :friendee }
  end
end
