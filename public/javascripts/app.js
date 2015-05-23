console.log('You are great.')


// Model:  To be a Chirp
var Chirp = Backbone.Model.extend({});


// Collection:  To manage Chirps
var ChirpCollection = Backbone.Collection.extend({
  model: Chirp,   // I manage these
  url: '/api/chirps'   //  Assuming RESTful routing... what is the url
});


// ModelView:  How might I paint... a single Chirp
//   (assume they passed in a model )
var ChirpView = Backbone.View.extend({
  tagName: 'li',  // What html tag to start with
  className: 'chirp',  // Should it have a class name
  template: _.template('<h3><%= message %></h3>'),  // html generating function
  render: function(){  // ties it all together
    this.$el.html( this.template( this.model.attributes ) );
  }
});

// ListView (assume to have recieved a collection)
var ChirpListView = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.collection, 'add', this.render)
  },
  render: function(){

    this.$el.empty();

    var models = this.collection.models;

    for (var i = 0; i < models.length; i++) {
      var modelView = new ChirpView(   { model: models[i] }   );
      modelView.render();
      this.$el.append( modelView.$el );
    }

  }
});


var chirps = new ChirpCollection();
var chirpsView;

$(document).ready(function(){

  chirpsView = new ChirpListView({
    collection: chirps,
    el: $('#all-the-chirps')
  })

  $('#chirp-form').on('submit', function(e){
    e.preventDefault();
    var field = $(this).find('[name="my-chirp"]');
    chirps.create({message: field.val()});
    field.val('');
  })

  chirps.fetch();

});
