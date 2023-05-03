<%@ page language="java" contentType="text/html; charset=UTF-8"
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
														<h3 >Cadastro de Produtos</h3>
														</div>
														<form class="form-material"  enctype="multipart/form-data" 
															action="<%=request.getContextPath()%>/ProdutoCliente"
															method="post" id="formProduto">
															
															
															<div class="form-group form-default  form-static-label ">
																<input type="text" name="id" id=id class="form-control"
																	readonly="readonly" value="${modelLogin.id}"> <span
																	class="form-bar"></span>  
																<!-- <label class="float-label">ID</label>   -->
																<label class="float-label">Código de Registro</label>
															</div>
															
															<div class="form-group form-default  form-static-label ">
																<input type="text" name="idproduto" id=idproduto class="form-control"
																	readonly="readonly" value="${modelProduto.idproduto}"> <span
																	class="form-bar"></span>  
																
																<label class="float-label">Produto ID</label>
															</div>
															
															<div class="form-group form-default form-static-label">
																<input readonly="readonly" type="text" name="nome" id="nome"
																	class="form-control" required="required"
																	value="${modelLogin.nome}"> <span
																	class="form-bar"></span> <label class="float-label">Usuário</label>
															</div>
															
															
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
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Nome do Produto</label>
															</div>
															 
															<div class="form-group form-default form-static-label">
																<input type="text" name="valor" id="valor"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Valor do Produto</label>
															</div>
															
															<div align="center">
															<c:if test="${modelLogin.id > 0}">
															<a href="<%= request.getContextPath() %>/ControleUsuario?acao=buscarEditar&id=${modelLogin.id}" class="btn btn-primary btn-round waves-effect waves-light">Voltar</a>
															</c:if>
															<button class="btn btn-success btn-round waves-effect waves-light">Salvar</button>
															</div>
														</form>
													</div>
												</div>
											</div>
									</div>
											<span id="msg">${msg}</span>
											
											
									<div style="height: 300px; overflow: scroll;">
										<table class="table" id="tabelaresultadosview">
											<thead>
												<tr>
													
													<th scope="col">ID</th>
													<th scope="col">nome do Produto</th>
													<th scope="col">Foto</th>
													<th scope="col" id="valor">valor</th>
													<th scope="col">Excluir</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${modelProdutos}" var="p">
													<tr>
														<!-- parametro userpai informado como parametro na ServletTelefone  -->
														<td><c:out value="${p.idproduto }"></c:out></td>
														<td><c:out value="${p.nomeproduto }"></c:out></td>
														<td>
															<img alt="Imagem produto" id="fotoembase64" src="${p.fotoproduto}" width="70px">
														</td>
														<td><c:out value="R$ ${p.valor }"></c:out></td>
														
														<td><a class="btn btn-success" href="<%= request.getContextPath() %>/ProdutoCliente?acao=excluir&id=${p.idproduto}&userpai=${modelLogin.id}">Excluir</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
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
    
    
    </body>

</html>

    