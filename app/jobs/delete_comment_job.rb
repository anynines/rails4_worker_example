class DeleteCommentJob < ActiveJob::Base
  queue_as :default

  def perform(comment_id)
    # Do something later
    sleep 5
    comment = Comment.find comment_id
    comment.destroy
  end
end
