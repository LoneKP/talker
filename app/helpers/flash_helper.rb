module FlashHelper
  def classes_for_flash(flash_key)
    case flash_key.to_sym
    when :error
      "bg-red text-white"
    else
      "bg-blue text-white fade-out"
    end
  end

  def icons_for_flash(flash_key)
    case flash_key.to_sym
    when :error
      "error"
    else
      "done"
    end
  end
end