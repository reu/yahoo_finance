require "open-uri"
require "csv"
require "ostruct"

module YahooFinance
  class Historical
    include Enumerable

    attr_reader :ticker, :start_date, :end_date, :group

    BASE_URL = "http://ichart.finance.yahoo.com/table.csv"

    GROUPS = {
      :daily   => "d",
      :weekly  => "w",
      :monthly => "m"
    }

    def self.daily(ticker, options = {})
      new(ticker, options.merge(:group => GROUPS[:daily]))
    end

    def self.weekly(ticker, options = {})
      new(ticker, options.merge(:group => GROUPS[:weekly]))
    end

    def self.monthly(ticker, options = {})
      new(ticker, options.merge(:group => GROUPS[:monthly]))
    end

    def initialize(ticker, options = {})
      @ticker = ticker
      @start_date = options[:from]
      @end_date = options[:to]
      @group  = options[:group] || GROUPS[:daily]
    end

    def each(&block)
      result.reverse_each(&block)
    end

    private

    def result
      @result ||= Array.new.tap do |result|
        CSV.parse(raw_data, :return_headers => false, :converters => :all, :headers => [:date, :open, :high, :low, :close, :volume, :adjusted_close]).each_with_index do |line, index|
          next if index.zero?
          line[:date] = Date.parse(line[:date])
          result << OpenStruct.new(line.to_hash)
        end
      end
    end

    def raw_data
      @raw_data ||= open(url).read
    end

    def url
      "#{BASE_URL}?s=#{URI.escape(ticker)}&g=#{group}&ignore=.csv".tap do |url|
        if start_date
          url << "&a=#{start_date.month - 1}"
          url << "&b=#{start_date.day}"
          url << "&c=#{start_date.year}"
        end

        if end_date
          url << "&d=#{end_date.month - 1}"
          url << "&e=#{end_date.day}"
          url << "&f=#{end_date.year}"
        end
      end
    end
  end
end
