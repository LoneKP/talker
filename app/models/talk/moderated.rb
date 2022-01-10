module Talk::Moderated
  def moderator
    @moderator ||= Talk::Moderator.new(self)
  end
end