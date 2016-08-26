namespace :links_formatting do
  desc "TODO"
  task trim: :environment do
    links = Link.all

    links.each do |link|
      link.target.strip!

      if !Link.where(target: link.target).empty?
        link.delete
      else
        link.save
      end


    end

  end

  desc "TODO"
  task add_protocol: :environment do
    Link.all.each do |link|
      if !link.target.start_with?("http://", "https://")
        link.target = "http://" + link.target

        if !Link.where(target: link.target).empty?
          link.delete
        else
          link.save
        end
      end
    end
  end

end
