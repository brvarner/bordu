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
    )
  end

  pp "15 users created"

  users = User.all

  # create projects
  5.times do 
    Project.create(
      creator_id: users.sample,
      name: Faker::Sport.sport,
      description: Faker::Music::SmashingPumpkins.lyric,
      complete: [true, false].sample
    )
  end

  pp "5 projects created"

  projects = Project.all

  # create project assignments
  10.times do 
    ProjectAssignment.create(
      user_id: users.sample,
      project_id: projects.sample,
      role: ["admin", "user"].sample
    )
  end

  pp "10 project assignments created"

  # create tasks
  25.times do
    Task.create(
      project_id: projects.sample,
      title: Faker::Music::SmashingPumpkins.song,
      description: Faker::Games::Myst.quote,
      creator_id: users.sample,
      status: ["unassigned", "assigned", "in progress", "completed"].sample
    )
  end

  pp "25 tasks created"

  tasks = Task.all

  # create task assignments
  50.times do 
    TaskAssignment.create(
      user_id: users.sample,
      task_id: tasks.sample
    )
  end

  pp "50 task assignments created"

  # create task updates
  30.times do 
    TaskUpdate.create(
      task_id: tasks.sample,
      author_id: users.sample,
      body: Faker::TvShows::Simpsons.quote,
    )
  end

  pp "30 task updates created"
end