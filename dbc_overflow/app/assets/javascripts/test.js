
<script id="table_generator" type="text/x-handlebars-template">
<td><form class="button_to" method="post" action="/questions/" + {{response.id}} + "/upvote"><input type="hidden" name="_method" value="put"><input type="submit" value="Upvote!"></form></td>
<td><form class="button_to" method="post" action="/questions/" + {{response.id}} + "/downvote"><input type="hidden" name="_method" value="put"><input type="submit" value="Downvote!"></form></td>
<td>{{response.vote_count}}</td>
<td>{{response.title}}</td>
<td>{{response.content}}</td>
<td><a href="/questions/" + {{response.id}}>Show</a></td>
<td><a href="/questions/" + {{response.id}} + "/edit">Edit</a></td>
<td><a rel="nofollow" data-method="delete" href="/questions/" + {{response.id}}>Destroy</a></td>
</script>


<% @questions.each do |question| %>
  <tr class="table_row">
    <td data-question-id="<%= question.id%>"><%= button_to 'Upvote!', upvote_question_path(question), method: :put%></td>
    <td><%= button_to 'Downvote!', downvote_question_path(question), method: :put %></td>
    <td><%= question.vote_count%></td>
    <td class="add_question"><%= question.title%></td>
    <td><%= question.content%></td>
    <td><%= link_to 'Show', question_path(question)%></td>
    <td><%= link_to 'Edit', edit_question_path(question)%></td>
    <td><%= link_to 'Destroy', question_path(question), method: :delete%></td>
  </tr>