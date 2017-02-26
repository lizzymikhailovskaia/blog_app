class BlogsController < ApplicationController
  before_action :find_blog, only: [:show, :edit, :update, :destroy]
  before_action :check_owner!, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :new]

 def index
   if session[:count] == nil
     session[:count] = 0
   end
   session[:count] += 1
   @visit_count = session[:count]
   @blogs = Blog.all
   if params[:category]
     @bogs = Category.find_by(name: params[:category]).blogs
   end
 end

 def new
 end

 def create
   @blog = Blog.create(
     title: params[:title],
     body: params[:body],
     user_id: current_user.id
     )

   if @blog.save
     flash[:success] = "Blog post Created"
     redirect_to "/blogs/#{@blog.id}"
   else
     render :new
   end
 end

 def show
 end

 def edit
 end

 def update
   @blog.update(
    title: params[:title],
    body: params[:body]
    )

   if @blog.save
     flash[:success] = "Blog updated"
     redirect_to "/blogs/#{@blog.id}"
   else
     render :edit
   end
 end

 def destroy
   @blog.destroy
   flash[:warning] = "Blog post Destroyed"
   redirect_to "/"
 end

 def search
 end

 private

 def check_owner!
   redirect_to '/' unless current_user && current_user.id == @blog.user_id
 end

 def find_blog
    @blog = Blog.find_by(id: params[:id])
 end
end
