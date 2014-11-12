$(document).ready(function () {
  addWords();
});

function addWords(){
$("#adAllThis").on('click', function(event){
  event.preventDefault();
  console.log('1');

   var author = $("#new-author").val();
   var tvor = $("#new-sourse").val();
   var citata = $("#new-phrase").val();

    $("#old-phrases").append(
        "<p><h3 style='font-family:Times, serif; font-weight: 300'>"+citata
        +"</h2></p>" + "<p> <h4 style='font-style: italic; font-weight: 100'> &copy   "
        + author +"  &laquo" + tvor +"&raquo</h4></p>"
   );
  }
 );
}