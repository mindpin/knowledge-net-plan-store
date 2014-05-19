require "spec_helper"

include KnowledgeNetPlanStore

describe Plan do
  let(:plan)     {Plan.create :name => "plan1", :desc => "desc"}
  let(:topic)    {Topic.create :name => "topic1", :desc => "desc"}
  let(:tutorial) {Tutorial.create :name => "topic1", :desc => "desc"}

  subject {plan}

  before(:each) do
    plan.topics     << topic
    topic.tutorials << tutorial
  end

  it "serializes to json" do
    hash = JSON.parse(plan.json)

    hash["id"].should eq plan.id.to_s
    hash["name"].should eq plan.name
    hash["topics"][0]["id"].should eq topic.id.to_s
    hash["topics"][0]["name"].should eq topic.name
    hash["topics"][0]["tutorials"][0]["id"].should eq tutorial.id.to_s
    hash["topics"][0]["tutorials"][0]["name"].should eq tutorial.name
  end
end
