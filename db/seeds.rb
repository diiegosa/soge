# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Profile::NAMES.each{ |v| Profile.create!(name: v[:NAME], admin: v[:ADMIN]) unless Profile.where(name: v[:NAME]).present? }

User.create!(
  name: 'User', email: 'dev@dev.com', password: 'cticcbmpe',
  password_confirmation: 'cticcbmpe', profile_id: Profile.get_admin_id
) unless User.where(email: 'dev@dev.com').present?

Acl::AppModule.verify_modules

# Carrega arquivos de db/seeds/
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed_file|
  load(seed_file) if File.exist?(seed_file)
end

puts "Seeds executados com sucesso!"