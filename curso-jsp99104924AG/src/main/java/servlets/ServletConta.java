package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import model.ModelLogin;

@WebServlet("/ContaUsuário")
public class ServletConta extends ServleGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOLoginRepository dao  =  new DAOLoginRepository();
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	   
    public ServletConta() {
             
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		// para deletar e consultar
		String acao = request.getParameter("acao");
		
		if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("logout")) {
			request.getSession().invalidate(); // invalida a sessão e retorna para o login, como não existe
			RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
			redirecionar.forward(request, response);
		} else {
		
		doPost(request, response);
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// pra atualizar e gravar
				String login = request.getParameter("login");
				String senha = request.getParameter("senha");
				String url = request.getParameter("url");
				
				try {
				
						if(login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
						
						ModelLogin modelLogin = new ModelLogin();
						modelLogin.setLogin(login);
						modelLogin.setSenha(senha);
						
						if(dao.validarAutenticacao(modelLogin)) {
							
							modelLogin = daoUsuarioRepository.consultarUsuarioLogado(login);
							
							request.getSession().setAttribute("usuario", modelLogin.getLogin());
							request.getSession().setAttribute("imagemUser", modelLogin.getFotouser());
							
							
							if(url ==null || url.equals("null")) {
								url = "principal/contausuario.jsp";
							}
							
							RequestDispatcher redirecionar = request.getRequestDispatcher(url);
							redirecionar.forward(request, response);
							
						} else {
							// no trecho abaixo é colocado barra para que ele volte a página anterior
							RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp");
							request.setAttribute("msg", "Informe o seu login e senha corretamente");
							redirecionar.forward(request, response);
						}
					} else {
						RequestDispatcher redirecionar = request.getRequestDispatcher("index.jsp");
						request.setAttribute("msg", "Informe o seu login e senha corretamente");
						redirecionar.forward(request, response);
					}
						
				}catch (Exception e) {
					e.printStackTrace();
					RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
					request.setAttribute("msg", e.getMessage());
					redirecionar.forward(request, response);
				}
	
	}

}
