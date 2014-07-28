require "spec_helper"

include KnowledgeNetPlanStore

describe Plan do
  let(:plan)     {Plan.create :title => "plan1", :desc => "desc"}
  let(:topic)    {Topic.create :title => "topic1", :desc => "desc"}
  let(:tutorial) {Tutorial.create :title => "topic1", :desc => "desc"}

  subject {plan}

  before(:each) do
    plan.topics     << topic
    topic.tutorials << tutorial
  end

  it "serializes to json" do
    hash = JSON.parse(plan.json)

    hash["id"].should eq plan.id.to_s
    hash["title"].should eq plan.title
    hash["topics"][0]["id"].should eq topic.id.to_s
    hash["topics"][0]["title"].should eq topic.title
    hash["topics"][0]["tutorials"][0]["id"].should eq tutorial.id.to_s
    hash["topics"][0]["tutorials"][0]["title"].should eq tutorial.title
  end
end
