$("#adAllThis").on('click', function(event){
  event.preventDefault();
  console.log('1');

   var author = $("#new-author").val();
   var tvor = $("#new-sourse").val();
   var citata = $("#new-phrase").val();

    $("#old-phrases").append();