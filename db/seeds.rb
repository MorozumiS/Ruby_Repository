# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create users
User.create!(
  name: '管理者太郎',
  email: 'test@gmail.com',
  kana: 'カンリシャタロウ',
  role: 1,
  tel: '09012345678',
  password: 'password',
  password_confirmation: 'password'
)

# Create projects
Project.create!(
  name: '第3回軽井沢親子キャンプ大会',
  place: '軽井沢',
  start_at: Time.now,
  end_at: Time.now + 1.month,
  user_id: User.first.id
)

# Project.create!(
#   name: '第31回隅田川花火大会',
#   place: '墨田区',
#   start_at: Time.now + 1.month,
#   end_at: Time.now + 2.months,
#   user_id: User.first.id
# )

# Create lost_storages
LostStorage.create!(
  name: '第1預かりセンター',
  reception_number_prefix: 'A00001',
  project_id: Project.first.id
)
LostStorage.create!(
  name: '第2預かりセンター',
  reception_number_prefix: 'A00002',
  project_id: Project.first.id
)
LostStorage.create!(
  name: '第3預かりセンター',
  reception_number_prefix: 'A00003',
  project_id: Project.first.id
)
LostStorage.create!(
  name: '第4預かりセンター',
  reception_number_prefix: 'A00004',
  project_id: Project.first.id
)
LostStorage.create!(
  name: '第5預かりセンター',
  reception_number_prefix: 'A00005',
  project_id: Project.first.id
)

# Create lost_people
LostPerson.create!(
  name: '山田太郎',
  kana: 'ヤマダタロウ',
  gender: 1,
  age: '3',
  tall: '100',
  status: 1,
  reception_at: Time.now,
  lost_storage_id: LostStorage.first.id,
  project_id: Project.first.id
)

LostPerson.create!(
  name: '田中太郎',
  kana: 'タナカタロウ',
  gender: 1,
  age: '6',
  tall: '130',
  status: 1,
  reception_at: Time.now,
  lost_storage_id: 3,
  project_id: Project.first.id
)

LostPerson.create!(
  name: '佐藤はなこ',
  kana: 'サトウハナコ',
  gender: 0,
  age: '5',
  tall: '120',
  status: 1,
  reception_at: Time.now,
  lost_storage_id: 5,
  project_id: Project.first.id
)

# Create lost_person_images
LostPersonImage.create!(
  content: 'https://placehold.jp/150x150.png',
  lost_person_id: LostPerson.first.id
)
LostPersonImage.create!(
  content: 'https://placehold.jp/150x150.png',
  lost_person_id: 2
)

# Create lost_items
LostItem.create!(
  name: 'リュック',
  place: '広場A',
  owner_name: '山田太郎',
  lost_storage_id: LostStorage.first.id,
  project_id: Project.first.id
)

LostItem.create!(
  name: '財布',
  place: '広場C',
  owner_name: '斉藤あかり',
  lost_storage_id: LostStorage.first.id,
  project_id: Project.first.id
)

LostItem.create!(
  name: '帽子',
  place: '広場C',
  owner_name: '佐藤だいき',
  lost_storage_id: LostStorage.first.id,
  project_id: Project.first.id
)

LostItemImage.create!(
  content: 'https://placehold.jp/150x150.png',
  lost_item_id: 1
)