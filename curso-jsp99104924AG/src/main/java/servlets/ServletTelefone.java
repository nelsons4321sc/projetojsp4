package servlets;

import java.io.IOException;
import java.util.List;

import dao.DAOTelefoneRepository;
import dao.DAOUsuarioRepository;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelTelefone;

@WebServlet("/Telefone")
public class ServletTelefone extends ServleGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	private DAOTelefoneRepository daoTelefoneRepository = new DAOTelefoneRepository();
       
   
    public ServletTelefone() {
             
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			String acao = request.getParameter("acao");
		
			if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("excluir")) {
				
				String idfone = request.getParameter("id");
				
				daoTelefoneRepository.deleteFone(Long.parseLong(idfone));
				
				//parametro registrado no botão excluir do telefone.jsp
				String userpai = request.getParameter("userpai");
				
				//linha que preenche os campos após a exclusão
				ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(userpai));
				
				List<ModelTelefone> modelTelefones = daoTelefoneRepository.listfone(modelLogin.getId()); 
				
				request.setAttribute("modelTelefones", modelTelefones);
				request.setAttribute("msg", "Telefone excluído");
				request.setAttribute("modelLogin", modelLogin);
				request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);
				
				//para ser executado somente esse bloco, linha abaixo e não executar o outros ifs, executa o delete e para
				return;
					
			}
			 
			
			String idUser = request.getParameter("idUser");	
				
			
			
		if(idUser != null && !idUser.isEmpty()) {
		
			ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(idUser));
			
			List<ModelTelefone> modelTelefones = daoTelefoneRepository.listfone(modelLogin.getId()); 
			
			request.setAttribute("modelTelefones", modelTelefones);
			request.setAttribute("modelLogin", modelLogin);
			request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);
				
		} else {
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("modelLogins", modelLogins);
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
			request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
		
			String usuario_pai_id = request.getParameter("id");
			String numero = request.getParameter("numero");
			
			if (!daoTelefoneRepository.existefone(numero, Long.valueOf(usuario_pai_id))) {
			
				ModelTelefone modelTelefone = new ModelTelefone();
				
				modelTelefone.setNumero(numero);
				modelTelefone.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(Long.parseLong(usuario_pai_id)));
				modelTelefone.setUsuario_cad_id(super.getUserLogadoObjeto(request));
				
				
				daoTelefoneRepository.gravarTelefone(modelTelefone);
				
				request.setAttribute("msg", "Salvo com Sucesso");
				
			} else {
				request.setAttribute("msg", "Telefone já existe");
			}
			
			List<ModelTelefone> modelTelefones = daoTelefoneRepository.listfone(Long.parseLong(usuario_pai_id)); 
			
			//as 2 linhas abaixo são necessárias para que o formulário, preencha novamente com o usuário
			// e consiga assim ser gravado vários telefones com o mesmo usuário
			ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(usuario_pai_id));
			request.setAttribute("modelLogin", modelLogin);
			
			request.setAttribute("modelTelefones", modelTelefones);
			request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	
	}

}
