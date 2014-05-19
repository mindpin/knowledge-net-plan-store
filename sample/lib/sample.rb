require "sinatra"
require "knowledge-net-plan-store"
require "./config/env"

module KnowledgeNetPlanStore
  class Sample < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    set :views, ["templates"]
    set :root, File.expand_path("../../", __FILE__)
    set :method_override, true
    register Sinatra::AssetPack
    enable :sessions

    assets {
      serve '/js', :from => 'assets/javascripts'
      serve '/css', :from => 'assets/stylesheets'

      js :application, "/js/application.js", [
           '/js/jquery-1.11.0.min.js',
           '/js/**/*.js'
         ]

      css :application, "/css/application.css", [
            '/css/**/*.css'
          ]

      css_compression :yui
      js_compression  :uglify
    }

    helpers do
      def form(model)
        model_name = model.class.to_s.split("::").last.downcase
        base_url = "/#{model_name.pluralize}"

        action, method = case
                         when model.new_record?
                           ["#{base_url}", "post"]
                         when model.persisted?
                           ["#{base_url}/#{model.id}", "put"]
                         end

        parent = case
                 when model.respond_to?(:plan)
                   :plan_id
                 when model.respond_to?(:topic)
                   :topic_id
                 end

        haml :"_form",
             :layout => false,
             :locals => {
               :model      => model,
               :method     => method,
               :action     => action,
               :parent     => parent,
               :model_name => model_name
             }
      end
    end

    get "/" do
      redirect to("/plans")
    end

    get "/plans" do
      @plans = Plan.all
      haml :"plans/index"
    end

    get "/plans/new" do
      @plan = Plan.new
      haml :"plans/new"
    end

    post "/plans" do
      plan = Plan.create params[:plan]
      redirect to("/plans/#{plan.id}")
    end

    get "/plans/:id" do
      @plan = Plan.find(params[:id])
      @topics = @plan.topics
      haml :"plans/show"
    end

    put "/plans/:id" do
      plan = Plan.find(params[:id])
      plan.update_attributes params[:plan]
      plan.save
      redirect to("/plans/#{plan.id}")
    end

    delete "/plans/:id" do
      plan = Plan.find(params[:id])
      plan.destroy
      "/plans"
    end

    post "/topics" do
      topic = Topic.create params[:topic]
      redirect to("/topics/#{topic.id}")
    end

    get "/plans/:plan_id/topics/new" do
      @topic = Topic.new(:plan_id => params[:plan_id])
      haml :"topics/new"
    end

    get "/topics/:id" do
      @topic = Topic.find(params[:id])
      @tutorials = @topic.tutorials
      haml :"topics/show"
    end

    put "/topics/:id" do
      topic = Topic.find(params[:id])
      topic.update_attributes params[:topic]
      redirect to("/topics/#{topic.id}")
    end

    delete "/topics/:id" do
      topic = Topic.find(params[:id])
      topic.destroy
      "/plans/#{topic.plan.id}"
    end

    post "/tutorials" do
      tutorial = Tutorial.create params[:tutorial]
      redirect to("/tutorials/#{tutorial.id}")
    end

    get "/topics/:topic_id/tutorials/new" do
      @tutorial = Tutorial.new(:topic_id => params[:topic_id])
      haml :"tutorials/new"
    end

    get "/tutorials/:id" do
      @tutorial = Tutorial.find(params[:id])
      haml :"tutorials/show"
    end

    put "/tutorials/:id" do
      tutorial = Tutorial.find(params[:id])
      tutorial.update_attributes params[:tutorial]
      redirect to("/tutorials/#{tutorial.id}")
    end
    
    delete "/tutorials/:id" do
      tutorial = Tutorial.find(params[:id])
      tutorial.destroy
      "/topics/#{tutorial.topic.id}"
    end
  end
end
