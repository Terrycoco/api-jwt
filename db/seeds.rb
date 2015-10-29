u1 = User.new
u1.firstname = "John"
u1.lastname = "Doe"
u1.email = "example@railstutorial.org"
u1.password = "johnspwd"
u1.password_confirmation = "johnspwd"
u1.save

u1 = User.new
u1.firstname = "Jane"
u1.lastname = "Doe"
u1.email = "jane@example.com"
u1.password = "janespwd"
u1.password_confirmation = "janespwd"
u1.save

u1 = User.new
u1.firstname = "Joe"
u1.lastname = "Blow"
u1.email = "joe@example.com"
u1.password = "joespwd"
u1.password_confirmation = "joespwd"
u1.save
