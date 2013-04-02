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

    it {expect(restaurant.respond_to? :place_name).to be_true }
    it {expect(restaurant.respond_to? :latitude).to be_true }

    it {expect(restaurant.place_name).to eq "Argentina"}
    it {expect(restaurant.latitude).to eq(-34)}
  end

  context "Delegate multiple methods" do
    let(:restaurant) do
      class Restaurant
        delegate :name, :latitude, :longitude, to: :place
      end

      Restaurant.new
    end

    it {expect(restaurant.respond_to? :place_name).to be_true }
    it {expect(restaurant.respond_to? :place_latitude).to be_true }
    it {expect(restaurant.respond_to? :place_longitude).to be_true }

    it {expect(restaurant.place_name).to eq "Argentina"}
    it {expect(restaurant.place_latitude).to eq(-34)}
    it {expect(restaurant.place_longitude).to eq(-58)}
  end

  context "The delegate object is nil" do
    let(:restaurant) do
      class Restaurant
        delegate :name, to: :some_object
      end

      Restaurant.new
    end
    it {expect{restaurant.some_object_name}.to raise_error(NoMethodError)}
  end

  context "The delegate object is nil but a block is provided" do
    let(:restaurant) do
      class Restaurant
        delegate :name, to: :some_object do
          "No data found"
        end
      end

      Restaurant.new
    end
    it {expect(restaurant.some_object_name).to eq "No data found"}
  end

end
