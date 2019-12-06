require './enumerable_methods'

describe 'Enumerable' do
  describe '#my_each' do
    it "should work on arrays" do
      expect { [1,2,3].my_each { |x| puts x } }.not_to raise_error
    end

    it "should not work on strings" do
      expect { "hello".my_each { |x| puts x } }.to raise_error NoMethodError
    end

    it "should not work on integers" do
      expect { 1.my_each { |x| puts x} }.to raise_error NoMethodError
    end

  end

  describe '#count' do
    it 'returns the correct number of items in the array' do
      expect([1,2,3].count).to eql 3
    end

    it 'returns the correct number of items equal to the block' do
      expect([1,2,3,4].count { |x| x.even? }).to eql 2
    end

    it 'returns the correct number of items from a given parameter' do
      expect([1,2,3,2,3,1,2,3].count(1)).to eql 2
    end
  end

  describe '#my_map' do
    it "returns a modified array using the block" do
      expect([1,2,3].my_map { |x| x + 10 }).to eql [11,12,13]
    end

    it "returns a modified array from an explicitly passed block" do
      block = Proc.new {|x| x - 2}
      expect([1,2,3].my_map(&block)).to eql [-1, 0, 1]
    end
  end

  describe '#my_all?' do
    it "returns true if all values in array passed to block are true" do
      expect([2,4,6,8].my_all? { |x| x.even? }).to be true
    end

    it "returns false if at least one element passed to block returns false" do
      expect([2,3,4,6,8].my_all? { |x| x.even? }).to be false
    end
  end

  describe '#multiply_els' do
    it "multiplies all elements in array" do
      expect(multiply_els([1,2,3])).to eql 6
    end

    it "returns error if given integer" do
      expect { multiply_els(10) }.to raise_error NoMethodError
    end

    it "returns error if given string" do
      expect { multiply_els("hello") }.to raise_error NoMethodError
    end
  end

  describe '#my_inject' do
    it "uses first item from array if no parameter given" do
      expect([1,2,3].my_inject { |total, item| total + item} ).to eql 6
    end

    it "uses integer from parameter as starting total" do
      expect([1,2,3].my_inject(5) { |total, item| total + item }).to eql 11
    end

    it "applies symbol to all elements of array if given as parameter" do
      expect([10, 4, 2].my_inject(:-)).to eql 4
    end
  end

end