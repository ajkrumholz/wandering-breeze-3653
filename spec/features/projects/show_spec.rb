require 'rails_helper'

RSpec.describe 'project show page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    visit "/projects/#{@news_chic.id}"
  end

  # As a visitor,
  # When I visit a project's show page ("/projects/:id"),
  # I see that project's name and material
  # And I also see the theme of the challenge that this project belongs to.
  # (e.g.    Litfit
  # Material: Lamp Shade
  # Challenge Theme: Apartment Furnishings)

  describe 'when I visit a project show page' do
    it 'displays the projects name and material' do
      expect(page).to have_content(@news_chic.name)
      expect(page).to have_content(@news_chic.material)
      expect(page).to_not have_content(@boardfit.name)
      expect(page).to_not have_content(@boardfit.material)
    end
  end
end