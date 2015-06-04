
#INTRODUCTION
This is a Volunteer Sign up application that was built with Sinatra. It incorporates backbone to provide the information submitted with the forms on the administration page. It uses bcrypt for authentication, bootstrap for styling, and nexmo to send volunteers an alert text message.

#Screenshots

![Sign Up Page](/Home2.png)
![Admin Page](/Admin2.png)
![Text Message](/screen.jpg)

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
#Version 2
In the next version of this site I would like to be able to send alert text to all of the volunteers with the click of a button.
