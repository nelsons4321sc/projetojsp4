<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>  
    
<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>



  <body>
  <!-- Pre-loader start -->
  <jsp:include page="theme-loader.jsp"></jsp:include>

	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<jsp:include page="navBar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navBarMainMenu.jsp"></jsp:include>

					<div class="pcoded-content">

						<!-- Page-header start -->
						<jsp:include page="page-header.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">

										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card" align="center">
													
														<h1 style="color: #0277BD">Tela Príncipal</h1>
													
												</div>
											</div>
										</div>
									</div>


									<span id="msg">${msg}</span>



									
									
								</div>
								<!-- Page-body end -->
							</div>
							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Required Jquery -->
    <jsp:include page="javaScriptFile.jsp"></jsp:include>
    
    
    <!-- Modal -->
    
    
    
     <script type="text/javascript">
    
     function limparform() {
    	var elementos = document.getElementById("formUser").elements;
		
    	for(p = 0; p < elementos.length; p++) {
    		elementos[p].value = '';
    	}
	}
    
  	</script>
  	
  	
  	     
     
     <script type="text/javascript">
     
  	function criarDelete() {
  		if(confirm("Deseja realmente excluir os dados?")) {
  			
  			document.getElementById("formUser").method = 'get';
  		  	document.getElementById("acao").value = 'deletar';
  		  	document.getElementById("formUser").sunbmit();	
  		}
  	}
      
    </script>
    
   <script type="text/javascript">
   		
   		function criaDeletecomAjax() {
   			if(confirm("Deseja realmente excluir os seus dados?")) {
   				
   				var urlAction = document.getElementById("formUser").action;
   				var idUser = document.getElementById("id").value;
   				
   				$.ajax({
   					
   					method: "get",
   					url : urlAction,
   					data : "id=" +idUser + "&acao=deletarajax",
   					success: function(response) {
   						
   						document.getElementById('msg').textContent = response;
   					}
   					
   				}).fail(function(xhr, status, errorThrown){
   					alert('Erro por deletar usuário por id: '+xhr.responseText);
   				});
   			}
		}
      
   </script>
   
   
   <script type="text/javascript">
  	
  	function verEditar(id) {
		
  		var urlAction = document.getElementById("formUser").action;
  		
  		window.location.href = urlAction + '?acao=buscarEditar&id='+id; 
	}
  	
  </script>
   
   
   
   
   
   <script type="text/javascript">
   	function buscarUsuario() {
   		var nomeBusca = document.getElementById("nomeBusca").value;
   		
   			if(nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ' ) {
   			
   	   			var urlAction = document.getElementById("formUser").action;
   				var idUser = document.getElementById("id").value;
   					
   					$.ajax({
   						
   						method: "get",
   						url : urlAction,
   						data : "nomeBusca=" +nomeBusca + "&acao=buscarUserajax",
   						success: function(response) {
   							
   							var json = JSON.parse(response);
   							// alert(json);
   							
   							
   						// ERRO OCORREU AQUI, POR CAUSSA DE ABERTURA E FECHAMENTO DE CHAVES DO FOR QUE NÃO FOI FEITO NA HORA DA 
   						// CONSTRUÇÃO DO MESMO
   						//	 var json = JSON.stringify(response);
   						//for(var p = 0; p < json.length; p++) {
   								//	$('#tabelaresultados > tbody').append('<tr> <td>'+json[p].id+'</td> </tr>'})
   							//	}
   							
   						   						
   							//console.info(json);
   							 
   						 	  $('#tabelaresultados > tbody > tr').remove();
   						 	  
   						 	  
   						 	  	for(var p = 0; p < json.length; p++){
   						 	  	$('#tabelaresultados > tbody').append('<tr><td>'+json[p].id+'</td><td>'+json[p].nome+'</td><td><button onclick="verEditar('+json[p].id+');" type="button" class="btn btn-info">Ver</button></td></tr>'); 
   						 	  	}
   							
   						 	document.getElementById("totalResultados").textContent = 'Total de Resultados: '+json.length+' clientes';
   										
   						
   					
   						}
   						
   					}).fail(function(xhr, status, errorThrown){
   						alert('Erro ao buscar o usuário por nome: '+xhr.responseText);
   					});
   		
   			}
   			
   		}
		
	   
   </script>
     
  
    </body>

</html>

    