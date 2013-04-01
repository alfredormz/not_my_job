require 'spec_helper'

describe Module do

  class Place
    attr_accessor :name, :latitude, :longitude
    def initialize(name, latitude=nil, longitude=nil)
      @name      = name
      @latitude  = latitude
      @longitude = longitude
    end
  end

  class Restaurant
    include NotMyJob

    attr_accessor :place
    def initialize(place=nil)
      @place = place || Place.new("Argentina", -34, -58)
    end
  end

  context "Simple delegation" do
    let(:restaurant) do
      class Restaurant
        delegate :name, to: :place
        delegate :latitude, to: :place, with_prefix: false
      end

      Restaurant.new
    end

    it {expect(restaurant.place_name).to eq "Argentina"}
    it {expect(restaurant.latitude).to eq(-34)}
  end
end
