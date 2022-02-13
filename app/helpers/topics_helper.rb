module TopicsHelper
  def topic_seperator(vector_ending, width, color)
    tag.svg(width: width, height: "16", viewBox: "0 0 #{width} 16", fill: "none" ) do 
      tag.path(class: "group-hover:stroke-white", d: "M2 13L12 3L22 13L32 3L42 13L52 3L62 13L72 #{vector_ending}", stroke: color, "stroke-width": "3")
    end
  end

  def seperator_types
    [["3L82 13L92 3L102 13L112 3", "114", "#A92F3E"], ["3L82 13", "84", "#375DA1"], ["3", "74", "#027540"]]
  end

  def number_of_lines(topic)
    (topic.size.to_f / 65.to_f).ceil
  end
end
