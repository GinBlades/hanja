require "csv"

namespace :setup do
  desc "Import Characters from Hanja Images"
  task characters: :environment do
    jpg_files = File.join("/", "home", "shaun", "Desktop", "hanja", "**", "*.jpg")
    Dir.glob(jpg_files).each do |file|
      Character.create(image: File.open(file))
    end
  end

  desc "Import Characters from Wikipedia"
  task wikikanji: :environment do
    Language.find_or_create_by(name: "english")
    Language.find_or_create_by(name: "japanese")
    CSV.foreach(Rails.root.join("lib", "assets", "hanja.csv"), headers: true) do |row|
      character = Character.create(
        new: row["New"],
        old: row["Old"],
        radical: row["Radical"],
        strokes: row["Strokes"],
        grade: row["Grade"]
      )
      CharacterLanguage.create(
        language: Language.find_by(name: "english"),
        character: character,
        meaning: row["English Meaning"]
      )
      CharacterLanguage.create(
        language: Language.find_by(name: "japanese"),
        character: character,
        meaning: row["Readings"]
      )
    end
  end

end
