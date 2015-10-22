class AddLanguageService
  def initialize(params)
    @character_id = params[:id]
    @grouped_params = group_params(params)
  end

  def group_params(params)
    params.select! { |k, _v| k.match(/(meaning|pronunciation)/) }
    params.reject! { |_k, v| v.blank? }
    params.group_by { |k, _v| k.split("_")[0] }
  end

  def assign_fields(cl, fields)
    fields.each do |field|
      if field[0].match(/meaning/)
        cl.meaning = field[1]
      else
        cl.pronunciation = field[1]
      end
    end
  end

  def add_languages
    @grouped_params.each do |group, fields|
      language = Language.find_by(name: group)
      cl = CharacterLanguage.find_or_create_by(character_id: @character_id, language_id: language.id)
      assign_fields(cl, fields)
      cl.save
    end
  end
end
