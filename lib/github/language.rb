module GitHub
  class Language < Base
    TopLanguageDefinition = Client.parse <<-'GRAPHQL'
      query($login: String!, $cursor: String) {
        rateLimit {
          remaining
        },
        user(login: $login) {
          repositories(first: 100, after: $cursor) {
            nodes {
              primaryLanguage {
                name
              }
            },
            pageInfo {
              endCursor
              hasNextPage
            }
          }
        }
      }
    GRAPHQL

    def top_languages(variables)
      query(TopLanguageDefinition, variables).data
    end

    private

    def query(definition, variables = {})
      Client.query(
        definition,
        variables: variables,
        context: client_context
      )
    end

    def client_context
      { access_token: ENV['GITHUB_ACCESS_TOKEN'] }
    end
  end
end
