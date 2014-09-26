class MainApp < Sinatra::Base

  get '/app/theme' do
    list = []
    Theme.find_all.each { |it|
      it.cards
      tmp = {
        id:it.id,
        title:it.title,
        cards:it.cards,
        cardsortings:it.cardsortings
      }
      list.push tmp
    }
    json list
  end

  get '/app/theme/:themId' do
    theme = Theme[params[:themId]]
    tmp =  {
      id:theme.id,
      title:theme.title,
      cards:theme.cards,
      cardsortings:theme.cardsortings
    }
    json tmp
  end


  post '/app/theme/:themId' do
    DB.transaction do
      jsonBody = request.body.read;
      reqTheme = JSON.parse jsonBody
      theme = Theme[params[:themId]]
      theme.title = reqTheme["title"];
      
      theme.cards.each do |card|
        exsist = reqTheme["cards"].any? do |c|
            card.id == c["id"]
          end

        unless exsist
          UnselectedCard.where(:card_id=>card.id).delete
          CardsortingCardAndGroup.where(:card_id=>card.id).delete
          card.delete
        end

      end

      reqTheme["cards"].each do |card|
        if card["id"]
          storeCard = Card[card["id"]];
          storeCard.desc = card["desc"]
          storeCard.save
          logger.info "storeCard #{storeCard}"
        else
          newCard = Card.new;
          newCard.desc = card["desc"]
          newCard.theme = theme;
          result = newCard.save
          logger.info "newCard #{newCard}:#{result.id}"
        end
      end
      theme.save
    end
    json "update success"
  end

  delete '/app/theme/:themId' do
    DB.transaction do
      theme = Theme[params[:themId]]
      theme.cardsortings.each do |c| 
        c.cardsortingCardAndGroups.each do |c|
          c.delete 
        end
        c.unselectedCards.each do |c|
          c.delete 
        end
        c.delete 
      end

      theme.cards.each do |c| 
        c.delete 
      end
      theme.groups.each do |c| 
        c.delete 
      end

      theme.delete
    end
    json "delete success"
  end

  put '/app/theme' do
    theme = Theme.new
    theme.save
    json theme;
  end


end