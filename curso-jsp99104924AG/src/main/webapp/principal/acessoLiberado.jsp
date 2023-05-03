<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<jsp:include page="headAcessoLiberado.jsp"></jsp:include>

<!--  <body style="background-color: #AED581"> -->
	<body style="background-color: #60a3bc">
	<div align= "center">
	<br>
	<br>	
	<br>
	<br>
	<div id="titulo">
	<div style="background-color: #FFFDE7" class="tela">
	<h1 id="acesso" style="color: green">Seu acesso foi Liberado</h1>
	</div>
	</div>
	
	
	
	  <form action="<%=request.getContextPath()%>/ControleUsuario"	method="post" id="formUser" class="row g-3 needs-validation" novalidate>
	<a class="usuario" href="principal/principal.jsp" title="Acesso a Usuários" >
		<img alt="Logo do usuário" src="assets/images/user.jpg"  width="200px" style="margin-right: 50px" >
		
				<input class="form-control" id="login" name="login" value="admin" type="hidden">
				<input class="form-control" id="senha" name="senha" value="admin" type="hidden" >
				
	</a>
		</form>
	
	
	
	
	</div>
	<a class="usuario" href="principal/produtos.jsp" title="Acesso a Produtos" >
	<img alt="" src="assets/images/produtos.png"  width="180px">
	</a>
	
	
	
	
	
</body>
</html>