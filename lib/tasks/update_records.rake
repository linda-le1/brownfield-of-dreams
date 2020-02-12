desc "Update Videos"
    task :update => [:environment] do
        Video.where(position: nil).each do |video|
            video.update_attribute :position, 0
        end
end