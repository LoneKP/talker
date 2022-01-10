class Talk::Moderator

  def initialize(talk)
    @talk = talk
  end

  def set_current_topic
    if there_is_no_current_topic?
      set_first_topic
    elsif current_topic_is_the_last?
      toggle_last_topic
      talk.update(state: 5)
    else
      set_next_topic
    end
  end

  def there_is_no_current_topic?
    talk.current_topic == nil
  end

  def set_first_topic
    talk.highest_voted_topic.update(current: true)
  end

  private

  def set_next_topic
    index = talk.topics_by_votes.index(talk.current_topic)
    next_current_topic = talk.topics_by_votes[index + 1]
    
    talk.current_topic.update(current: false, done: true)
    next_current_topic.update(current: true)
  end

  def current_topic_is_the_last?
    talk.topics_by_votes.to_a.size == talk.topics_by_votes.index(talk.current_topic) + 1
  end

  def toggle_last_topic
    talk.current_topic.update(current: false, done: true)
  end

  attr_reader :talk

end