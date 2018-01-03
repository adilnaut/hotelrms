# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def read_file(file_name)
  file = File.open(file_name, "r")
  data = file.read
  file.close
  return data
end

def get_queries(sql_document)
  queries = sql_document.split(";")
  queries.pop(1)
  return queries
end

def encrypt(token)
  Digest::SHA1.hexdigest(token.to_s)
end
sql_create = get_queries read_file 'create.sql'
sql_alter = get_queries read_file 'alter.sql'
# sql_create = sql_create.split(";")
# sql_create.pop(1)


connection = ActiveRecord::Base.connection()

for query in sql_create
  connection.execute(query)
end

for query in sql_alter
  connection.execute(query)
end

connection.execute("INSERT INTO `mydb`.`Room` VALUES (1, 10000, 2);")
connection.execute("INSERT INTO `mydb`.`Room` VALUES (2, 10000, 2);")
connection.execute("INSERT INTO `mydb`.`Room` VALUES (3, 10000, 2);")
connection.execute("INSERT INTO `mydb`.`Room` VALUES (4, 20000, 4);")
connection.execute("INSERT INTO `mydb`.`Room` VALUES (5, 20000, 4);")
connection.execute("INSERT INTO `mydb`.`Room` VALUES (6, 20000, 4);")

connection.execute("INSERT INTO `mydb`.`User`(login, password, remember_token) VALUES ( 'admin', \'"+encrypt('admin')+"\', 'notoken');")
connection.execute("INSERT INTO `mydb`.`User`(login, password, remember_token) VALUES ( 'adilet', \'"+encrypt('adilet')+"\', 'notoken');")
connection.execute("INSERT INTO `mydb`.`User`(login, password, remember_token) VALUES ( 'arman', \'"+encrypt('arman')+"\', 'notoken');")
# connection.execute(sql_create)
# connection.execute(sql_alter)
