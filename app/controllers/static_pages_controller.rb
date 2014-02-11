class StaticPagesController < ApplicationController
  skip_before_action :authorize
  def test
  end
end
