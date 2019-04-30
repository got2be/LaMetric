module LaMetric
  Frame = Struct.new(:text, :icon, :index, keyword_init: true) do
    def to_json(*args)
      to_h.to_json(*args)
    end
  end
end
