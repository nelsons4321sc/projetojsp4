<%@page import="model.ModelLogin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
	
<!-- PARA USAR O JSTL, o mesmo trabalha com coteúdo dinâmico, abre as tabelas ao abrir a página -->   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
								<form class="form-material" enctype="multipart/form-data" action="<%=request.getContextPath()%>/ControleProduto" method="post" id="formUser">
										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-block">
														<div align="center">
															<h2 style="color: red">Lista de Produtos</h2>
                                             			</div>												
													</div>
												</div>
											</div>
										</div>
										<div align="center">
										<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>
											<c:if test="${modelProduto.idproduto > 0}">
												<a href="<%= request.getContextPath() %>/Telefone?idUser=${modelProduto.idproduto}" class="btn btn-primary btn-round waves-effect waves-light">Telefone</a>
												<a href="<%= request.getContextPath() %>/ControleProduto?idUser=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Produto</a>
											</c:if>						
										</div>	
									<div style="height: 300px; overflow: scroll;">
										<table class="table" id="tabelaresultadosview">
											<thead>
												<tr>
													
													<th scope="col">nome do Produto</th>
													<th scope="col">Foto</th>
													<th scope="col">valor</th>
													
													
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${modelProdutos}" var="p">
													<tr>
														<!-- parametro userpai informado como parametro na Servlet  -->
														<td><c:out value="${p.nomeproduto }"></c:out></td>
														<td><img alt="Imagem produto" id="fotoembase64" src="${p.fotoproduto}" width="70px"></td>
														<td><c:out value="R$ ${p.valor }"></c:out></td>
														
														<td><a class="btn btn-success" href="<%= request.getContextPath() %>/ControleProduto?acao=editar&id=${p.idproduto}&userpai=${modelLogin.id}">Editar</a></td>											
														<td><a class="btn btn-success"  href="<%= request.getContextPath() %>/ControleProduto?acao=excluir&id=${p.idproduto}&userpai=${modelLogin.id}" >Excluir</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									
								
									<nav aria-label="Navegar por páginas">
											<ul class="pagination">
											<!-- Capturando com a palavra totalPagina o atributo da ServletController -->
											   <%
											     int totalPagina = (int) request.getAttribute("totalPagina");
											   
											    for (int p = 0; p < totalPagina; p++){
											    	String url = request.getContextPath() + "/ControleProduto?acao=paginar&pagina=" + (p  * 5);  
											    	out.print("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url +"\">"+(p + 1)+"</a></li>");
											    }
											   
											   %>
											
												
											</ul>
										</nav>
																			
									
								</form>
							</div>
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
	<div class="modal fade" id="exampleModalUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Pesquisa de Produto</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
				
					<!-- CAMPOS -->
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Nome do Produto" aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button" onclick="buscarProduto();">Localizar</button>
						</div>
					</div>


					<!-- TABELA -->
					<div style="height: 300px; overflow: scroll;">
						<table class="table" id="tabelaresultados">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Nome</th>
									<th scope="col">Editar</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="ulPaginacaoUserAjax">
						</ul>
					</nav>	
						<span id="totalResultados"></span>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
	<!-- FIM DO Modal -->
	
	<script type="text/javascript">
	/*
		function buscarUsuario() {
			
			var urlAction = document.getElementById("formUser").action;
			
			var nomeBusca = document.getElementById("nomeBusca").value;
			
			if (nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ') { //validando valor para busca no banco de Dados
	
				$.ajax({
					
					method : "get",
					url : urlAction,
					data : "nomeBusca=" + nomeBusca	+ "&acao=paginar",
					success : function(response, textStatus, xhr) {
						var json = JSON.parse(response);
						
						
						
						$('#tabelaresultados > tbody > tr').remove();
						$("#ulPaginacaoUserAjax > li").remove();
						 
						for (var p = 0; p < json.length; p++) {
							$('#tabelaresultados > tbody').append('<tr><td>'+ json[p].id 
									+ '</td><td>'
									+ json[p].nomeproduto
									+ '</td><td><button onclick="verEditar('
									+ json[p].idproduto
									+ ');" type="button" class="btn btn-info">Ver</button></td></tr>');
							
						} 
						
						document.getElementById("totalResultados").textContent = 'Total de Resultados: '+ json.length + ' Clientes';
						
						var totalPagina = xhr.getResponseHeader("totalPagina");
						
						 for (var p = 0; p < totalPagina; p++){
							
							 var url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina='+ (p * 5);
							 
							 $("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')">'+ (p + 1) +'</a></li>'); 
						 }
						
					}
					
				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao buscar o usuário por nome: '+ xhr.responseText);
						});	
			}
			
		}
	*/
	</script>
	
	<script type="text/javascript">
		function buscarProduto() {
			var nomeBusca = document.getElementById("nomeBusca").value;
		
			if (nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ') {
			
				var urlAction = document.getElementById("formUser").action;
			
			
			$.ajax({

							method : "get",
							url : urlAction,
							data : "nomeBusca=" + nomeBusca + "&acao=buscarProdutoAjax",
							success : function(response) {
							
							var json = JSON.parse(response);
							
							$('#tabelaresultados > tbody > tr').remove();
							 $("#ulPaginacaoUserAjax > li").remove();
					
							 for(var p = 0; p < json.length; p++){
							      $('#tabelaresultados > tbody').append('<tr> <td>'
							    	 +json[p].idproduto+'</td> <td> '
							    	 +json[p].nomeproduto+'</td> <td><button onclick="verEditar('
							    	 +json[p].idproduto+')" type="button" class="btn btn-info">Editar</button></td></tr>');
							  }
							 document.getElementById("totalResultados").textContent = 'Total de Resultados: '+ json.length + ' Produtos';
				}

			}).fail(
					function(xhr, status, errorThrown) {
						alert('Erro ao encontrar usuário por nome: '+ xhr.responseText);
					});
			
			
			}
			
			
			/*
			if (nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ') { //validando valor para busca no banco de Dados
	
				$.ajax({
					
					method : "get",
					url : urlAction,
					data : "nomeBusca=" + nomeBusca	+ "&acao=paginar",
					success : function(response, textStatus, xhr) {
						var json = JSON.parse(response);
						
						

												
						$('#tabelaresultados > tbody > tr').remove();
						$("#ulPaginacaoUserAjax > li").remove();
						 
						for (var p = 0; p < json.length; p++) {
							$('#tabelaresultados > tbody').append('<tr><td>'+ json[p].id 
									+ '</td><td>'
									+ json[p].nomeproduto
									+ '</td><td><button onclick="verEditar('
									+ json[p].idproduto
									+ ');" type="button" class="btn btn-info">Ver</button></td></tr>');
							
						} 
						
						document.getElementById("totalResultados").textContent = 'Total de Resultados: '+ json.length + ' Clientes';
						
						var totalPagina = xhr.getResponseHeader("totalPagina");
						
						 for (var p = 0; p < totalPagina; p++){
							
							 var url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina='+ (p * 5);
							 
							 $("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')">'+ (p + 1) +'</a></li>'); 
						 }
						
					}
					
				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao buscar o usuário por nome: '+ xhr.responseText);
						});	
			}
			*/
			
		}
	</script>
	
	<script type="text/javascript">
	
	function criaDeletecomAjax() {
		if (confirm("Deseja realmente excluir os seus dados?Os telefones e produtos deste usuário serão também automáticamente excluídos")) {

			var urlAction = document.getElementById("formUser").action;
			var idUser = document.getElementById("id").value;

			$.ajax({

				method : "get",
				url : urlAction,
				data : "id=" + idUser + "&acao=deletarajax",
				success : function(response) {
					
					limparform();
					document.getElementById('msg').textContent = response;
				}

			}).fail(
					function(xhr, status, errorThrown) {
						alert('Erro por deletar usuário por id: '
								+ xhr.responseText);
					});
		}
	}
	
	</script>

	

	


	

	


	
	

	<script type="text/javascript">
		function verEditar(id) {

			var urlAction = document.getElementById("formUser").action;

			window.location.href = urlAction + '?acao=editar&id=' + id;
		}
	</script>





	
	
	
	<script type="text/javascript">
	
	function buscaUserPagAjax(url){
		   
	    
	    var urlAction = document.getElementById('formUser').action;
	    var nomeBusca = document.getElementById('nomeBusca').value;
	    
		 $.ajax({	     
		     method: "get",
		     url : urlAction,
		     data : url,
		     success: function (response, textStatus, xhr) {
			 
			 var json = JSON.parse(response);
			 
			 
			 $('#tabelaresultados > tbody > tr').remove();
			 $("#ulPaginacaoUserAjax > li").remove();
			 
			  for(var p = 0; p < json.length; p++){
			      $('#tabelaresultados > tbody').append('<tr> <td>'+json[p].id+'</td> <td> '+json[p].nome+'</td> <td><button onclick="verEditar('+json[p].id+')" type="button" class="btn btn-info">Ver</button></td></tr>');
			  }
			  
			  document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
			  
			    var totalPagina = xhr.getResponseHeader("totalPagina");
		
			    for (var p = 0; p < totalPagina; p++){
				 
			    	var url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina='+ (p * 5);
				    $("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')">'+ (p + 1) +'</a></li>'); 
				      
				  }
			 
		     }
		     
		 }).fail(function(xhr, status, errorThrown){
		    alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
		 });
	    
	}
	
	
	</script>
	
	

</body>

</html>

