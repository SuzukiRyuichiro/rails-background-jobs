class GetContributionsJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'
  require 'json'

  queue_as :default

  def perform
    students = JSON.parse(File.read(File.join(__dir__, 'students.json')), { symbolize_names: true })
    students.map! { |student| student.merge({ commits: get_month_contributions(student[:username]) }) }
    students.sort_by! { |student| -student[:commits] }
    UserMailer.with(students:).contribution.deliver_now
  end

  private

  def get_month_contributions(username)
    today = Date.today
    end_of_month = today.end_of_month
    beginning_of_month = today.beginning_of_month

    data = parse_this_month_contribution(username)

    data.select! do |d|
      beginning_of_month <= d[:date] && d[:date] < end_of_month
    end

    return data.map { |d| d[:commits] }.sum
  end

  def parse_this_month_contribution(username)
    html = URI.open("https://github.com/#{username}").read
    days = Nokogiri::HTML(html).search('svg.js-calendar-graph-svg').search('rect.ContributionCalendar-day')
    days.map do |day|
      {
        commits: day.attribute("data-count").value.to_i,
        date: Date.parse(day.attribute("data-date").value)
      }
    end
  end
end
