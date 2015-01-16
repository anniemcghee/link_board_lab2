class CommentsController < ApplicationController


  def new_comment
    @parent_comment = Comment.find_by_id(params[:id])
    @comment = Comment.new
  end

  def create_comment
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])
      comment = Comment.find_by_id(params[:id])
      user.comments << comment.comments.create({body:params[:comment][:body]})
      redirect_to post_comments_path(parent_post(comment))
  end

  def create_vote
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])
      comment = Comment.find_by_id(params[:id])
      existing_vote = comment.votes.where(user_id: user.id).any?

      if existing_vote
        flash[:warning]= "You already voted on this!"
      else
        user.votes << comment.votes.create
      end
      redirect_to post_comments_path(parent_post(comment))
  end

  private

  def parent_post comment
    return comment if comment.class == Post
    return parent_post(comment.commentable)
  end


end