require 'fare'

describe Fare do
  it 'should have a minimun fare' do
    expect(!!Fare::MIN_FARE).to eq true
  end

end
