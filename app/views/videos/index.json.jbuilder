json.array!(@videos) do |video|
  json.extract! video, :id, :link, :duration
  json.url video_url(video, format: :json)
end
