module GitHub
  class Base
    HTTPAdapter = GraphQL::Client::HTTP.new('https://api.github.com/graphql') do
      def headers(context)
        token = context[:access_token]
        raise 'Missing GitHub access token' unless token

        {
          'Authorization' => "Bearer #{token}"
        }
      end
    end

    Client = GraphQL::Client.new(
      schema: APP_ROOT.join('db/schema.json').to_s,
      execute: HTTPAdapter
    )
  end
end
