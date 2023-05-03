<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tela que mostra os erros</title>
</head>
<body style="background-color: red">

<center><h1 style="color: #fff">ATENÇÃO: </h1></center>
<center><h1 style="color: #fff">Mensagem de Erro, entre em contato com a equipe de suporte do sistema.</h1><center>
<div style="background-color: #fff">
<%  
 out.print(request.getAttribute("msg"));
%>
</div>
</body>
</html>