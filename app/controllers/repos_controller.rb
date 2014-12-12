class ReposController < ApplicationController
  before_action :set_repo, only: [:show, :edit, :update, :destroy]
  before_action :set_github_account

  # GET /repos
  # GET /repos.json
  def index
    @repos = collection
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
    @branches = @repo.branches
  end

  # GET /repos/new
  def new
    @repo = collection.new    
    get_possible_repo_names
  end

  # GET /repos/1/edit
  def edit
    get_possible_repo_names
  end

  # POST /repos
  # POST /repos.json
  def create
    @repo = collection.create(repo_params)

    respond_to do |format|
      if @repo.errors.empty?
        format.html { redirect_show @repo, notice: 'Repo was successfully created.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_show @repo, notice: 'Repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @repo }
      else
        format.html { render :edit }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_index notice: 'Repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def get_possible_repo_names
      @github_account = GithubAccount.find(params[:github_account_id])
      keys = [:full_name]
      @possible_repos = @github_account.client.repos.map{ |r| r.to_h.select{ |k, v| keys.include?(k) } }
    end

    def set_github_account
      @github_account = GithubAccount.new(:id => params[:github_account_id])
    end

    def redirect_index(*args)
      redirect_to(github_account_repos_url(:github_account_id => params[:github_account_id]), *args)
    end

    def redirect_show(repo, *args)
      redirect_to(github_account_repo_url(:id => repo.id, :github_account_id => repo.github_account_id), *args)
    end

    def collection      
      Repo.where(:github_account_id => params[:github_account_id])
    end

    def set_repo
      @repo = collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name, :github_name, :last_synced)
    end
end
