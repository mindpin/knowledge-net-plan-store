require "spec_helper"

module KnowledgeNetPlanStore
  describe Plan do
    let(:user)     {::User.create}
    let(:plan)     {Plan.create :title => "plan1", :desc => "desc"}
    let(:topic)    {plan.topics.create :title => "topic1", :desc => "desc"}
    let(:tutorial) {topic.tutorials.create :title => "topic1", :desc => "desc"}

    subject {plan}

    before(:each) {tutorial.with_learner(user).learn!}

    it "serializes to json" do
      hash = JSON.parse(plan.json)

      hash["id"].should eq plan.id.to_s
      hash["title"].should eq plan.title
      hash["topics"][0]["id"].should eq topic.id.to_s
      hash["topics"][0]["title"].should eq topic.title
      hash["topics"][0]["tutorials"][0]["id"].should eq tutorial.id.to_s
      hash["topics"][0]["tutorials"][0]["title"].should eq tutorial.title
      hash["topics"][0]["tutorials"][0]["is_learned"].should eq true
    end
  end
end
