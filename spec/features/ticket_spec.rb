require 'spec_helper'

feature "Can move from ticket index to new" do
  context "when logged in" do
    before :each do
      sign_up_as_hello_world
      visit '/tickets'
    end

    it "ticket index has a 'New Ticket' ticket to new ticket page" do
      page.should have_content "New Ticket"
    end
  end
end

feature "Creating a ticket" do
  context "when logged in" do
    before :each do
      sign_up_as_hello_world
      visit '/tickets/new'
    end

    it "has a new ticket page" do
      page.should have_content 'New Ticket'
    end

    it "takes a Event and a Description" do
      page.should have_content 'Event'
      page.should have_content 'Description'
    end

    it "validates the presence of Event" do
      fill_in 'Description', with: 'A musical fiesta for your earbuds!'
      click_button 'Create New Ticket'
      page.should have_content 'New Ticket'
      page.should have_content "Event can't be blank"
    end

    it "validates the presence of Description" do
      fill_in 'Event', with: 'SXSW'
      click_button 'Create New Ticket'
      page.should have_content 'New Ticket'
      page.should have_content "Description can't be blank"
    end

    it "redirects to the ticket show page" do
      fill_in 'Description', with: 'A musical fiesta for your earbuds!'
      fill_in 'Event', with: 'SXSW'
      click_button 'Create New Ticket'
      page.should have_content 'SXSW'
    end

    context "on failed save" do
      before :each do
        fill_in 'Event', with: 'SXSW'
      end

      it "displays the new ticket form again" do
        page.should have_content 'New Ticket'
      end

      it "has a pre-filled form (with the data previously input)" do
        find_field('Event').value.should eq 'SXSW'
      end

      it "still allows for a successful save" do
        fill_in 'Description', with: 'A musical fiesta for your earbuds!'
        click_button 'Create New Ticket'
        page.should have_content 'SXSW'
      end
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/tickets/new'
      page.should have_content 'Sign In'
    end
  end
end

feature "Seeing all tickets" do
  context "when logged in" do
    before :each do
      sign_up("foo")
      make_ticket("Coachella", "So hip and groovy, dude")
      click_on "Sign Out"
      sign_up_as_hello_world
      make_ticket("SXSW", "A musical fiesta for your earbuds!")
      make_ticket("Gambino", "A performance Kiran would really like to see.")
      visit '/tickets'
    end

    it "shows all the tickets for all users" do
      page.should have_content 'SXSW'
      page.should have_content 'Coachella'
      page.should have_content 'Gambino'
    end

    it "shows the current user's username" do
      page.should have_content 'hello_world'
    end

    it "tickets to each of the tickets with the ticket titles" do
      click_link 'SXSW'
      page.should have_content 'SXSW'
      page.should_not have_content 'Coachella'
      page.should_not have_content 'Gambino'
    end
  end

  context "when logged out" do
    it "redirects to the login page" do
      visit '/tickets'
      page.should have_content 'Sign In'
    end
  end

  context "when signed in as another user" do
    before :each do
      sign_up('hello_world')
      click_button 'Sign Out'
      sign_up('goodbye_world')
      make_ticket("Warped Tour", "Punk rock never dies!")
      click_button 'Sign Out'
      sign_in('hello_world')
    end

    it "should show others tickets" do
      visit '/tickets'
      page.should have_content 'Warped Tour'
    end
  end
end

feature "Showing a ticket" do
  context "when logged in" do
    before :each do
      sign_up('hello_world')
      make_ticket("SXSW", "A musical fiesta for your earbuds!")
      visit '/tickets'
      click_link 'SXSW'
    end

    it "displays the ticket Event" do
      page.should have_content 'SXSW'
    end

    it "displays the ticket Description" do
      page.should have_content 'A musical fiesta for your earbuds!'
    end

    it "displays a ticket back to the ticket index" do
      page.should have_content "Tickets"
    end
  end
end

feature "Editing a ticket" do
  before :each do
    sign_up_as_hello_world
    make_ticket("SXSW", "A musical fiesta for your earbuds!")
    visit '/tickets'
    click_link 'SXSW'
  end

  it "has a ticket on the show page to edit a ticket" do
    page.should have_content 'Edit Ticket'
  end

  it "shows a form to edit the ticket" do
    click_link 'Edit Ticket'
    page.should have_content 'Event'
    page.should have_content 'Description'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Ticket'
    find_field('Event').value.should eq 'SXSW'
    find_field('Description').value.should eq 'A musical fiesta for your earbuds!'
  end

  it "shows errors if editing fails" do
    click_link 'Edit Ticket'
    fill_in 'Description', with: ''
    click_button 'Update Ticket'
    page.should have_content "Edit Ticket"
    page.should have_content "Description can't be blank"
  end

  context "on successful update" do
    before :each do
      click_link 'Edit Ticket'
    end

    it "redirects to the ticket show page" do
      fill_in 'Event', with: 'Bonnaroo'
      click_button 'Update Ticket'
      page.should have_content 'Bonnaroo'
    end
  end
end