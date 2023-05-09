<%@page import="model.ModelLogin"%>
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

   <div class="pcoded-main-container">
   <div class="pcoded-wrapper">
   <jsp:include page="navBarMainMenuConta.jsp"></jsp:include>
   <div class="pcoded-content">
    <!-- Page-header start -->
                     <jsp:include page="page-headerConta.jsp"></jsp:include>
                      <!-- Page-header end -->
                       <div class="pcoded-inner-content">
                       			<div class="main-body">
                       			<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<div class="card" align="center">
										
											
												<!-- Basic Form Inputs card start -->
																															
														
                  
														<h6>Por gentileza, use a tecla tab, para edição ou preenchimento dos dados abaixo</h6>		
													</div>	
													<div class="formConta">											
														<form class="form-material" enctype="multipart/form-data"
															action="<%=request.getContextPath()%>/UsuárioCadastrado"
															method="post" id="formUser">
															<div align="center">
															<h3 style="color: red"><span id="msg">${msg}</span></h3>
															</div>	
															<input type="hidden" name="acao" id="acao" value="">
																			
															<div class="form-group form-default  form-static-label ">
															
																<input type="text" name="id" id=id class="form-control"
																	readonly="readonly" value="${modelLogin.id}"> <span
																	class="form-bar"></span>  
																<!-- <label class="float-label">ID</label>   -->
																<label class="float-label">Código de Registro</label>
															</div>
															
															<div class="form-group form-default  input-group mb-4 ">
																<div class="input-group-prepared">
															 
																
																	<img alt="Imagem User" id="fotoembase64" src="${modelLogin.fotouser}" width="70px">
																	
													
																<c:if test="${modelLogin.fotouser == '' || modelLogin.fotouser == null}">
																	<img alt="Imagem User" id="fotoembase64" src="assets/images/terno.png" width="70px">
																</c:if>
																
																</div>
																<input type="file" id="filefoto" name="filefoto" accept="image/*" onchange="visualizarimg('fotoembase64','filefoto');" class="form-control-file" style="margin-top: 15px; margin-left: 5px"> 																						
															</div>

															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id=nome
																	class="form-control" required="required"
																	value="${modelLogin.nome}"> <span
																	class="form-bar"></span> <label class="float-label">Nome</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="dataNascimento" id=dataNascimento
																	class="form-control" required="required"
																	value="${modelLogin.dataNascimento}" autocomplete="off"> <span
																	class="form-bar"></span> <label class="float-label">Data de Entrada</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input type="email" name="email" id=email
																	class="form-control" required="required"
																	autocomplete="off" value="${modelLogin.email}">
																<span class="form-bar"></span> <label
																	class="float-label">Email (exa@gmail.com)</label>
															</div>


															
															
															<div class="form-group form-default form-static-label">
                                                                <input onblur="pesquisaCep();" type="text" name="cep" id="cep" class="form-control" required="required" autocomplete="off" value="${modelLogin.cep}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Cep</label>
                                                            </div>
                                                            
															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="logradouro" id="logradouro" class="form-control" required="required" autocomplete="off" value="${modelLogin.logradouro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Logradouro</label>
                                                            </div> 
                                                            
															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="bairro" id="bairro" class="form-control" required="required" autocomplete="off" value="${modelLogin.bairro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Bairro</label>
                                                            </div>   
                                                            
															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="localidade" id="localidade" class="form-control" required="required" autocomplete="off" value="${modelLogin.localidade}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Localidade</label>
                                                            </div>     
                                                            
															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="uf" id="uf" class="form-control" required="required" autocomplete="off" value="${modelLogin.uf}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Estado</label>
                                                            </div>     
                                                            
															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="numero" id="numero" class="form-control" required="required" autocomplete="off" value="${modelLogin.numero}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Número</label>
                                                            </div>  
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="login" id=login
																	class="form-control" required="required"
																	autocomplete="off" value="${modelLogin.login}">
																<span class="form-bar"></span> <label
																	class="float-label">Login</label>

															</div>
															<div class="form-group form-default form-static-label">
																<input type="password" name="senha" id=senha
																	class="form-control" required="required"
																	autocomplete="off" value="${modelLogin.senha}">
																<span class="form-bar"></span> <label
																	class="float-label">Senha</label>
															</div>

									

															<!-- button Rounded -->
															<div align="center">
															
															
															<button	class="btn btn-success btn-round waves-effect waves-light">Salvar</button>
																<a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary btn-round waves-effect waves-light">Voltar</a>
																			
															
															
															</div>				
														</form>
																												</div>
													</div>
												</div>
											</div>
										</div>
										
									</div>
									</div>
									</div>
									<div id="styleSelector"> </div>
									</div>	
								
									
		
									
							
									
						
								<!-- Page-body end -->
								
							<!--  </div>
							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>-->

	


	
	
	
	<!-- Required Jquery -->
										<jsp:include page="javaScriptFile.jsp"></jsp:include>
	
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

