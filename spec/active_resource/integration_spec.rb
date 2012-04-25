require 'spec_helper'

describe %q(
  As Developer
  I order to speed up my active resources usage
  I want to use HTTP 1.1 keepalive feature
) do
  
  it "Retrieving one resource multiple times" do
    ids = %w(101 202 303)
    users = ids.map { |id| TestUser.find(id) }

    users[0].id.should == ids[0]
    users[1].id.should == ids[1]
    users[2].id.should == ids[2]

    TestHelper.logged_requests.size.should == 3
    TestHelper.persistent_requests_logged?.should be_true
  end

  it "Retrieving two resources from the same site" do
    user = TestUser.find("101")
    post = TestPost.find("202")

    user.id.should == "101"
    post.id.should == "202"

    TestHelper.logged_requests.size.should == 2
    TestHelper.persistent_requests_logged?.should be_true
  end

  it "Delete different resources from the same site" do
    TestUser.find("101").destroy
    TestPost.find("202").destroy
   
    TestHelper.logged_requests.size.should == 4
    TestHelper.persistent_requests_logged?.should be_true
  end

  it "Updating different resources from the same site" do
    user = TestUser.find("101").update_attribute(:username, "jack")
    post = TestPost.find("202").update_attribute(:title, "hi")
   
    TestHelper.logged_requests.size.should == 4
    TestHelper.persistent_requests_logged?.should be_true
  end


  it "Creating different resources on the same site" do
    user = TestUser.create(:username => "Bob")
    post = TestPost.create(:title => "Hello Bob")

    user.id.should_not be_blank
    post.id.should_not be_blank

    user.username.should == "Bob"
    post.title.should == "Hello Bob"

    TestHelper.logged_requests.size.should == 2
    TestHelper.persistent_requests_logged?.should be_true
  end
end
