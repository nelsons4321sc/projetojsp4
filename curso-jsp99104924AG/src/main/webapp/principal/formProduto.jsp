<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    
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
														
														<!--  <h2 style="color: red"><span id="msg">${msg}</span></h2>-->
														<h1 style="color: red"> Tela de Produto</h1>
														
														</div>
															
														
														
														<form class="form-material"  enctype="multipart/form-data" 
															action="<%=request.getContextPath()%>/ControleProduto"
															method="post" id="formProduto">
															
														  
															<div class="form-group form-default  form-static-label ">
																<input type="text" name="id" id=id class="form-control"
																	readonly="readonly" value="<%= request.getSession().getAttribute("idUsuario") %>"> <span
																	class="form-bar"></span>  
																<label class="float-label">Usuário ID</label>
															</div>
															 
															
														 
															<div class="form-group form-default  form-static-label ">
																<input type="text" name="idproduto" id=idproduto class="form-control"
																	readonly="readonly" value="${modelProduto.idproduto}"> <span
																	class="form-bar"></span>  
																
																<label class="float-label">Produto ID</label>
															</div>
															
															<!-- 
															<div class="form-group form-default form-static-label">
																<input readonly="readonly" type="hidden" name="nome" id="nome"
																	class="form-control" required="required"
																	value="${modelLogin.nome}"> <span
																	class="form-bar"></span> 
																	  <label class="float-label">Usuário</label>
															</div>
															 -->
															
															<div class="form-group form-default  input-group mb-4 ">
																<div class="input-group-prepared">
																
																<c:if test="${modelProduto.fotoproduto != '' && modelProduto.fotoproduto != null}">
																	<img alt="Imagem Produto" id="fotoembase64" src="${modelProduto.fotoproduto}" width="70px">
																</c:if>
																
																
																<c:if test="${modelProduto.fotoproduto == '' || modelProduto.fotoproduto == null}">
																  <img alt="Imagem Produto" id="fotoembase64" src="${modelProduto.fotoproduto}" width="70px">
																</c:if>
																
																</div>
																<input type="file" id="fotoproduto" name="fotoproduto" accept="image/*" onchange="visualizarimg('fotoembase64','fotoproduto');" class="form-control-file" style="margin-top: 15px; margin-left: 5px"> 																						
															</div>
															
															
															
															
															<div class="form-group form-default form-static-label">
																<input type="text" name="nomeproduto" id="nomeproduto"
																	class="form-control" required="required" value="${modelProduto.nomeproduto}" > <span
																	class="form-bar"></span> <label class="float-label">Nome do Produto</label>
															</div>
														
															<div class="form-group form-default form-static-label">
																<input type="text" name="valor" id="valor"
																	class="form-control" required="required" value="${modelProduto.valor}" > <span
																	class="form-bar"></span> <label class="float-label">Valor do Produto</label>
															</div>
															<!--  value="${modelProduto.valor}"
																  value="${modelProduto.nomeproduto}"	-->
															<div align="center">
															
															<button class="btn btn-success btn-round waves-effect waves-light">Salvar</button>
															
															</div>
														</form>
													</div>
												</div>
											</div>
									</div>
											
											
	
	 
											
									
											
                                    </div>
                                    <!-- Page-body end -->
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Required Jquery -->
    <jsp:include page="javaScriptFile.jsp"></jsp:include>
    
    
    
    
    <script type="text/javascript">
	
		function visualizarimg(fotoembase64,fotoproduto) {
			
			var preview = document.getElementById(fotoembase64); // campo IMG do HTML
			var fotoproduto =  document.getElementById(fotoproduto).files[0];
			var reader = new FileReader();
			
			reader.onloadend = function () {
				preview.src = reader.result; // carrega a foto na tela	
			};
			
			if(fotoproduto) { // se realmente a foto for carregada
				reader.readAsDataURL(fotoproduto);// Preview da IMG
			} else{
				preview.src =' ';
			}
		}
	
	
	</script>
    
    <script type="text/javascript">
		$("#valor").maskMoney({
			showSymbol : true,
			symbol : "R$ ",
			thousands : '.',
			decimal : ","
		});

		const formatter = new Intl.NumberFormat("pt-BR", {
			currency : "BRL",
			minimumFractionDigits : 2

		});

		$("#valor").val(formatter.format($("#valor").val()));

		$("#valor").focus();
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

										document.getElementById("totalResultados").textContent = 'Total de Resultados: '+ json.length + ' Clientes';
										
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

    