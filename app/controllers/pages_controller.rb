class PagesController < ApplicationController
  #GET for root
    def home
      @basic_plan = Plan.find(1)
      @pro_plan = Plan.find(2)
    end

    def about

    end
end
