p "Destroying users..."
User.destroy_all

p "Destroying projects..."
Project.destroy_all

p "Destroying positions..."
Position.destroy_all

p "Creating users..."
user_test = User.new(email: "alban.porcheron@gmail.com", password: "coucou")
user_test.save!

p "Creating projects..."
studio_project = Project.new(title: "studio")
studio_project.save!

p "Creating positions..."
position = Position.new(user: user_test, project: studio_project)
position.save!
