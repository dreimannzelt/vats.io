$(document).ready(function() {
  result = $("#result").hide();

  $("#calculate form").on("submit", function(e) {
    e.preventDefault();

    amount = $(this).find("#amount").val();
    origin_code = $(this).find("#origin_code").val();
    target_code = $(this).find("#target_code").val();
    is_net = $(this).find("#net");

    path = ["/rates", origin_code, target_code, (amount || 0)].join("/");


    $.getJSON( path, is_net.serialize() )
      .success(function(data, state) {

        $("#result #net").text(data.net);
        $("#result #gross").text(data.gross);
        $("#result #tax").text(data.vat_amount);

        result.show();
      });
  });

});
