class ThirdPartyAuthenticationController < ApplicationController
  def github
    @code = params[:code]
    @ga_account = GithubAccount.find(session[params[:state]])
    uri = URI("https://github.com/login/oauth/access_token")
    req = Net::HTTP::Post.new(uri)
    req.set_form_data({
      :client_id => @ga_account.client_id,
      :client_secret => @ga_account.client_secret,
      :code => params[:code]  
    })
    req['Accept'] = 'application/json'
    puts req.inspect
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.request(req)
    end    
    begin
      data = JSON.parse(res.body)
      @ga_account.update({:access_token => data['access_token']})
    rescue StandardError => e
      flash[:error] = "Error parsing JSON response from Github"
    end

    redirect_to github_account_path(@ga_account)

  end
end