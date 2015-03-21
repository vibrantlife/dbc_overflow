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
  $('form').on('submit', addAnswer)
  $('table').on('click', '.upvote_button',upVote)
  $('table').on('click', '.downvote_button', downVote)

  /* Act on the event */
});

var addQuestion = function(event){
  event.preventDefault()
  // console.log(this);
  $.ajax({
    type: "POST",
    url: '/questions',
    dataType: 'json',
    data: $(this).serialize()
  })
  .done(function(response) {
    console.log("success");
    var html = $('#table_generator').html();
    var templatingFuction = Handlebars.compile(html);
    $('.question_table').append(templatingFuction({response: response}));
    $('form')[0].reset();

  })
  .fail(function() {
    console.log("error");
  })
}

var displayAllQuestions = function(event) {
  $.ajax({
    url: '/questions',
    dataType: 'JSON',
    type: 'get'
  })
  .done(function(questions) {
    console.log("success");
    var html = $('#table_generator').html();
    var templatingFuction = Handlebars.compile(html);
    for(var i =0; i < questions.length; i++){
      var questionsObject = questions[i]
      $('.question_table').append(templatingFuction({response: questionsObject}));
    }
  })
  .fail(function() {
    console.log("error");
  })
}

var addAnswer = function(event){
  event.preventDefault();
  var url = this.action
  $.ajax({
    url: url + "?&authenticity_token=" + AUTH_TOKEN,
    type: 'POST',
    dataType: 'json',
    data: $(this).serialize()
  })
  .done(function(answer) {
    console.log("success", answer);
    var html = $('#answer_generator').html();
    var authToken = $("meta[name='crsf-token']").attr('content');
    var templatingFuction = Handlebars.compile(html, authToken);
    $('table').append(templatingFuction({answer: answer}));
    $('form')[0].reset();
  })
  .fail(function() {
    console.log("error");
  })
}

var displayAllAnswers = function(event){
  var url = $("#delete").attr('href');
  $.ajax({
    url: url,
    dataType: 'json',
    data: $(this).serialize()
  })
  .done(function(allAnswers) {
    console.log("success", allAnswers);
    var html = $('#answer_generator').html();
    var templatingFuction = Handlebars.compile(html);
    for (var i = 0; i < allAnswers.length; i++){
      var answersObjects = allAnswers[i]
      $('table').append(templatingFuction({answer: answersObjects}));
    }
  })
  .fail(function() {
    console.log("error");
  })
}

var upVote = function(){
  // console.log(this);
  var url = $(this).attr('data-url');
  $.ajax({
    url: url,
    type: 'PUT',
    dataType: 'json'
  })
  .done(function(answerUpvote) {
    console.log("success", answerUpvote.id);
    $("span[data-id=" + "" + answerUpvote.id + "]").text(answerUpvote.vote_count);
  })
  .fail(function() {
    console.log("error");
  })
}

var downVote = function(){
  var url = $(this).attr('data-url');
  $.ajax({
    url: url,
    type: 'PUT',
    dataType: 'JSON',
  })
  .done(function(answerDownvote) {
    console.log("success", answerDownvote);
    $("span[data-id=" + "" + answerDownvote.id + "]").text(answerDownvote.vote_count);
  })
  .fail(function() {
    console.log("error");
  })
}