require "spec_helper"

describe YahooFinance::Historical do
  let(:ticker)     { "AAPL" }
  let(:start_date) { Date.new(2011, 11, 11) }
  let(:end_date)   { Date.new(2011, 11, 21) }

  shared_examples_for "a valid instance" do
    its(:ticker)     { should == ticker }
    its(:start_date) { should == start_date }
    its(:end_date)   { should == end_date }
    its(:group)      { should_not be_nil }
  end

  describe ".daily" do
    subject { described_class.daily ticker, :from => start_date, :to => end_date }
    it_behaves_like "a valid instance"
    its(:group) { should == YahooFinance::Historical::GROUPS[:daily] }
  end

  describe ".weekly" do
    subject { described_class.weekly ticker, :from => start_date, :to => end_date }
    it_behaves_like "a valid instance"
    its(:group) { should == YahooFinance::Historical::GROUPS[:weekly] }
  end

  describe ".monthly" do
    subject { described_class.monthly ticker, :from => start_date, :to => end_date }
    it_behaves_like "a valid instance"
    its(:group) { should == YahooFinance::Historical::GROUPS[:monthly] }
  end

  describe "#each" do
    subject { described_class.daily ticker, :from => start_date, :to => end_date }

    it "iterates by ascending date order" do
      subject.to_a.first.date.should < subject.to_a.last.date
    end

    context "when a period is specified" do
      it "returns only records after the start date" do
        subject.all? { |data| data.date >= start_date }.should be_true
      end

      it "returns only records until the end date" do
        subject.all? { |data| data.date <= end_date }.should be_true
      end
    end
  end
end
