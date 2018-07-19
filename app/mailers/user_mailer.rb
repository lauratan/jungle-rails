class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com'
 
    def order_receipt(params)
      @order = params[:order]
      @email = @order.email
    #   @line_items = @order.line_items.all
      mail(to: @email, subject: "#{@order.id} - Thank you for your order!") do |format|
        format.html { render 'order_receipt'}
        end
    end
end
