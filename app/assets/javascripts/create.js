$(document).ready(function() {
  $('.join').click(function(event) {
    event.preventDefault();
    var user_id = $('.join').data().userId;
    var opp_id = $('.join').data().opportunityId;
    var request = $.ajax({
      method: "POST",
      url: "/api/v1/volunteer_lists",
      data: {
        volunteer_list: {
          user_id: user_id,
          opportunity_id: opp_id
        }
      }
    });
    request.done(function(data) {
      debugger;
      $('.vol-grid').append("<li>" + "<img src=" + response.image_source + "class = 'vol-img'" + "span class='label'>" + "user_first_name" + " " + "user_last_initial" + "</span" + "</li>")
    });
    request.error(function(jqXHR, textStatus, errorThrown) {
      alert("Not working!");
      debugger;
    });
  });
});
