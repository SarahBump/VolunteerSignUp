
#INTRODUCTION
This is a Volunteer Sign up application that was built with Sinatra. It incorporates backbone to provide the information submitted with the forms on the administration page. It uses bcrypt for authentication and bootstrap for styling.

#Screenshots

![Sign Up Page](/Home.png)
![Admin Page](/Admin.png)

#Challenges
My biggest challenge was rendering the names onto the admin sign in page, here is an example of the code I used to do that

```javascript
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
    console.log();
    volunteers.create({message: field.val()});
    field.val('');s
  });

  volunteers.fetch();

});


```
