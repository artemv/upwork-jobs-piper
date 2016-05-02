json.count @list_stats[:count]
json.firstDate @list_stats[:from]
json.lastDate @list_stats[:to]
json.jobs @job_posts.map do |job_post|
  json.title job_post.title
  json.skills job_post.skills
  json.description job_post.description
  json.budget job_post.budget
  json.country job_post.country
  json.post_date job_post.post_date
end
