package servlets;

import java.io.Serializable;

import dao.DAOUsuarioRepository;
//import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ModelLogin;

public class ServleGenericUtil extends HttpServlet implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	
	
	public Long getUserLogado(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		String usuarioLogado = (String) session.getAttribute("usuario");
		
		
		
			return daoUsuarioRepository.consultarUsuarioLogado(usuarioLogado).getId();
	}
	
	public ModelLogin getUserLogadoObjeto(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		String usuarioLogado = (String) session.getAttribute("usuario");
		
		
		
		return daoUsuarioRepository.consultarUsuarioLogado(usuarioLogado);
		
		}
		
	}


