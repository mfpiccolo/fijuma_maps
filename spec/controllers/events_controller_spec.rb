require 'spec_helper'

describe EventsController do
  context 'routing' do
    it {should route(:get, '/events/new').to :action => :new}
    it {should route(:post, '/events').to :action => :create}
    it {should route(:get, '/events/1/edit').to :action => :edit, :id => 1}
    it {should route(:put, '/events/1').to :action => :update, :id => 1}
    it {should route(:delete, '/events/1').to :action => :destroy, :id => 1}
    it {should route(:get, '/events').to :action => :index}
    it {should route(:get, "/events/1").to :action => :show, :id => 1}
  end

  context 'GET new' do
    before {get :new}

    it {should render_template :new}
  end

  context 'POST create' do
    context 'with valid parameters' do
      
      let(:valid_attributes) {{:address => '1234 Whever Dr., Fair Oaks, CA 95628', :id => 1}}
      let(:valid_parameters) {{:event => valid_attributes}}

      it 'creates a new event' do
        expect {post :create, valid_parameters}.to change(Event, :count).by(1)
      end

      before {post :create, valid_parameters}

      # it {should redirect_to event_path(event_id)}
      it {should set_the_flash[:notice]}
    end

    context 'with invalid parameters' 
    #   let(:invalid_attributes) {{: => ''}}
    #   let(:invalid_parameters) {{:contact => invalid_attributes}}
    #   before {post :create, invalid_parameters}

    #   it {should render_template :new}
    # end
  end

  context "GET #show" do
    let(:event) {FactoryGirl.create(:event)}
    before {get :show, id: event.id}

    it "assigns the requested contact to @contact" do
      get :show, id: event
      assigns(:event).should eq event
    end

    it {should render_template :show}
  end

  context 'GET edit' do
    let(:event) {FactoryGirl.create :event}
    before {get :edit, :id => event.id}

    it {should render_template :edit}
  end

  context 'PUT update' do
    let(:event) {FactoryGirl.create :event}

    context 'with valid parameters' do
      let(:valid_attributes) {{:address => '1234 Whever Dr., Fair Oaks, CA 95628'}}
      let(:valid_parameters) {{:id => event.id, :event => valid_attributes}}

      before {put :update, valid_parameters}

      it 'updates the event' do
        Event.find(event.id).address.should eq valid_attributes[:address]
      end

      it {should redirect_to Event.last}
      it {should set_the_flash[:notice]}
    end
  end

  context 'DELETE destroy' do
    it 'destroys a event' do
      event = FactoryGirl.create :event
      expect {delete :destroy, {:id => event.id}}.to change(Event, :count).by(-1)
    end

    let(:event) {FactoryGirl.create :event}
    before {delete :destroy, {:id => event.id}}

    it {should redirect_to events_path}
    it {should set_the_flash[:notice]}
  end

  context 'GET index' do
    before {get :index}

    it {should render_template :index}
  end
end

