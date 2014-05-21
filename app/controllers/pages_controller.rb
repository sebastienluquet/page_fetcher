class PagesController < InheritedResources::Base
  def permitted_params
    params.permit(:page => [:page_id])
  end
  include InheritedResources::DSL
  create! do |success, failure|
    success.html { redirect_to pages_path }
  end
end
