class MainApp < Sinatra::Base

  def getDetail cardsorting
    detail = {
        id: cardsorting.id,
        userId: cardsorting.userId,
        theme:cardsorting.theme,
        # theme:{
        #     id:cardsorting.theme.id,
        #     cards:cardsorting.theme.cards,
        #     groups:cardsorting.theme.groups
        # },
        # groups:cardsorting.groups,
        cardsortingCardAndGroups:cardsorting.cardsortingCardAndGroups,
        unselectedCards:cardsorting.unselectedCards
    }
    groups = []

    cardsorting.cardsortingCardAndGroups.each do |cag|
      g = groups.find do |e| 
        e[:id] == cag.group.id 
      end
      unless g
        g = {
          id:cag.group.id,
          title:cag.group.title,
          cards:[]
        }
        groups << g
      end
      g[:cards] << cag.card
    end
    detail[:groups] = groups
    detail
  end

  get '/app/cardsorting/:themeId/:id' do
    # json getDetail(Cardsorting.where(:theme_id=>params[:themeId],:id=>params[:id]).first)
    json getDetail Cardsorting.where(:theme_id=>params[:themeId],:id=>params[:id]).first
  end


  get '/app/cardsorting/:themeId' do
    list = []
    Cardsorting.where(:theme_id=>params[:themeId]).each do |cardsorting|
      list << getDetail(cardsorting)
    end 
    json list
  end

  put '/app/cardsorting/:themeId' do
    theme = Theme[params[:themeId]]
    if theme
      cardSorting = Cardsorting.new
      DB.transaction do
        cardSorting.theme = theme;
        cardSorting.save
        theme.cards.each do |card|
          unselectedCard = UnselectedCard.new
          unselectedCard.card = card;
          unselectedCard.cardsorting = cardSorting
          unselectedCard.save
        end
      end
      result= {
        id:cardSorting.id,
        theme:cardSorting.theme
      }
      json result
    else
      send 404
    end
  end

  post '/app/cardsorting/:themeId/:id' do
    DB.transaction do
      jsonBody = request.body.read;
      reqCardsorting = JSON.parse jsonBody
      userId = reqCardsorting["userId"]
      theme = Theme[params[:themeId]]
      unless theme 
        send 404
        return
      end

      cardsorting = Cardsorting[params[:id]]
      
      unless cardsorting
        cardsorting = Cardsorting.new
        cardsorting.theme = theme
      end
      cardsorting.userId = userId;
      cardsorting.save

      CardsortingCardAndGroup.where(:cardsorting_id=>cardsorting.id).delete
      UnselectedCard.where(:cardsorting_id=>cardsorting.id).delete

      reqCardsorting["groups"].each do |reqGroup|
        group = Group[reqGroup["id"]]
        unless group
          group = Group.new
          group.theme = theme
        end
        group.title = reqGroup["title"]
        group.save


        reqGroup["cards"].each do |reqCard|
          card = Card[reqCard["id"]]
          unless card
            card = Card.new
            card.theme = theme
          end
          card.desc = reqCard["desc"]
          card.save
          
          mapping = CardsortingCardAndGroup.new
          mapping.group = group
          mapping.card = card
          mapping.cardsorting = cardsorting
          mapping.save
        end

        reqCardsorting["unselectedCards"].each do |reqUnselectedCard|
          card = Card[reqUnselectedCard["id"]]
          unless card
            card = Card.new
            card.theme = theme
          end
          card.desc = reqUnselectedCard["desc"]
          card.save
          unselectedCard = UnselectedCard.new
          unselectedCard.card = card;
          unselectedCard.cardsorting = cardsorting
          unselectedCard.save
        end

      end
      json cardsorting
    end
  end

end