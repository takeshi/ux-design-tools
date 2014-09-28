require './server/table_sorter'

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

  get '/app/cardsorting_analize/:themeId' do
    cardSortings = Cardsorting.where(:theme_id=>params[:themeId])
    if cardSortings.count == 0
      status 404
      'Not Found'
    else
      theme = Theme[params[:themeId]]
      results = [];

      cardSortings.each do |cardSorting|
        userId = cardSorting.userId
        cardSorting.cardsortingCardAndGroups.each do |cag|
          group = cag.group;
          card = cag.card;
          result = results.find{|e| e[:group].id == group.id}
          unless result
            result = {
              group:group,
              votes:{}
            };
            results << result
          end
          vote = result[:votes][card.id];
          unless vote
            vote = []
            result[:votes][card.id] = vote
          end
          # logger.info "#{json results}"
          vote << userId
        end
      end 
      cards = theme.cards
      size = cards.length
      tableData = []
      results.each do |result|
        tableData << result[:votes].keys
      end
      TableSorter.optimize size,tableData,results,cards
      # results.sort! do |a,b|
      #   return -1 unless a[:group].title
      #   return 1 unless b[:group].title
      #   a[:group].title <=> b[:group].title
      # end
      # cards = theme.cards.sort do |a,b|
      #   return -1 unless a.desc
      #   return 1 unless b.desc
      #   a.desc <=> b.desc
      # end

      data = {
        theme:theme,
        cards:cards,
        results:results
      }
      json data
    end
  end

  get '/app/cardsorting/:themeId/:id' do
    # json getDetail(Cardsorting.where(:theme_id=>params[:themeId],:id=>params[:id]).first)
    cardSorting = Cardsorting.where(:theme_id=>params[:themeId],:id=>params[:id]).first
    unless cardSorting
      status 404
      'NotFound'
    else
      json getDetail cardSorting
    end
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

  delete '/app/cardsorting/:themeId/:id' do
    DB.transaction do
      theme = Theme[params[:themeId]]
      unless theme 
        send 404
        return
      end
      cardsorting = Cardsorting[params[:id]]
      unless cardsorting 
        send 404
        return
      end
      CardsortingCardAndGroup.where(:cardsorting_id=>cardsorting.id).delete
      UnselectedCard.where(:cardsorting_id=>cardsorting.id).delete
      cardsorting.delete
    end
    json 'success'
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
        title = reqGroup["title"] || '(未分類)';
        group = Group.where(:theme_id=>theme.id,:title=>title).first
        unless group
          group = Group[reqGroup["id"]]
          unless group
            group = Group.new
            group.theme = theme
          end
        end
        group.title = title
        group.save


        reqGroup["cards"].each do |reqCard|
          desc = reqCard["desc"];
          unless desc
            next
          end
          card = Card.where(:theme_id=>theme.id,:desc=>desc).first
          unless card
            card = Card[reqCard["id"]]
            unless card
              card = Card.new
              card.theme = theme
            end
          end
          card.desc = desc
          card.save
          
          # 重複の削除          
          mapping = CardsortingCardAndGroup.where(
            :group_id=>group.id,
            :card_id=>card.id,
            :cardsorting_id=>cardsorting.id)
            .first
          unless mapping
            mapping = CardsortingCardAndGroup.new
            mapping.group = group
            mapping.card = card
            mapping.cardsorting = cardsorting
            mapping.save
          end
        end
      end

     # logger.info "unselected card #{reqCardsorting["unselectedCards"]}"
      reqCardsorting["unselectedCards"].each do |reqUnselectedCard|
        card = Card[reqUnselectedCard["id"]]
        unless card
          card = Card.where(:theme_id=>theme.id,:desc=>reqUnselectedCard["desc"]).first
          unless card
            card = Card.new
            card.theme = theme
          end            
        end
        card.desc = reqUnselectedCard["desc"]
        card.save
        unselectedCard = UnselectedCard.new
        unselectedCard.card = card;
        unselectedCard.cardsorting = cardsorting
        unselectedCard.save
      end

      json cardsorting
    end
  end

end