require 'rails_helper'

describe User, :type => :model do

  it { is_expected.to have_one :profile }
  it { is_expected.to have_many :languages }

end