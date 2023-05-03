package servlets;

import java.io.IOException;
import java.util.List;

import dao.DAOUsuarioRepository;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ModelLogin;

/**
 * Servlet implementation class ServletPrincipal
 */
@WebServlet(urlPatterns = {"/ServletPrincipal"})
public class ServletPrincipal extends ServleGenericUtil {
	private static final long serialVersionUID = 1L;
       
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
    public ServletPrincipal() {
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
		
		String acao = request.getParameter("acao");
		
		if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("exibirTelaPrincipal")) {
		
			request.getRequestDispatcher("principal/telaPrincipal.jsp").forward(request, response);
			
		} else {
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("msg", "usuários carregados");
			request.setAttribute("modelLogins", modelLogins);
			
 			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
