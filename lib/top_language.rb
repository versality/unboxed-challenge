class TopLanguage
  def initialize(username)
    @username = username
    request
  end

  def language
    freq = @language_names.each_with_object(Hash.new(0)) { |v, h| h[v] += 1 }
    @language_names.max_by { |v| freq[v] }
  end

  def remaining_queries
    rate_limit_remaining
  end

  def request
    @language_names = []
    @response = query(login: @username)
    return unless user_exists?

    loop do
      @language_names += response_language_names

      break unless next_page?
      break if rate_limit_remaining <= 0

      @response = query(login: @username, cursor: end_cursor)
    end
  end

  def rate_limit_remaining
    @response.rate_limit.remaining.to_i
  end

  private

  def query(request)
    github_language = GitHub::Language.new
    github_language.top_languages(request)
  end

  def next_page?
    @response.user.repositories.page_info.has_next_page
  end

  def user_exists?
    @response.user != nil
  end

  def end_cursor
    @response.user.repositories.page_info.end_cursor
  end

  def response_language_names
    @response
      .user
      .repositories
      .nodes
      .map(&:primary_language)
      .compact # response contains nils
      .map(&:name)
  end
end
