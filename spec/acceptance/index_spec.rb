require "acceptance_helper"

describe "the index", :type => :feature do

  describe "/" do

    context "when accessing the root path" do
      it "show the form" do
        visit '/'

        expect(page).to have_content 'uid'
        expect(page).to have_content 'pub0'
        expect(page).to have_content 'page'
      end
    end

    context "when I fill the form and get a good response" do
      let(:offers) do
        Fyber::Offer.parse(parsed_response("offers_response.json")["offers"])
      end
      let(:image) do
        "http://cdn.sponsorpay.com/assets/1808/icon175x175-2_square_60.png"
      end
      before do
        allow_any_instance_of(Fyber::Client).to receive(:offers){ offers }
      end

      it "return a list of offers" do
        visit '/'

        fill_in 'uid',  with: '157'
        fill_in 'pub0', with: 'player1'
        fill_in 'page', with: '1'

        click_on('Submit')

        expect(page).to have_content 'Tap  Fish'
        expect(page).to have_content '90'
        expect(page).to have_xpath("//img[contains(@src, \"#{image}\")]")

      end

    end

    context "when the api return an error" do
      let(:error) { Fyber::InvalidResponseSignature.new }
      before do
        allow_any_instance_of(Fyber::Client).to receive(:offers){ raise error }
      end

      it "return a list of offers" do
        visit '/'

        fill_in 'uid',  with: '157'
        fill_in 'pub0', with: 'player1'
        fill_in 'page', with: '1'

        click_on('Submit')

        expect(page).to have_content error.message
      end
    end

  end



end
