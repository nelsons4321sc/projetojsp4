package servlets;

import java.io.IOException;


import dao.DAOLoginRepository;
import dao.DAOUsuarioRepository;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import model.ModelLogin;

/*
 * Por que Deus amou o mundo de tal maneira, que deu seu próprio Filho,
 * para que todo aquele que nEle crer não pereção, mas tenha a vida eterna
 * 
 * 
 * Por que o salário(a recompensa) do pecado(a desobediência a Deus-Trino) é a 
 * morte(separação da vida de Deus), mas o dom gratuíto de Deus é vida eterna em Cristo
 * Jesus.
 */

@WebServlet(urlPatterns = {"/principal/ServletLogin", "/ServletLogin"}) /*Mapeamento de URL que vem da tela*/
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DAOLoginRepository dao  =  new DAOLoginRepository();
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
    public ServletLogin() {
       
    }
    //Recebe a url dos parametros	
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
	
	
	// Recebe os dados enviados por um formulário	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// pra atualizar e gravar
		
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		String url = request.getParameter("url");
		
		try {
			ModelLogin modelLogin = new ModelLogin();
			
			
		
				if(login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
					
				//modelLogin.setId(null);
				modelLogin.setLogin(login);
				modelLogin.setSenha(senha);
				
				if(dao.validarAutenticacao(modelLogin)) {
					
					modelLogin = daoUsuarioRepository.consultarUsuarioLogado(login);
					// para recuperar o id do login
					request.getSession().setAttribute("idUsuario", modelLogin.getId());
					
					request.getSession().setAttribute("usuario", modelLogin.getLogin());
					
					request.getSession().setAttribute("imagemUser", modelLogin.getFotouser());
					
					
					if(url ==null || url.equals("null")) {
						url = "principal/acessoLiberado.jsp";
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
