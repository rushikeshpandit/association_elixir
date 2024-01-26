# AssociationElixir

User can sign up with 3 roles : user, admin, super admin

- one company has many departments
- one company has many locations
- one company has many employees
- one employee belongs to one department
- one employee belongs to one location

Following is role based access control

<b>Super Admin</b>

- Can Create, Read, Update, Delete following schemas
  - Company
  - Department
  - Location
  - Employee

<b>Admin</b>

- Can Create, Read, Update, Delete Following Schema
  - Location
  - Employee

<b>User (Authenticated user)</b>

- Can Create, Read, Update, Delete Following Schema
  - Employee
- Can ONLY Read following schema
  - Company
  - Department
  - Location
