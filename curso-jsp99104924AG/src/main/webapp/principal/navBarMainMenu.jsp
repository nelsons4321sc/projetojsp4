<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    


    
     <c:set scope="session" var="perfil" value='<%= request.getSession().getAttribute("perfil") %>'></c:set>

    
              <nav class="pcoded-navbar">
                      <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                      <div class="pcoded-inner-navbar main-menu">
                          <div class="">
                              <div class="main-menu-header">
                              
                              
								<c:if test="${imagemUser != '' && imagemUser != null}">			                              
                                  <img class="img-80 img-radius" src=" ${imagemUser}"  alt="User-Profile-Image">
                                  
                                 </c:if>
                                 
                                  <c:if test="${imagemUser == '' || imagemUser == null}">			                              
                                  <img class="img-80 img-radius" src="<%= request.getContextPath() %>/assets/images/user.jpg" alt="User-Profile-Image">
                                 </c:if>
                                  <div class="user-details">
                                   <c:if test="${usuario != ''  && usuario != null}">  
                                      <span id="more-details"><%= session.getAttribute("usuario") %><i class="fa fa-caret-down"></i></span>
                                 	</c:if>
                                  </div>
                              </div>
        
                              <div class="main-menu-content">
                                  <ul>
                                      <li class="more-details">
                                          <!--  <a href="user-profile.html"><i class="ti-user"></i>View Profile</a>-->
                                          <!--  <a href="#!"><i class="ti-settings"></i>Settings</a> -->
                                          <a href="<%= request.getContextPath() %>/UsuárioCadastrado?acao=logout"><i class="ti-layout-sidebar-left"></i>Editar</a>
                                         
                                      </li>
                                  </ul>
                                  <ul>
                                      <li class="more-details">
                                          <!--  <a href="user-profile.html"><i class="ti-user"></i>View Profile</a>-->
                                          <!--  <a href="#!"><i class="ti-settings"></i>Settings</a> -->
                                          <a href="<%= request.getContextPath() %>/ServletLogin?acao=logout"><i class="ti-layout-sidebar-left"></i>Sair</a>
                                         
                                      </li>
                                  </ul>
                              </div>
                          </div>
                          
                               
                           
                          <ul class="pcoded-item pcoded-left-item">
                              <li class="active">
                                  <a href="<%= request.getContextPath() %>/ServletPrincipal?acao=exibirTelaPrincipal" class="waves-effect waves-dark" style="margin-top: 15px">
                                      <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.dash.main">Principal</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              
                              
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Cadastro</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                      
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/ControleUsuario?acao=listarUser" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                            
                                           <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Cliente</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                  </ul>
                                      <ul class="pcoded-submenu">
                                      
                                      <li class=" ">
                                         <!-- <a href="<%= request.getContextPath() %>/ControleProduto?acao=listarProduto" class="waves-effect waves-dark"> --> 
                                         <a href="<%= request.getContextPath() %>/principal/formProduto.jsp" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                            
                                           <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Produto</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                  </ul>
                              </li>
                              
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Lista</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                      
                                      <li class=" ">
                                          <a href="<%= request.getContextPath() %>/ControleUsuario?acao=listarTabUser" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Clientes</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      
                                       <li class=" ">
                                          <a href="<%= request.getContextPath() %>/ControleProduto?acao=listarTabProduto" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Produtos</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                   
                                      
                                    
                                  </ul>
                              </li>
                              
                              
                          </ul>
                          
                         	<!--    
                        <div class="pcoded-navigation-label" data-i18n="nav.category.forms" style="color: green">Amostragens</div>
                        
                          <ul class="pcoded-item pcoded-left-item">
                              
                              <li >
                                  <a href="<%= request.getContextPath() %>/principal/reluser.jsp" class="waves-effect waves-dark" style="margin-top: 15px">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext" >Realatório de Clientes</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li> 
                              
                              <li>
                                  <a href="<%=request.getContextPath() %>/principal/relusergrafico.jsp" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.form-components.main">Gráfico</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                           </ul>
                          
        				
        				
        			 
                          <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Chart &amp; Maps</div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li>
                                  <a href="chart.html" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.form-components.main">Chart</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              <li>
                                  <a href="map-google.html" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.form-components.main">Maps</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                              </li>
                              <li class="pcoded-hasmenu">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                      <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Pages</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                      <li class=" ">
                                          <a href="auth-normal-sign-in.html" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Login</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <li class=" ">
                                          <a href="auth-sign-up.html" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Register</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <li class=" ">
                                          <a href="sample-page.html" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Sample Page</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                  </ul>
                              </li>
        
                          </ul>
        				-->	
        				<!--  
                          <div class="pcoded-navigation-label" data-i18n="nav.category.other">Other</div>
                          <ul class="pcoded-item pcoded-left-item">
                              <li class="pcoded-hasmenu ">
                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                      <span class="pcoded-micon"><i class="ti-direction-alt"></i><b>M</b></span>
                                      <span class="pcoded-mtext" data-i18n="nav.menu-levels.main">Menu Levels</span>
                                      <span class="pcoded-mcaret"></span>
                                  </a>
                                  <ul class="pcoded-submenu">
                                      <li class="">
                                          <a href="javascript:void(0)" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-21">Menu Level 2.1</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                                      <li class="pcoded-hasmenu ">
                                          <a href="javascript:void(0)" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-direction-alt"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.main">Menu Level 2.2</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                          <ul class="pcoded-submenu">
                                              <li class="">
                                                  <a href="javascript:void(0)" class="waves-effect waves-dark">
                                                      <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                      <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.menu-level-31">Menu Level 3.1</span>
                                                      <span class="pcoded-mcaret"></span>
                                                  </a>
                                              </li>
                                          </ul>
                                      </li>
                                      <li class="">
                                          <a href="javascript:void(0)" class="waves-effect waves-dark">
                                              <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                              <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-23">Menu Level 2.3</span>
                                              <span class="pcoded-mcaret"></span>
                                          </a>
                                      </li>
                
                                  </ul>
                              </li>
                          </ul>
                          -->
                      </div>
              
                      
                  </nav>
                        
	              