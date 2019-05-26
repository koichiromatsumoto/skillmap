# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category1 = Category.create(name: '応用知識経験', root: true)
Category.create(name: '基礎知識技術', root: true)
category2 = Category.create(name: 'object detection')
category3 = Category.create(name: '数学')
category4 = Category.create(name: '生き物')
category5 = Category.create(name: '音認識')
category6 = Category.create(name: '声認識')

Layer.create(category1_id: category1.id, category2_id: category2.id, category3_id: category3.id)
Layer.create(category1_id: category1.id, category2_id: category2.id, category3_id: category4.id)
Layer.create(category1_id: category1.id, category2_id: category2.id, category3_id: category5.id)
Layer.create(category1_id: category1.id, category2_id: category2.id, category3_id: category6.id)

User.create(login: 'admin1', email: 'admin1@example.com', username: 'Admin1', password: 'password', admin: true)
User.create(login: 'user1', email: 'user1@example.com', username: 'User1', password: 'password', admin: false)
