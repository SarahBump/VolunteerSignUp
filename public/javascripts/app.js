console.log('You are great.')


// Model:  To be a Chirp
var Volunteer = Backbone.Model.extend({});


// Collection:  To manage Chirps
var VolunteerCollection = Backbone.Collection.extend({
  model: Volunteer,   // I manage these
  url: '/api/volunteers'   //  Assuming RESTful routing... what is the url
});


// ModelView:  How might I paint... a single Chirp
//   (assume they passed in a model )
var VolunteerView = Backbone.View.extend({
  tagName: 'li',  // What html tag to start with
  className: 'volunteer',  // this is for styling
  template: _.template('<h3><%= first_name %> <%= last_name %> <%= duty %> <%= phone_number %></h3>'),  // html generating function
  render: function(){  // ties it all together
    this.$el.html( this.template( this.model.attributes ) );
  }
});

// ListView (assume to have recieved a collection)
var VolunteerListView = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.collection, 'add', this.render)
  },
  render: function(){

    this.$el.empty();

    var models = this.collection.models;

    for (var i = 0; i < models.length; i++) {
      var modelView = new VolunteerView(   { model: models[i] }   );
      modelView.render();
      this.$el.append( modelView.$el );
    }
  }
});


var volunteers = new VolunteerCollection();
var volunteersView;

$(document).ready(function(){

  volunteersView = new VolunteerListView({
    collection: volunteers,
    el: $('#all-the-volunteers')
  })

  $('#volunteer-form').on('submit', function(e){
    e.preventDefault();
    var field = $(this).find('[name="first_name"]');
    var field_last = $(this).find('[name="last_name"]');
    var duty = $(this).find('[name="duty"]');
    var phone_number = $(this).find('[name="phone_number"]');
    console.log();
    volunteers.create({message: field.val()});
    field.val('');s
  });

  volunteers.fetch();

});
