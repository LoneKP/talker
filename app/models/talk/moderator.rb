class Talk::Moderator

  def initialize(talk)
    @talk = talk
  end

  def set_next_topic
    return finish_talk_state if next_topic.nil?
    
    switch_to(next_topic)
  end

  def set_previous_topic
    switch_to(previous_topic)
  end

  def set_first_topic
    talk.highest_voted_topic.update(current: true) unless there_are_no_topics
  end

  def there_is_no_current_topic?
    talk.current_topic == nil
  end

  private

  def there_are_no_topics
    talk.highest_voted_topic.nil?
  end

  def previous_topic
    talk.topics_by_votes[current_topic_index - 1]
  end

  def next_topic
    talk.topics_by_votes[current_topic_index + 1]
  end

  def current_topic_is_the_last?
    talk.topics_by_votes.to_a.size == current_topic_index + 1
  end

  def finish_talk_state
    talk.current_topic.update(current: false)
    talk.update(state: 5)
  end

  def current_topic_index
    talk.topics_by_votes.index(talk.current_topic)
  end

  def switch_to(topic)
    talk.current_topic.update(current: false)
    topic.update(current: true)
  end

  attr_reader :talk
end