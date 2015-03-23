SLACK_TOKEN = ENV["SLACK_TOKEN"]
SLACK_WEBHOOK = ENV["SLACK_WEBHOOK"]

module SlackNotifier
  def self.notify(message, channel="@adampash")
    notifier = Slack::Notifier.new SLACK_WEBHOOK, {"unfurl_links": false}

    notifier.ping message,
      icon_emoji: ":baby_symbol:",
      channel: channel,
      username: "NewUserBot"
  end
end
