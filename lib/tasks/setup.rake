namespace :setup do
  desc "Import Characters"
  task characters: :environment do
    jpg_files = File.join("/", "home", "shaun", "Desktop", "hanja", "**", "*.jpg")
    Dir.glob(jpg_files).each do |file|
      Character.create(image: File.open(file))
    end
  end

end
