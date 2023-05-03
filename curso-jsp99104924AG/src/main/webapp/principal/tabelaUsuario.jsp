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
								<form class="form-material" enctype="multipart/form-data" action="<%=request.getContextPath()%>/ControleUsuario" method="post" id="formUser">
										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-block">
														<div align="center">
															<h2 style="color: red">Lista de Clientes</h2>
                                             			</div>												
													</div>
												</div>
											</div>
										</div>
										<div align="center">
										<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>
											<c:if test="${modelLogin.id > 0}">
												<a href="<%= request.getContextPath() %>/ServletTelefone?idUser=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Telefone</a>
												<a href="<%= request.getContextPath() %>/ServletProdutoController?idUser=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Produto</a>
											</c:if>						
										</div>	
									<div style="height: 300px; overflow: scroll;">
										<table class="table" id="tabelaresultadosview">
											<thead>
												<tr>
													
													<th scope="col">Nome</th>
													<th scope="col">Email</th>
													
												</tr>
											</thead>
											<tbody>
											<!-- A varável ml é criada apontando para o modelLogins aula 22.49 -->
												<c:forEach items="${modelLogins}" var="ml">
													<tr>
														
														<td><c:out value="${ml.nome }"></c:out></td>
														<td><c:out value="${ml.email }"></c:out></td>
														
														<td><a class="btn btn-success"
															href="<%= request.getContextPath() %>/ControleUsuario?acao=buscarEditar&id=${ml.id}">Ver</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									
									<div align="center">
									<nav aria-label="Navegar por páginas">
											<ul class="pagination">
											<!-- Capturando com a palavra totalPagina o atributo da ServletController -->
											   <%
											     int totalPagina = (int) request.getAttribute("totalPagina");
											   
											    for (int p = 0; p < totalPagina; p++){
											    	String url = request.getContextPath() + "/ControleUsuario?acao=paginar&pagina=" + (p * 5);  
											    	out.print("<li class=\"page-item\"><a class=\"page-link\" href=\""+ url +"\">"+(p + 1)+"</a></li>");
											    }
											   
											   %>
											
												
											</ul>
										</nav>
									</div>													
									
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
					<h5 class="modal-title" id="exampleModalLabel">Pesquisa de Cliente</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
				
					<!-- CAMPOS -->
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Nome do Usuário" aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button" onclick="buscarUsuario();">Localizar</button>
						</div>
					</div>


					<!-- TABELA -->
					<div style="height: 300px; overflow: scroll;">
						<table class="table" id="tabelaresultados">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Nome</th>
									<th scope="col">Visualizar</th>
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
		function buscarUsuario() {
			
			var urlAction = document.getElementById("formUser").action;
			
			var nomeBusca = document.getElementById("nomeBusca").value;
			
			if (nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ') { //validando valor para busca no banco de Dados
	
				$.ajax({
					
					method : "get",
					url : urlAction,
					data : "nomeBusca=" + nomeBusca	+ "&acao=buscarUserajax",
					success : function(response, textStatus, xhr) {
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
						$("#ulPaginacaoUserAjax > li").remove();
						 
						for (var p = 0; p < json.length; p++) {
							$('#tabelaresultados > tbody').append('<tr><td>'+ json[p].id 
									+ '</td><td>'
									+ json[p].nome
									+ '</td><td><button onclick="verEditar('
									+ json[p].id
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
	</script>
	

	

	


	

	


	
	

	<script type="text/javascript">
		function verEditar(id) {

			var urlAction = document.getElementById("formUser").action;

			window.location.href = urlAction + '?acao=buscarEditar&id=' + id;
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

