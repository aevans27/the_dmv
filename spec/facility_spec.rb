require 'spec_helper'
require './lib/facility'
require './lib/vehicle'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})

    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#add more services' do
    it 'registar cars' do
      @facility_1.add_service("Vehicle Registration")
      expect(@facility_1.services).to eq(["Vehicle Registration"])

      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)

      expect(@facility_1.registar_vehicle(@cruz)).to eq([@cruz])
      expect(@cruz.registration_date).to eq(Date.today)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.collected_fees).to eq(100)

      expect(@facility_1.registar_vehicle(@camaro)).to eq([@cruz, @camaro])    
      expect(@camaro.registration_date).to eq(Date.today)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
      expect(@facility_1.collected_fees).to eq(125)

      expect(@facility_1.registar_vehicle(@bolt)).to eq([@cruz, @camaro, @bolt])    
      expect(@bolt.registration_date).to eq(Date.today)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.collected_fees).to eq(325)
    end
  end

  describe '#fail to add more services' do
    it 'no service' do
      @facility_1.add_service("Vehicle Registration")
      expect(@facility_1.services).to eq(["Vehicle Registration"])

      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)

      expect(@facility_1.registar_vehicle(@cruz)).to eq([@cruz])
      expect(@cruz.registration_date).to eq(Date.today)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.collected_fees).to eq(100)

      expect(@facility_1.registar_vehicle(@camaro)).to eq([@cruz, @camaro])    
      expect(@camaro.registration_date).to eq(Date.today)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
      expect(@facility_1.collected_fees).to eq(125)

      expect(@facility_1.registar_vehicle(@bolt)).to eq([@cruz, @camaro, @bolt])    
      expect(@bolt.registration_date).to eq(Date.today)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.collected_fees).to eq(325)

      expect(@facility_2.services).to eq([])
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)

      expect(@facility_2.registar_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  describe '#registered car info' do
    it 'most popular' do
      @facility_1.add_service("Vehicle Registration")
      expect(@facility_1.services).to eq(["Vehicle Registration"])

      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)

      expect(@facility_1.registar_vehicle(@cruz)).to eq([@cruz])
      expect(@cruz.registration_date).to eq(Date.today)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.collected_fees).to eq(100)

      expect(@facility_1.registar_vehicle(@camaro)).to eq([@cruz, @camaro])    
      expect(@camaro.registration_date).to eq(Date.today)
      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
      expect(@facility_1.collected_fees).to eq(125)

      expect(@facility_1.registar_vehicle(@bolt)).to eq([@cruz, @camaro, @bolt])    
      expect(@bolt.registration_date).to eq(Date.today)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.collected_fees).to eq(325)

      expect(@facility_2.services).to eq([])
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)

      expect(@facility_2.registar_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)

      bolt1 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chev', model: 'B', engine: :ev} )
      bolt2 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chev', model: 'B', engine: :ev} )
      bolt3 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chev', model: 'B', engine: :ev} )

      @facility_1.registar_vehicle(bolt1)
      @facility_1.registar_vehicle(bolt2)
      @facility_1.registar_vehicle(bolt3)

      expect(@facility_1.most_popular_registered_make).to eq("Chev")
      expect(@facility_1.most_popular_registered_model).to eq("B")

      bolt4 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )
      bolt5 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )
      bolt6 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )
      bolt7 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )
      bolt8 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )
      bolt9 = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevy', model: 'Be', engine: :ev} )

      @facility_1.registar_vehicle(bolt4)
      @facility_1.registar_vehicle(bolt5)
      @facility_1.registar_vehicle(bolt6)
      @facility_1.registar_vehicle(bolt7)
      @facility_1.registar_vehicle(bolt8)
      @facility_1.registar_vehicle(bolt9)

      expect(@facility_1.most_popular_registered_make).to eq("Chevy")
      expect(@facility_1.most_popular_registered_model).to eq("Be")
    end
  end
end
