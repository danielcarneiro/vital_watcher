require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ActivityTypesController do

  # This should return the minimal set of attributes required to create a valid
  # ActivityType. As you add validations to ActivityType, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # describe "GET index" do
  #   it "assigns all activity_types as @activity_types" do
  #     activity_type = ActivityType.create! valid_attributes
  #     get :index
  #     assigns(:activity_types).should eq([activity_type])
  #   end
  # end

  # describe "GET show" do
  #   it "assigns the requested activity_type as @activity_type" do
  #     activity_type = ActivityType.create! valid_attributes
  #     get :show, :id => activity_type.id.to_s
  #     assigns(:activity_type).should eq(activity_type)
  #   end
  # end

  # describe "GET new" do
  #   it "assigns a new activity_type as @activity_type" do
  #     get :new
  #     assigns(:activity_type).should be_a_new(ActivityType)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested activity_type as @activity_type" do
  #     activity_type = ActivityType.create! valid_attributes
  #     get :edit, :id => activity_type.id.to_s
  #     assigns(:activity_type).should eq(activity_type)
  #   end
  # end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new ActivityType" do
  #       expect {
  #         post :create, :activity_type => valid_attributes
  #       }.to change(ActivityType, :count).by(1)
  #     end

  #     it "assigns a newly created activity_type as @activity_type" do
  #       post :create, :activity_type => valid_attributes
  #       assigns(:activity_type).should be_a(ActivityType)
  #       assigns(:activity_type).should be_persisted
  #     end

  #     it "redirects to the created activity_type" do
  #       post :create, :activity_type => valid_attributes
  #       response.should redirect_to(ActivityType.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved activity_type as @activity_type" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       ActivityType.any_instance.stub(:save).and_return(false)
  #       post :create, :activity_type => {}
  #       assigns(:activity_type).should be_a_new(ActivityType)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       ActivityType.any_instance.stub(:save).and_return(false)
  #       post :create, :activity_type => {}
  #       response.should render_template("new")
  #     end
  #   end
  # end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested activity_type" do
  #       activity_type = ActivityType.create! valid_attributes
  #       # Assuming there are no other activity_types in the database, this
  #       # specifies that the ActivityType created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       ActivityType.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
  #       put :update, :id => activity_type.id, :activity_type => {'these' => 'params'}
  #     end

  #     it "assigns the requested activity_type as @activity_type" do
  #       activity_type = ActivityType.create! valid_attributes
  #       put :update, :id => activity_type.id, :activity_type => valid_attributes
  #       assigns(:activity_type).should eq(activity_type)
  #     end

  #     it "redirects to the activity_type" do
  #       activity_type = ActivityType.create! valid_attributes
  #       put :update, :id => activity_type.id, :activity_type => valid_attributes
  #       response.should redirect_to(activity_type)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the activity_type as @activity_type" do
  #       activity_type = ActivityType.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       ActivityType.any_instance.stub(:save).and_return(false)
  #       put :update, :id => activity_type.id.to_s, :activity_type => {}
  #       assigns(:activity_type).should eq(activity_type)
  #     end

  #     it "re-renders the 'edit' template" do
  #       activity_type = ActivityType.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       ActivityType.any_instance.stub(:save).and_return(false)
  #       put :update, :id => activity_type.id.to_s, :activity_type => {}
  #       response.should render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested activity_type" do
  #     activity_type = ActivityType.create! valid_attributes
  #     expect {
  #       delete :destroy, :id => activity_type.id.to_s
  #     }.to change(ActivityType, :count).by(-1)
  #   end

  #   it "redirects to the activity_types list" do
  #     activity_type = ActivityType.create! valid_attributes
  #     delete :destroy, :id => activity_type.id.to_s
  #     response.should redirect_to(activity_types_url)
  #   end
  # end

end