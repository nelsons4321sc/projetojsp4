<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PROJETO JSP</title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/estilo.css" />
</head>
<body>
	<div class="container h-100">
      <div class="d-flex justify-content-center h-100">
        <div class="user_card">
          <div class="d-flex justify-content-center">
            <div class="brand_logo_container">
              <img
                src="assets/images/leao.png"
                class="brand_logo"
                alt="Logo"
              />
            </div>
          </div>
          <div class="d-flex justify-content-center form_container">
            <form action="<%= request.getContextPath() %>/ServletLogin" method="post" class=" needs-validation" novalidate>
              <input type="hidden" value="<%= request.getParameter("url")  %>" name="url">
              <div class="input-group mb-3">
                <div class="input-group-append">
                  <span class="input-group-text"
                    ><i class="fas fa-user"></i
                  ></span>
                </div>
                <input
                  type="text"
                  name="login"
                  class="form-control input_user"
               
                  placeholder="username" required ="required"
                />
                <div class="invalid-feedback" >
        			Informe o login.
      			</div>
              </div>
              <div class="input-group mb-2">
                <div class="input-group-append">
                  <span class="input-group-text"
                    ><i class="fas fa-key"></i
                  ></span>
                </div>
                <input
                  type="password"
                  name="senha"
                  class="form-control input_pass"
                 
                  placeholder="password" required ="required" 
                />
                <br/>
                
               <div class="invalid-feedback">
       			 Informe a senha.
      		  </div>
              </div>
              <div class="form-group">
                <div class="custom-control custom-checkbox">
                  <input
                    type="checkbox"
                    class="custom-control-input"
                    id="customControlInline"
                  />
                  
                  
              </div>
              <div class="d-flex justify-content-center mt-3 login_container">
                  <input type="submit" value="Login"  class="btn login_btn">
              </div>
            </form>
            
            <h4 class="msg" >${msg}</h4>
            <br/>
          
            <h8 >Caso não tenha conta, clique para:</h8>
            <div class="d-flex justify-content-center mt-3 login_container">
            
             <br/>
            <form action="<%= request.getContextPath() %>/ContaUsuário" method="post" class="row g-3 needs-validation" novalidate>
				<input class="form-control" id="login" name="login" value="admin" type="hidden">
				<input class="form-control" id="senha" name="senha" value="admin" type="hidden" >
				<input type="submit" value="cadastrar" class="btn btn-primary">
				
				</form>
            </div>
            
            
          </div>
			
          
        </div>
      </div>
      
    </div>
    
    
    <script type="text/javascript" src="assets/js/jquery-3.6.3.min.js"></script>
    <script type="text/javascript" src ="assets/js/mostrarSenha.js"></script>
    <script
      type="text/javascript"
      src="assets/js/bootstrap.bundle.min.js"
    ></script>
    <script type="text/javascript">
//Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
  'use strict'

  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  var forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }

        form.classList.add('was-validated')
      }, false)
    })
})()


</script>

<script type="text/javascript">
function clicou(){
	const input = document.querySelector('custom-control-input');
	input.setAttribute('type','text');
}
</script>
</body>
</html>