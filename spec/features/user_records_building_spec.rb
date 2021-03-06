require 'spec_helper'

feature 'real estate associate adds building', %q{
  As a real estate associate
  I want to record a building
  So that I can refer back to pertinent information
  } do

# Acceptance Criteria:
# I must specify a street address, city, state, and postal code
# Only US states can be specified
# I can optionally specify a description of the building
# If I enter all of the required information in the required format,
# the building is recorded.
# If I do not specify all of the required information in the required formats,
# the building is not recorded and I am presented with errors
# Upon successfully creating a building,
# I am redirected so that I can record another building.

  scenario 'associate adds a building with valid attributes' do
    building1 = FactoryGirl.build(:building)
    count = Building.count
    visit new_building_path
    building_new_helper(building1)
    click_on 'Add Building'

    expect(Building.count).to eq(count + 1)
  end

  scenario 'associate adds a building with invalid attributes' do
    building2 = FactoryGirl.build(:building)
    count = Building.count
    visit new_building_path
    building_new_helper(building2)
    fill_in 'City', with: ""
    click_on 'Add Building'

    expect(Building.count).to eq(count)
  end

  scenario 'associate adds two buildings in a row without having to switch pages' do
    count = Building.count
    building3 = FactoryGirl.build(:building)
    building4 = FactoryGirl.build(:building)
    visit new_building_path
    building_new_helper(building3)
    click_on 'Add Building'
    building_new_helper(building4)
    click_on 'Add Building'

    expect(Building.count).to eq(count + 2)
  end

  it 'belongs to owner' do
      owner = FactoryGirl.build(:owner)
      building = FactoryGirl.build(:building, owner: owner)
      expect(building.owner_id).to eql(owner.id)
  end

end
