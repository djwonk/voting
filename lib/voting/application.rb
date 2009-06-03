module Voting
  class Application < Sinatra::Base
    configure do |app|
      app.set(Voting.config)
      DataMapper.setup(:default, app.database_uri)
    end

    error do
      e = request.env['sinatra.error']
      Kernel.puts(e.backtrace.join('\n'))
      'Application Error'
    end

    get '/' do
      haml :root
    end

    get '/elections' do
      @elections = Voting::Election.all
    end
  end
end
