$(document).ready(function() {
       $('#submit').click(function() {
              /*var url = $('#url').val();*/
              var input =  $('#input').val();
              var id=$('#userId').val();
              var output = $('#output');
              
              $.ajax({
                     url : "CIAMServiceClient",
                     type : "POST",
                     data : {
                           input : input,
                           id : id
                           
                     },
                     success : function(responseJson) {
                           
                           output.text(responseJson);
                         //  $('#output').jsonFormatter();
                           
                           //$('textarea#output').attr('value',responseText);
                     },
                     error: function(jqXHR, textStatus, errorThrown) {
                      alert(jqXHR+" - "+textStatus+" - "+errorThrown);
                     }
                     
              });
       });
       $('.buttoninput').click(function() {
    	   /*session.setAttribute("btnClicked",this.id);*/
    	   var inputid = this.id;
           var output = $('#input');
           
           $.ajax({
                  url : "ReadPropertyFile",
                  type : "POST",
                  data : {
                        input : inputid
                  },
                  success : function(responseJson) {
                       
                        /*var coordinates = responseJson.split( "," );
                        var results = [];
                        var out;
                        for( var i = 0; i <10 ;i++ ) {
                        	out+=coordinates[ i ]+"\n";
                        
                        }*/
                	  
                        	output.text(responseJson);
                    
                       /* output.text(coordinates[ 1 ]);*/
                        /*}*/
                      //  $('#output').jsonFormatter();
                        
                        //$('textarea#output').attr('value',responseText);
                  },
                  error: function(jqXHR, textStatus, errorThrown) {
                   alert(jqXHR+" - "+textStatus+" - "+errorThrown);
                  }
                  
           });
    });
});
