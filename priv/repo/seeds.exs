alias AssociationElixir.Accounts

%{
  first_name: "Rushikesh",
  last_name: "Pandit",
  user_name: "user",
  password: "rushikesh@pandit.com",
  password_confirmation: "rushikesh@pandit.com",
  email: "user@pandit.com",
  role: "USER"
}
|> Accounts.create_user()

%{
  first_name: "Rushikesh",
  last_name: "Pandit",
  user_name: "admin",
  password: "rushikesh@pandit.co",
  password_confirmation: "rushikesh@pandit.co",
  email: "admin@pandit.com",
  role: "ADMIN"
}
|> Accounts.create_user()

%{
  first_name: "Varenya",
  last_name: "Pandit",
  user_name: "superadmin",
  password: "varenya@pandit.co",
  password_confirmation: "varenya@pandit.co",
  email: "superadmin@pandit.com",
  role: "SUPER_ADMIN"
}
|> Accounts.create_user()
