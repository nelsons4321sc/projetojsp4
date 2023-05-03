package filter;

import java.io.File;
//import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
//import java.util.Scanner;

import connection.SingleConnection;
import dao.DAOVersionadorBanco;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@WebFilter(urlPatterns = {"/principal/*"})
public class FilterAutenticacao implements Filter {
	/*
     * O falar tem que ser:
     * util para edificação
     * necessário para o momento
     * agradável - afim de trazer a pesso mais perto de Deus e mais parecida com Jesus Cristo - EF.4.29 
     */
	
	private static Connection connection;
	

    public FilterAutenticacao() {
  
    }

    /*
     * Encerra os processos quando o servidor é parado
     * mataria os processos de conexão com o banco
     */
    // Quando parar o servidor
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * Intercepta as requisições e as respostas no sistema
	 * tudo que fizer no sistema passa por aqui
	 * validação de autenticação
	 * dar commit e rollback de transações do banco
	 * validar e fazer redirecionamento das páginas
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
			
			try {
	
				// para pegar a sessão do atributo do usuário logado, descrito no ServletLogin	
			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();
			
			String usuarioLogado = (String) session.getAttribute("usuario");
			
			String urlParaAutenticar = req.getServletPath();
			
			//Validar usuario da sessao com usuario logado e diferente da url para autenticar
			if(usuarioLogado == null &&
					!urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin") ) {
				 // não está logado
				RequestDispatcher redirecionar = request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
				request.setAttribute("msg", "Por favor realize o login novamente!Para ter acesso a essa página. Obrigado");
				redirecionar.forward(request, response);
				return;
			
			} else {
				chain.doFilter(request, response);
			}
			
			connection.commit(); // se deu OK. Comitar as alteraçãoes no banco
	
			} catch (Exception e) {
				e.printStackTrace();
				try {
					connection.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}		
	}
 
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnection.getConnection();
		
		DAOVersionadorBanco daoVersionadorBanco = new DAOVersionadorBanco();
		
		String caminhoPastaSQL = fConfig.getServletContext().getRealPath("versionadorbancoSql") + File.separator;
		
		File[] fileSql = new File(caminhoPastaSQL).listFiles();
		
		try {
			
			for(File file : fileSql) {
				
				boolean arquivoRodado = daoVersionadorBanco.arquivoSqlRodado(file.getName());
				
				if(!arquivoRodado) {
					
					//lendo o conteúdo do arquiv
					//FileInputStream entradaArquivo = new FileInputStream(file);
					
					//Scanner lerArquivo = new Scanner(entradaArquivo, "UTF-8");
					
					StringBuilder sql = new StringBuilder();
					
					//while(lerArquivo.hasNext()) {
					
						//sql.append(lerArquivo.nextLine());
						//sql.append("\n");
					
					//}
					
					connection.prepareStatement(sql.toString()).execute();
					//daoVersionadorBanco.gravaArquivoSqlRodado(file.getName());
					
					connection.commit();
					//lerArquivo.close();
				}
				
			}
		
		
		} catch (Exception e) {
			
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}

}
