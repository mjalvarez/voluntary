module StoryFactoryMethods
  def new_story(name, options = {})
    factory = options[:factory] || :story
    attributes = options[:attributes] || {}
    
    attributes.merge!({name: name})
    set_story_defaults(attributes)
    @story = FactoryGirl.create(factory, attributes)
    
    @story.reload
  end
    
  def set_story_defaults(attributes)
    attributes[:offeror_id] ||= @me.id if @me && !attributes[:offeror_id]
    attributes[:project_id] ||= @project.id if @project && !attributes[:project_id]
  end
end

World(StoryFactoryMethods)

Given /^a story named "([^\"]*)"$/ do |name|
  new_story(name)
end

Given /^a story without tasks named "([^\"]*)"$/ do |name|
  new_story(name, factory: :story_without_tasks)
end