module FlashHelper
  def classes_for_flash(flash_key)
    case flash_key.to_sym
    when :error
      "bg-red-700 text-white"
    else
      "bg-sky-700 text-white"
    end
  end
end