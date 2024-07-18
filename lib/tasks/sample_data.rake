desc "Fill the database tables with some sample data"
task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    User.destroy_all
    Project.destroy_all
    ProjectAssignment.destroy_all
    Task.destroy_all
    TaskAssignment.destroy_all
    TaskUpdate.destroy_all
  end

  usernames = Array.new{[]}

  usernames << ["alice", "cooper"]
  usernames << ["bob", "backlund"]

  usernames.each do |username|
    User.create(
      email: "#{username[0]}@example.com",
      password: "password",
      first_name: username[0].downcase,
      last_name: username[1].downcase,
    )
  end

  # create users
  15.times do
    first = Faker::Name.first_name
    last = Faker::Name.last_name

    User.create(
      email: "#{first}@example.com",
      password: "password",
      first_name: first,
      last_name: last,
    ).tap { |u| u.errors.full_messages }
  end

  pp "15 users created"

  users = User.all

  # create projects
  5.times do 
    Project.create(
      creator_id: users.sample.id,
      name: Faker::Sport.sport,
      description: Faker::Music::SmashingPumpkins.lyric,
      complete: [true, false].sample
    ).tap { |p| p.errors.full_messages }
  end

  pp "5 projects created"

  projects = Project.all

  # create project assignments
  10.times do 
    ProjectAssignment.create(
      user_id: users.sample.id,
      project_id: projects.sample.id,
      role: ["admin", "user"].sample
    ).tap { |pa| pa.errors.full_messages }
  end

  pp "10 project assignments created"

  # create tasks
  25.times do
    Task.create(
      project_id: projects.sample.id,
      title: Faker::Music::SmashingPumpkins.song,
      description: Faker::Games::Myst.quote,
      creator_id: users.sample.id,
      status: ["unassigned", "assigned", "in progress", "completed"].sample
    ).tap { |t| t.errors.full_messages }
  end

  pp "25 tasks created"

  tasks = Task.all

  # create task assignments
  50.times do 
    TaskAssignment.create(
      user_id: users.sample.id,
      task_id: tasks.sample.id
    ).tap { |ta| ta.errors.full_messages }
  end

  pp "50 task assignments created"

  # create task updates
  30.times do 
    TaskUpdate.create(
      task_id: tasks.sample.id,
      author_id: users.sample.id,
      body: Faker::TvShows::Simpsons.quote,
    ).tap { |tu| tu.errors.full_messages }
  end

  pp "30 task updates created"
end