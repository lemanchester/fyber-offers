require "acceptance_helper"

describe "the index", :type => :feature do

  describe "/" do

    it "show the form" do
      visit '/'

      expect(page).to have_content 'uid'
      expect(page).to have_content 'pub0'
      expect(page).to have_content 'page'
    end

    it "fill the form and send" do
      visit '/'

      fill_in 'uid',  with: '157'
      fill_in 'pub0', with: 'player1'
      fill_in 'page', with: '1'

      click_on('Submit')

      expect(page).to have_content 'Title'
    end

  end



end
