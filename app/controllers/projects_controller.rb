class ProjectsController < ApplicationController


  before_action :authenticate_user!, except: [:index]

  before_action :admin_required, except: [:index]
 before_action :set_project, only: [:edit, :update, :destroy]

 # GET /projects
 # GET /projects.json
 def index
   @projects = Project.all
 end

 # GET /projects/1
 # GET /projects/1.json


 # GET /projects/new
 def new
   @project = Project.new
 end

 # GET /projects/1/edit
 def edit
 end

 # POST /projects
 # POST /projects.json
 def create
   @project = Project.new(project_params)
   # @project.user_id = current_user.id
   # respond_to do |format|
   #   if @project.save
   #     format.html { redirect_to projects_path, notice: 'Project was successfully created.' }

   #   else
   #     format.html { render :new }

   #   end

      if @project.save
        flash[:success] = 'Product has been created'
        redirect_to projects_path


     else



   flash.now[:danger] = 'Product has not been created'
    render :new


   end
 end
 # PATCH/PUT /projects/1
 # PATCH/PUT /projects/1.json
 def update
   respond_to do |format|
     if @project.update(project_params)
       format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }

     else
       format.html { render :edit }

     end
   end
 end

 # DELETE /projects/1
 # DELETE /projects/1.json
 def destroy
   @project.destroy
   respond_to do |format|
     format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }

   end
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_project
     @project = Project.friendly.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def project_params
     params.require(:project).permit(:name, :description, :web_link, :github_link)
   end


end
