package servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOProdutoRepository;
import dao.DAOUsuarioRepository;
import model.ModelLogin;
import model.ModelProduto;

@MultipartConfig
@WebServlet("/ControleProduto")
public class ServletProdutoController extends ServleGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	private DAOProdutoRepository daoProdutoRepository = new DAOProdutoRepository();
       
   
    public ServletProdutoController() {
             
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			String acao = request.getParameter("acao");
			ModelLogin modelLogin = new ModelLogin();
			request.getSession().getAttribute("idUsuario"); 
			
			HttpSession session = request.getSession();
			 long idUser = (long) session.getAttribute("idUsuario");
			 modelLogin.setId(idUser);
			//long idUser = modelLogin.getId();
			modelLogin = daoUsuarioRepository.consultarUsuarioID(idUser);
			
			
			 
			
			if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("editar")) {
				
				String id = request.getParameter("id");
												
				//daoProdutoRepository.listProduto2(Long.parseLong(id));
				
				//String userpai = request.getParameter("userpai");
				
			    //modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(userpai));
				modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(id));
				
				//daoProdutoRepository.listProduto(Long.parseLong(userpai));
				daoProdutoRepository.listProduto(Long.parseLong(id));
				
				
				
				//List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				
				//parametro registrado no botão excluir do produto.jsp
				
				
				
				
				
				//linha que preenche os campos após a exclusão
				//ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(userpai));
				
				//ModelProduto modelProduto = daoProdutoRepository.consultarProdutoID(id, super.getUserLogado(request));
				ModelProduto modelProduto = daoProdutoRepository.consultarProdutoID(id);
				
			    //List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(modelLogin.getId());
				List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(super.getUserLogado(request));
			   // List<ModelProduto> modelProdutos = daoProdutoRepository.listTodosProduto(modelLogin.getId());
				
				
				request.setAttribute("modelProdutos", modelProdutos);
				request.setAttribute("msg", "Produto em Edição ");
				request.setAttribute("modelLogin", modelLogin);
				request.setAttribute("modelProduto", modelProduto);
				request.setAttribute("totalPagina", daoProdutoRepository.totalPagina(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);
				
				//para ser executado somente esse bloco, linha abaixo e não executar o outros ifs, executa o delete e para
				return;
					
			} 
			
			if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarProduto")) {
				
	 			List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(idUser);
	 			
				request.setAttribute("msg", "Cadastro de Produto");
				request.setAttribute("modelProdutos", modelProdutos);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response); 
			}
			
			 if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarTabProduto")) {	
				
				//List<ModelProduto> modelProdutos = daoProdutoRepository.listTodosProduto(modelLogin.getId());
				 List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(super.getUserLogado(request));
				
				request.setAttribute("msg", "Produtos carregados");
				request.setAttribute("modelProdutos", modelProdutos);
				request.setAttribute("totalPagina", daoProdutoRepository.totalPagina(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/tabelaProduto.jsp").forward(request, response);
		}
			 
	       // int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
			 if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
				
				 Integer offset = Integer.parseInt(request.getParameter("pagina"));
				 
				// List<ModelProduto> modelProdutos = daoProdutoRepository.consultaProdutoListPagina(nomeBusca, super.getUserLogado(request));
				 List<ModelProduto> modelProdutos = daoProdutoRepository.consultaProdutoListPaginada(this.getUserLogado(request), offset);
				 request.setAttribute("modelProdutos", modelProdutos);
			     request.setAttribute("totalPagina", daoProdutoRepository.totalPagina(this.getUserLogado(request)));
				 request.getRequestDispatcher("principal/tabelaProduto.jsp").forward(request, response);
				 
			 }	
			 
			
			 
			 if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarajax")) {
					
					String idProduto = request.getParameter("idProduto");
					
					daoProdutoRepository.deleteProduto(Long.parseLong(idProduto));
					
					response.getWriter().write("Exclusão feita com sucesso");
					
			}
			 
			 if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("excluir")) {
					
					String id = request.getParameter("id");
					
					daoProdutoRepository.deleteProduto(Long.parseLong(id));
					
					//parametro registrado no botão excluir do produto.jsp
					//String userpai = request.getParameter("userpai");
					
					//linha que preenche os campos após a exclusão
					modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(id));
					
					//List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(Long.parseLong(id)); 
					
					List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(super.getUserLogado(request));
					
					request.setAttribute("modelProdutos", modelProdutos);
					request.setAttribute("msg", "Produto excluído");
					request.setAttribute("modelLogin", modelLogin);
					request.setAttribute("totalPagina", daoProdutoRepository.totalPagina(this.getUserLogado(request)));
					//request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);
					request.getRequestDispatcher("principal/tabelaProduto.jsp").forward(request, response);
					
					//para ser executado somente esse bloco, linha abaixo e não executar o outros ifs, executa o delete e para
					return;
						
				}
			 
			 
			 if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarProdutoAjax")) {
					
					String nomeBusca = request.getParameter("nomeBusca");
					//List<ModelProduto> dadosJsonUser = daoProdutoRepository.consultaProdutoList(nomeBusca, super.getUserLogado(request));
					List<ModelProduto> dadosJsonUser = daoProdutoRepository.consultaProdutoList(nomeBusca);
									
					ObjectMapper mapper = new ObjectMapper();
					
					String json = mapper.writeValueAsString(dadosJsonUser);
					
					
					
					//response.addHeader("totalPagina", ""+ daoUsuarioRepository.consultaUsuarioListTotalPaginaPaginacao(nomeBusca, super.getUserLogado(request)));
					response.getWriter().write(json);
					
					
			}
			 
			 
			
			 
			
			//String idUserA = Long.toString(idUser); //RETIRADO 20/04/2023
			//String idUserA = request.getParameter("id");
			
			
			//modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(idUserA));
			
			
			
			
		//if(idUserA != null && !idUserA.isEmpty()) {
			// if(daoUsuarioRepository.consultarUsuarioID(super.getUserLogado(request)) != null && daoUsuarioRepository.consultarUsuarioID(super.getUserLogado(request)).equals("") ) {	 
			//modelLogin.setId(Long.parseLong(idUserA));
			
			//String id = request.getParameter("id");
			
			//ModelProduto2 modelProduto = daoProdutoRepository.consultarProdutoID(id); 
			//ModelProduto modelProduto = new ModelProduto();
						//modelLogin.setId(idUser); RETIRADO 20/04/2023
			
			//List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(idUser); RETIRADO 20/04/2023
			//List<ModelProduto> modelProdutos = daoProdutoRepository.listTodosProduto(modelLogin.getId());
			//List<ModelProduto> modelProdutos = daoProdutoRepository.listTodosProduto(super.getUserLogado(request));
			
			//request.setAttribute("msg", "Cadastro de Produto");
			//request.setAttribute("modelProdutos", modelProdutos);
			//request.setAttribute("modelProduto", modelProduto);
			//request.setAttribute("modelLogin", modelLogin.getId());
			//request.setAttribute("modelLogin", modelLogin);
			
			//request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);  RETIRADO 20/04/2023
			//request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);
				
		//} 
		
		
		else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) {
					
			String idUserA = request.getParameter("id");
			 
			 //ModelProduto modelProduto =  daoUsuarioRepository.consultarUsuarioID(idUser, super.getUserLogado(request, response));
			  ModelProduto modelProduto =  (ModelProduto) daoProdutoRepository.listProduto(Long.parseLong(idUserA));
			 if (modelProduto.getFotoproduto() != null && !modelProduto.getFotoproduto().isEmpty()) {
				 
				 response.setHeader("Content-Disposition", "attachment;filename=arquivo." + modelProduto.getFotoproduto());
				 response.getOutputStream().write(new Base64().decodeBase64(modelProduto.getFotoproduto().split("\\,")[1]));
				 
			 }
			 request.setAttribute("modelProduto", modelProduto);
		
		}
		
		
		
		else {
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("modelLogins", modelLogins);
			request.setAttribute("totalPagina", daoUsuarioRepository.totalPagina(this.getUserLogado(request)));
			//request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
			//equest.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String usuario_pai_id = request.getParameter("id");
	
		try {
			// os dois ids estão aparecendo o usuário que cadastrou e não aparece o id do produto
			String msg = "Operação realizada com sucesso";
			
			HttpSession session = request.getSession();
			 long idUser = (long) session.getAttribute("idUsuario");
			
			//String usuario_pai_id = request.getParameter("id");
			String id = request.getParameter("idproduto");
			String nomeproduto = request.getParameter("nomeproduto");
			String valor = request.getParameter("valor");
			//necessário quebra com espaço para virar somente numeros e assim poder ser gravado na coluna
			// double da tabela de dados
			valor = valor.split("\\ ")[1].replaceAll("\\.", "").replaceAll("\\,", ".");
									
			ModelProduto modelProduto = new ModelProduto();
			
			//id foi acrescentado
				modelProduto.setIdproduto(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
				/*
				 *  public void checkAllParametersSet() throws SQLException {
    for (int i = 0; i < paramTypes.length; ++i) {
      if (direction(i) != OUT && paramValues[i] == null) {
        throw new PSQLException(GT.tr("No value specified for parameter {0}.", i + 1),
            PSQLState.INVALID_PARAMETER_VALUE);
      }
    }
  }

				 */
				
				modelProduto.setNomeproduto(nomeproduto);
				modelProduto.setValor(Double.parseDouble(valor));
				
				//modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(Long.parseLong(usuario_pai_id)));
				modelProduto.setUsuario_pai_id(super.getUserLogadoObjeto(request));
				modelProduto.setUsuario_cad_id(super.getUserLogadoObjeto(request));
				
				//ModelLogin modelProduto = modelProduto.setUsuario_cad_id(idUser);
				//request.getPart("fotoproduto" é o usado na tela formproduto abaixo:
				//<input type="file" id="fotoproduto" name="fotoproduto" accept="image/*" onchange="visualizarimg('fotoembase64','fotoproduto');" class="form-control-file" style="margin-top: 15px; margin-left: 5px">
			if(request.getPart("fotoproduto") != null) {
				//ModelProduto modelProduto1 = new ModelProduto();
				Part part = request.getPart("fotoproduto"); // pega a foto da tela
				
				if(part.getSize() > 0) {
					byte[] foto = IOUtils.toByteArray(part.getInputStream());  // convert img para byte
					String imagembase64 = "data:image/"+part.getContentType().split("\\/")[1] +";base64,"+ new Base64().encodeBase64String(foto);
					modelProduto.setFotoproduto(imagembase64);
					modelProduto.setExtensaofotoproduto(part.getContentType().split("\\/")[1]);	
				}
				
				
			} 
			
					
			 //if(daoProdutoRepository.existeProduto(modelProduto.getNomeproduto()) && modelProduto.getIdproduto() != null) {
				//	msg = "Já existe um produto cadastrado com este nome, por favor, informe outro nome.";
					
			//	} else {
					if(modelProduto.isNovo()) {
						msg = "Produto gravado com sucesso";
					} else {
						msg = "Produto atualizado com sucesso";
					}
				 modelProduto =	daoProdutoRepository.gravarProduto(modelProduto);
					//daoProdutoRepository.gravarProduto(modelProduto);
				//}	
			
			
			
			
			
			//daoProdutoRepository.gravarProduto(modelProduto);
			//request.setAttribute("msg", "Salvo com Sucesso");
	
			
			//List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(Long.parseLong(usuario_pai_id));
			 List<ModelProduto> modelProdutos = daoProdutoRepository.listProduto(idUser);
			
			//as 2 linhas abaixo são necessárias para que o formulário, preencha novamente com o usuário
			// e consiga assim ser gravado vários produtos com o mesmo usuário
			//ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(Long.parseLong(usuario_pai_id));
			 ModelLogin modelLogin = daoUsuarioRepository.consultarUsuarioID(idUser);
			request.setAttribute("msg", msg);
			request.setAttribute("modelLogin", modelLogin);
			request.setAttribute("modelProduto", modelProduto);
			request.setAttribute("modelProdutos", modelProdutos);
			request.getRequestDispatcher("principal/formProduto.jsp").forward(request, response);
						
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	
	}

}
