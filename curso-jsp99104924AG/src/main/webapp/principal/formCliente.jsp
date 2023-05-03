<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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

										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-block">
													<div align="center">
														<h2> Cadastro de Cliente</h2>
																						
														
                                              <!--item 2 - enctype="multipart/form-data" é acrescentado por causa do upload de imagens, 
                                              por isso que ele precisa ter esse tipo de envio de dados,  e na ServletUsuarioControler também é alterada  -->
																
													</div>												
														<form class="form-material" enctype="multipart/form-data"
															action="<%=request.getContextPath()%>/ControleUsuario"
															method="post" id="formUser">

															<input type="hidden" name="acao" id="acao" value="">
																			
															<div class="form-group form-default  form-static-label ">
															
																  <input type="hidden" name="id" id=id class="form-control"
																	readonly="readonly" value="<%= request.getSession().getAttribute("id") %>">
																	
																	
																	 <span
																	class="form-bar">
																	</span>  
																<!-- <label class="float-label">ID</label>   -->
																<!--<label class="float-label">Código de Registro</label>-->
															</div>
															
																
																														
															
															<!--
															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id=nome
																	class="form-control" required="required"
																	value="${modelLogin.nome}"> <span
																	class="form-bar"></span> <label class="float-label">Nome</label>
															</div>
															-->
															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id="nomeproduto"
																	class="form-control" required="required" value="${modelCliente.nome}" > <span
																	class="form-bar"></span> <label class="float-label">Nome do Cliente</label>
																	session.removeAttribute
																	<input type="text" name="id" id=id class="form-control"
																	readonly="readonly" value="<%= request.getSession().getAttributeNames() %>">
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="email" name="email" id=email
																	class="form-control" required="required"
																	autocomplete="off" value="${modelCliente.email}">
																<span class="form-bar"></span> <label
																	class="float-label">Email (exa@gmail.com)</label>
															</div>

															<div class="form-group form-default form-static-label">
																														<!-- button Rounded -->
															<div align="center">
															<p>
																Escolha a
																<code>OPÇÃO</code>
																desejada
															</p>
															<button
																class="btn btn-primary btn-round waves-effect waves-light"
																onclick="limparform();">Novo</button>
															<button
																class="btn btn-success btn-round waves-effect waves-light">Salvar</button>
															<button type="button"
																class="btn btn-danger btn-round waves-effect waves-light"
																onclick="criaDeletecomAjax();">Excluir</button>
															<!--  <button type="button" class="btn btn-secondary"
																data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>-->
															<c:if test="${modelLogin.id > 0}">
															<a href="<%= request.getContextPath() %>/Telefone?idUser=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Telefone</a>
															<a href="<%= request.getContextPath() %>/ServletProdutoClienteController?idUser=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Produto</a>
															</c:if>
															</div>					
														</form>

													</div>
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
	<div class="modal fade" id="exampleModalUsuario" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Pesquisa de
						usuário</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				
				<div class="modal-body">
					<!-- CAMPOS -->
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="Nome do Usuário" aria-label="nome" id="nomeBusca"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-success" type="button"
								onclick="buscarUsuario();">Localizar</button>
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
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Fechar</button>

				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$("#rendamensal").maskMoney({showSymbol:true, symbol:"R$ ",thousands: '.', decimal:"," });
	
	const formatter = new Intl.NumberFormat("pt-BR", {
		currency: "BRL",
		minimumFractionDigits : 2
		
	});
	
	$("#rendamensal").val(formatter.format($("#rendamensal").val()));
	
	$("#rendamensal").focus();
	
	
	</script>
	
	<script type="text/javascript">
	
	
	
	var dataNascimento = $("#dataNascimento").val();
	
	
	if(dataNascimento != null && dataNascimento!= '') {
		var dateFormat = new Date(dataNascimento);
		
		$("#dataNascimento").val(dateFormat.toLocaleDateString('pt-BR',{timeZone: 'UTC'}));
	}
	
	
	
	$("nome").focus();	
	
		
	$( function() {
		  
		  $("#dataNascimento").datepicker({
			    dateFormat: 'dd/mm/yy',
			    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
			    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
			    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
			    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
			    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
			    nextText: 'Próximo',
			    prevText: 'Anterior'
			});
	} );
	
	
	</script>
	
	

	<script type="text/javascript">
	
	//para aceitar sómente números, id=numero 
	$("#numero").keypress(function (event) {
		return /\d/.test(String.fromCharCode(event.keyCode));
	});
	
	//para aceitar sómente números, id=cep 
	$("#cep").keypress(function (event) {
		return /\d/.test(String.fromCharCode(event.keyCode));
	});
	
	function pesquisaCep() {
	    var cep = $("#cep").val();
	    
	    $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) { 

		if (!("erro" in dados)) {
		        $("#cep").val(dados.cep);
		        $("#logradouro").val(dados.logradouro);
	            $("#bairro").val(dados.bairro);
	            $("#localidade").val(dados.localidade);
	            $("#uf").val(dados.uf);
		}
		    
		
	    });
	}
	</script>

	<script type="text/javascript">
	
		function limparform() {
			var elementos = document.getElementById("formUser").elements;

			for (p = 0; p < elementos.length; p++) {
				elementos[p].value = '';
			}
			
		}
	</script>


	<script type="text/javascript">
	
		function criarDelete() {
			if (confirm("Deseja realmente excluir os dados?")) {

				document.getElementById("formUser").method = 'get';
				document.getElementById("acao").value = 'deletar';
				document.getElementById("formUser").sunbmit();
			}
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
	
		function visualizarimg(fotoembase64,filefoto) {
			var preview = document.getElementById(fotoembase64); // campo IMG do HTML
			var fileuser =  document.getElementById(filefoto).files[0];
			var reader = new FileReader();
			
			reader.onloadend = function () {
				preview.src = reader.result; // carrega a foto na tela	
			};
			
			if(fileuser) { // se realmente a foto for carregada
				reader.readAsDataURL(fileuser);// Preview da IMG
			} else{
				preview.src =' ';
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




	<script type="text/javascript">
	
		function buscarUsuario() {
			
			var nomeBusca = document.getElementById("nomeBusca").value;

			if (nomeBusca != null && nomeBusca != ' ' && nomeBusca.trim() != ' ') {

				var urlAction = document.getElementById("formUser").action;
				var idUser = document.getElementById("id").value;

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

										document.getElementById("totalResultados").textContent = 'Total de Resultados: '+ json.length + ' usuários';
										
										 var totalPagina = xhr.getResponseHeader("totalPagina");
										 
										 for (var p = 0; p < totalPagina; p++){
											var url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina='+ (p * 5);
										   
											$("#ulPaginacaoUserAjax").append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\''+url+'\')">'+ (p + 1) +'</a></li>'); 
										      
										  }
										
										
										

									}

								}).fail(
								function(xhr, status, errorThrown) {
									alert('Erro ao buscar o usuário por nome: '
											+ xhr.responseText);
								});

			}

		}
	</script>
	
	

</body>

</html>

