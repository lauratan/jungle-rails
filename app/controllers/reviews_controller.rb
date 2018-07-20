class ReviewsController < ApplicationController
before_filter :authorize
    def create
        @product = Product.find(params[:product_id])
        @review = @product.reviews.create(review_params)
        if @review.save 
            redirect_to @product
        else 
            redirect_to :back
        end
    end

    def destroy
        @delete = Review.find(params[:id]).destroy
        redirect_to :back
    end

      private 

      def review_params
        params.require(:reviews).permit(:rating, :description).merge(user: current_user)
      end
end
