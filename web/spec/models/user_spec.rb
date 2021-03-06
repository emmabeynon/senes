require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many(:identities).dependent(:destroy) }
end
