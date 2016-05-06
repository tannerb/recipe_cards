class StaticPagesController < ApplicationController
  def home
  end

  def login
    render text: "hello world"
  end
end
