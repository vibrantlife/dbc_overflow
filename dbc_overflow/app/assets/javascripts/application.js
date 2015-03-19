// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $('form').on('submit', addQuestion);
  displayAllQuestions();

});

var addQuestion = function(event){
  event.preventDefault();
  console.log(this);
  $.ajax({
    type: "POST",
    url: '/questions',
    dataType: 'json',
    data: $(this).serialize()
  })
  .done(function(response) {
    console.log("success", response);
    var html = $('#table_generator').html();
    var templatingFuction = Handlebars.compile(html);
    $('.question_table').append(templatingFuction({response: response}));
    $('form')[0].reset();

  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
}

var addAnswer = function(event){
  event.preventDefault();
  console.log(this);
  $.ajax({
    url: '/path/to/file',
    type: 'default GET (Other values: POST)',
    dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
    data: {param1: 'value1'},
  })
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });
}

var displayAllQuestions = function(event) {
  $.ajax({
    url: '/questions',
    type: 'GET',
    dataType: 'JSON',
  })
  .done(function(questions) {
    console.log("success", questions);
    for(var i =0; i < questions.length; i++){
      var questionsObject = questions[i]
      var html = $('#table_generator').html();
      var templatingFuction = Handlebars.compile(html);
      $('.question_table').append(templatingFuction({response: questionsObject}));
    }
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });

}