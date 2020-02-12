class ActivateController < ApplicationController
    def create
        user.update(active?: true)
        redirect_to "/dashboard"
    end
end