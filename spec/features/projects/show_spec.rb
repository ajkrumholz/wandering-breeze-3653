require 'rails_helper'

RSpec.describe 'project show page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
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
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content(@news_chic.name)
      expect(page).to have_content(@news_chic.material)
      expect(page).to_not have_content(@boardfit.name)
      expect(page).to_not have_content(@boardfit.material)
    end

    it 'displays the challenge theme' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content(@recycled_material_challenge.theme)
      expect(page).to_not have_content(@furniture_challenge.theme)
    end

    it 'displays the number of participating contestants' do
      visit "/projects/#{@news_chic.id}"
      
      expect(page).to have_content("Number of Contestants: 2")

      visit "/projects/#{@upholstery_tux.id}"

      expect(page).to have_content("Number of Contestants: 2")
    end
  end
end