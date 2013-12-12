class ActivityRightBase extends JView

  constructor:(options={}, data)->

    super options, data

    @tickerController = new KDListViewController
      startWithLazyLoader : yes
      viewOptions :
        type      : "activities"
        cssClass  : "activities"
        itemClass : @itemClass

    @tickerListView = @tickerController.getView()


  renderItems: (err, items=[])->

    @tickerController.hideLazyLoader()
    @tickerController.addItem item for item in items  unless err


  pistachio:->
    """
    <div class="right-block-box">
      <h3>#{@getOption 'title'}{{> @showAllLink}}</h3>
      {{> @tickerListView}}
    </div>
    """

class ActiveUsers extends ActivityRightBase


  constructor:(options={}, data)->

    @itemClass       = ActiveUserItemView
    options.title    = "Active Koders"
    options.cssClass = "active-users"

    super options, data

    @showAllLink = new KDCustomHTMLView
      tagName : "a"
      partial : "show all"
      cssClass: "show-all-link hidden"
      click   : (event) -> KD.singletons.router.handleRoute "/Members"
    , data

    KD.remote.api.ActiveItems.fetchUsers {}, @bound 'renderItems'

class ActiveTopics extends ActivityRightBase

  constructor:(options={}, data)->

    @itemClass       = ActiveTopicItemView
    options.title    = "Popular Topics"
    options.cssClass = "active-topics"

    super options, data

    @showAllLink = new KDCustomHTMLView
      tagName : "a"
      partial : "show all"
      cssClass: "show-all-link"
      click   : (event) -> KD.singletons.router.handleRoute "/Topics"
    , data

    KD.remote.api.ActiveItems.fetchTopics {}, @bound 'renderItems'
