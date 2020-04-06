class ApplicationController < ActionController::API
  protected

  def paginate(relation, page_size = 25)
    relation = relation.order(order_value)
    relation = relation.where("#{order_value} > ?", after_value) if after_value
    relation.limit(page_size)
  end

  def order_value
    @order_value ||=
      if ["id", "created_at"].include?(params[:order])
        params[:order]
      else
        "id"
      end
  end

  def after_value
    return unless params[:after]

    @after_value ||=
      case order_value
      when "created_at"
        # HACK: stringified value is rounded to milliseconds, hence adding 1ms
        #   to make `after` value work as expected
        params[:after].to_datetime + 0.001.seconds
      when "id"
        params[:after].to_i
      end
  end
end
