package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import beandto.BeanDtoGraficoSalarioUser;
import connection.SingleConnection;
import model.ModelLogin;
import model.ModelProduto;
import model.ModelTelefone;

public class DAOUsuarioRepository {
	
	private Connection connection;
	
	
	public DAOUsuarioRepository() {
		
		connection = SingleConnection.getConnection();
		
	}
	
	public BeanDtoGraficoSalarioUser montarGraficoMediaSalario(Long userLogado, String dataInicial, String dataFinal) throws Exception {

		String sql = "select avg(rendamensal) as media_salarial, nome from model_login where usuario_id  = ? and datanascimento >= ? and datanascimento <= ? group by nome";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, userLogado);
		preparedStatement.setDate(2, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataInicial))));
		preparedStatement.setDate(3, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataFinal))));
		
		ResultSet resultSet = preparedStatement.executeQuery();
		
		List<String> perfils = new ArrayList<String>();
		List<Double> salarios = new ArrayList<Double>();
		
		BeanDtoGraficoSalarioUser beanDtoGraficoSalarioUser = new BeanDtoGraficoSalarioUser();
		
		while (resultSet.next()) {
			Double media_salarial = resultSet.getDouble("media_salarial");
			String nome = resultSet.getString("nome");
			
			perfils.add(nome);
			salarios.add(media_salarial);
		}
		
		beanDtoGraficoSalarioUser.setPerfils(perfils);
		beanDtoGraficoSalarioUser.setSalarios(salarios);
		
		return beanDtoGraficoSalarioUser;
	}
	
	
	public BeanDtoGraficoSalarioUser montarGraficoMediaSalario(Long userLogado) throws Exception {
		
		String sql = "select avg(rendamensal) as media_salarial, nome from model_login where usuario_id  = ? group by nome";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, userLogado);
		
		ResultSet resultSet = preparedStatement.executeQuery();
		
		List<String> perfils = new ArrayList<String>();
		List<Double> salarios = new ArrayList<Double>();
		
		BeanDtoGraficoSalarioUser beanDtoGraficoSalarioUser = new BeanDtoGraficoSalarioUser();
		
		while (resultSet.next()) {
			Double media_salarial = resultSet.getDouble("media_salarial");
			String nome = resultSet.getString("nome");
			
			perfils.add(nome);
			salarios.add(media_salarial);
		}
		
		beanDtoGraficoSalarioUser.setPerfils(perfils);
		beanDtoGraficoSalarioUser.setSalarios(salarios);
		
		return beanDtoGraficoSalarioUser;
	}
	
	public ModelLogin gravarUsuario(ModelLogin objeto, Long userLogado) throws Exception  {
		//userLogado = 1L;
		if(objeto.isNovo()) {
			
		String sql = "INSERT INTO model_login(login, senha, nome, email, usuario_id, cep, logradouro, bairro, localidade, uf, numero, datanascimento)  VALUES (?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?);";	
		PreparedStatement prepareSql = connection.prepareStatement(sql);
		
		prepareSql.setString(1, objeto.getLogin());
		prepareSql.setString(2, objeto.getSenha());
		prepareSql.setString(3, objeto.getNome());
		prepareSql.setString(4, objeto.getEmail());
		prepareSql.setLong(5, userLogado);
				
		prepareSql.setString(6, objeto.getCep());
		prepareSql.setString(7, objeto.getLogradouro());
		prepareSql.setString(8, objeto.getBairro());
		prepareSql.setString(9, objeto.getLocalidade());
		prepareSql.setString(10, objeto.getUf());
		prepareSql.setString(11, objeto.getNumero());
		prepareSql.setDate(12, objeto.getDataNascimento());
		

		
		prepareSql.execute();
		
		connection.commit();
		
					if(objeto.getFotouser() != null && !objeto.getFotouser().isEmpty()) {
						
						sql = "UPDATE  model_login set fotouser=?, extensaofotouser=? where login=?";
						
						prepareSql = connection.prepareStatement(sql);
						
						prepareSql.setString(1, objeto.getFotouser());
						prepareSql.setString(2, objeto.getExtensaofotouser());
						prepareSql.setString(3, objeto.getLogin());
						
						prepareSql.execute();
						
						connection.commit();
						
					}
		
		
		} else {
			String sql = "UPDATE model_login SET login=?, senha=?, nome=?, email=?, cep=?, logradouro=?, bairro =?, localidade=?, uf=?, numero =?, datanascimento=? WHERE id = "+objeto.getId()+";";
			
			PreparedStatement prepareSql = connection.prepareStatement(sql);
			
			prepareSql.setString(1, objeto.getLogin());
			prepareSql.setString(2, objeto.getSenha());
			prepareSql.setString(3, objeto.getNome());
			prepareSql.setString(4, objeto.getEmail());
						
			prepareSql.setString(5, objeto.getCep());
			prepareSql.setString(6, objeto.getLogradouro());
			prepareSql.setString(7, objeto.getBairro());
			prepareSql.setString(8, objeto.getLocalidade());
			prepareSql.setString(9, objeto.getUf());
			prepareSql.setString(10, objeto.getNumero());
			prepareSql.setDate(11, objeto.getDataNascimento());
			
			
			prepareSql.executeUpdate();
			connection.commit();
			
			if(objeto.getFotouser() != null && !objeto.getFotouser().isEmpty()) {
				
				sql = "UPDATE  model_login set fotouser=?, extensaofotouser=? where id=?";
				
				prepareSql = connection.prepareStatement(sql);
				
				prepareSql.setString(1, objeto.getFotouser());
				prepareSql.setString(2, objeto.getExtensaofotouser());
				prepareSql.setLong(3, objeto.getId());
				
				prepareSql.execute();
				
				connection.commit();
				
			}

	
     		}
		
		return this.consultarUsuario(objeto.getLogin(), userLogado);
	}
	
	public List<ModelLogin> consultaUsuarioListRel(Long userLogado) throws Exception {
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql = "select * from model_login where useradmin is false and usuario_id = " + userLogado;
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) { /*percorrer as linhas de resultado do SQL*/
			
			ModelLogin modelLogin = new ModelLogin();
			
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setDataNascimento(resultado.getDate("datanascimento"));
			modelLogin.setTelefones(this.listFone(modelLogin.getId()));
			modelLogin.setProdutos(this.listProduto(modelLogin.getId()));
			
			retorno.add(modelLogin);
		}
		
		
		return retorno;
	}	
	
	
	
public List<ModelLogin> consultaUsuarioList(Long userLogado) throws Exception {
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql ="select * from model_login where useradmin is false and usuario_id = "+userLogado +" limit 5"; 
		
		PreparedStatement statement = connection.prepareStatement(sql);
						
		ResultSet resultado = statement.executeQuery();
		
		while(resultado.next()) {
			ModelLogin modelLogin = new ModelLogin();
			
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
			
			retorno.add(modelLogin);
		}
		
		return retorno;
		
	}




public int totalPagina(Long userLogado) throws Exception {
	
	String sql ="select count(1) as total  from model_login where usuario_id = "+userLogado +" limit 5";
	PreparedStatement statement = connection.prepareStatement(sql);
	
	ResultSet resultado = statement.executeQuery();
	
	resultado.next();
	
	Double cadastros = resultado.getDouble("total");
	
	Double porpagina = 15.0;
	
	Double pagina  = cadastros / porpagina;
	
	Double resto = pagina % 2;
	
		
	if(resto > 0) {
		pagina ++;
	}
	
	return pagina.intValue();
	
	//return porpagina.intValue();
}





public List<ModelLogin> consultaUsuarioListRel(Long userLogado, String dataInicial, String dataFinal) throws Exception {
	
	List<ModelLogin> retorno = new ArrayList<ModelLogin>();
	
	String sql = "select * from model_login where useradmin is false and usuario_id = " + userLogado + " and datanascimento >= ? and datanascimento <= ?";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setDate(1, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataInicial))));
	statement.setDate(2, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataFinal))));
	
	ResultSet resultado = statement.executeQuery();
	
	while (resultado.next()) { /*percorrer as linhas de resultado do SQL*/
		
		ModelLogin modelLogin = new ModelLogin();
		
		modelLogin.setEmail(resultado.getString("email"));
		modelLogin.setId(resultado.getLong("id"));
		modelLogin.setLogin(resultado.getString("login"));
		modelLogin.setNome(resultado.getString("nome"));
		modelLogin.setDataNascimento(resultado.getDate("datanascimento"));
				
		modelLogin.setTelefones(this.listFone(modelLogin.getId()));
		modelLogin.setProdutos(this.listProduto(modelLogin.getId()));
		
		retorno.add(modelLogin);
	}
	
	
	return retorno;
}


public List<ModelLogin> consultaUsuarioListPaginada(Long userLogado, Integer offset) throws Exception {
	
	List<ModelLogin> retorno = new ArrayList<ModelLogin>();
	
	String sql ="select * from model_login where useradmin is false and usuario_id = "+userLogado +" order by nome offset "+offset+" limit 5"; 
	
	PreparedStatement statement = connection.prepareStatement(sql);
					
	ResultSet resultado = statement.executeQuery();
	
	while(resultado.next()) {
		ModelLogin modelLogin = new ModelLogin();
		
		modelLogin.setEmail(resultado.getString("email"));
		modelLogin.setId(resultado.getLong("id"));
		modelLogin.setLogin(resultado.getString("login"));
		modelLogin.setNome(resultado.getString("nome"));
		modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
		
		retorno.add(modelLogin);
	}
	
	return retorno;
	
}

public int consultaUsuarioListTotalPaginaPaginacao(String nome, Long userLogado) throws Exception {
	
	
	String sql = "select count(1) as total from model_login  where upper(nome) like upper(?) and useradmin is false and usuario_id = ? ";

	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, "%" + nome + "%");
	statement.setLong(2, userLogado);
	
	ResultSet resultado = statement.executeQuery();
	
	resultado.next();
	
	Double cadastros = resultado.getDouble("total");
	
	Double porpagina = 15.0;
	
	Double pagina = cadastros / porpagina;
	
	Double resto = pagina % 2;
	
	if (resto > 0) {
		pagina ++;
	}
	
	return pagina.intValue();
	
}



public List<ModelLogin> consultaUsuarioListOffSet(String nome, Long userLogado, int offset) throws Exception {
	
	List<ModelLogin> retorno = new ArrayList<ModelLogin>();
	
	String sql = "select * from model_login  where upper(nome) like upper(?) and useradmin is false and usuario_id = ? offset "+offset+" limit 5";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, "%" + nome + "%");
	statement.setLong(2, userLogado);
	
	ResultSet resultado = statement.executeQuery();
	
	while (resultado.next()) { /*percorrer as linhas de resultado do SQL*/
		
		ModelLogin modelLogin = new ModelLogin();
		
		modelLogin.setEmail(resultado.getString("email"));
		modelLogin.setId(resultado.getLong("id"));
		modelLogin.setLogin(resultado.getString("login"));
		modelLogin.setNome(resultado.getString("nome"));
	
		
		retorno.add(modelLogin);
	}
	
	
	return retorno;
}
	
	
	public List<ModelLogin> consultaUsuarioList(String nome, Long userLogado) throws Exception {
		
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql ="select * from model_login where upper(nome) like upper(?) and useradmin is false and usuario_id = ? limit 5"; 
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, "%" + nome + "%");
		statement.setLong(2,  userLogado);
				
		ResultSet resultado = statement.executeQuery();
		
		while(resultado.next()) {
			ModelLogin modelLogin = new ModelLogin();
			
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			
			
			retorno.add(modelLogin);
		}
		
		return retorno;
		
	}
	
public ModelLogin consultarUsuarioLogado(String login) throws Exception {
		
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "select * from model_login where upper(login) = upper('"+login+"') ";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		
		
		while (resultado.next()) {
			
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setUserAdmin(resultado.getBoolean("useradmin"));
			modelLogin.setFotouser(resultado.getString("fotouser"));
			
			modelLogin.setCep(resultado.getString("cep"));
			modelLogin.setLogradouro(resultado.getString("logradouro"));
			modelLogin.setBairro(resultado.getString("bairro"));
			modelLogin.setLocalidade(resultado.getString("localidade"));
			modelLogin.setUf(resultado.getString("uf"));
			modelLogin.setNumero(resultado.getString("numero"));
			modelLogin.setDataNascimento(resultado.getDate("datanascimento"));
			modelLogin.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		
		return modelLogin;
		
	}
 	
	
	
public ModelLogin consultarUsuario(String login) throws Exception {
		
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "select * from model_login where upper(login) = upper('"+login+"') and useradmin is false ";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) {
			
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setUserAdmin(resultado.getBoolean("useradmin"));
			modelLogin.setFotouser(resultado.getString("fotouser"));
			modelLogin.setCep(resultado.getString("cep"));
			modelLogin.setLogradouro(resultado.getString("logradouro"));
			modelLogin.setBairro(resultado.getString("bairro"));
			modelLogin.setLocalidade(resultado.getString("localidade"));
			modelLogin.setUf(resultado.getString("uf"));
			modelLogin.setNumero(resultado.getString("numero"));
			modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
			modelLogin.setRendamensal(resultado.getDouble("rendamensal"));
		}
		
		return modelLogin;
		
	}
	
	
	public ModelLogin consultarUsuario(String login, Long userLogado ) throws Exception {
		
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "select * from model_login where upper(login) = upper('"+login+"') and useradmin is false and usuario_id = "+userLogado;
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) {
			
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setFotouser(resultado.getString("fotouser"));
			modelLogin.setCep(resultado.getString("cep"));
			modelLogin.setLogradouro(resultado.getString("logradouro"));
			modelLogin.setBairro(resultado.getString("bairro"));
			modelLogin.setLocalidade(resultado.getString("localidade"));
			modelLogin.setUf(resultado.getString("uf"));
			modelLogin.setNumero(resultado.getString("numero"));
			modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
			modelLogin.setRendamensal(resultado.getDouble("rendamensal"));
		}
		
		return modelLogin;
		
	}
	
	
public ModelLogin consultarUsuarioID(Long id) throws Exception {
		
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "select * from model_login where id = "+id +" and useradmin is false";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		//statement.setLong(1,id);
		
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) {
			
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setFotouser(resultado.getString("fotouser"));
			modelLogin.setExtensaofotouser(resultado.getString("extensaofotouser"));
			modelLogin.setCep(resultado.getString("cep"));
			modelLogin.setLogradouro(resultado.getString("logradouro"));
			modelLogin.setBairro(resultado.getString("bairro"));
			modelLogin.setLocalidade(resultado.getString("localidade"));
			modelLogin.setUf(resultado.getString("uf"));
			modelLogin.setNumero(resultado.getString("numero"));
			modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
			modelLogin.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		
		return modelLogin;
		
	}
	
	
	
	
public ModelLogin consultarUsuarioID(String id, Long userLogado ) throws Exception {
		
		ModelLogin modelLogin = new ModelLogin();
		
		String sql = "select * from model_login where id = ? and useradmin is false and usuario_id = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong(id));
		statement.setLong(2, userLogado);
		
		ResultSet resultado = statement.executeQuery();
		
		while (resultado.next()) {
			
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setSenha(resultado.getString("senha"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setFotouser(resultado.getString("fotouser"));
			modelLogin.setExtensaofotouser(resultado.getString("extensaofotouser"));
			modelLogin.setCep(resultado.getString("cep"));
			modelLogin.setLogradouro(resultado.getString("logradouro"));
			modelLogin.setBairro(resultado.getString("bairro"));
			modelLogin.setLocalidade(resultado.getString("localidade"));
			modelLogin.setUf(resultado.getString("uf"));
			modelLogin.setNumero(resultado.getString("numero"));
			modelLogin.setDataNascimento(resultado.getDate("dataNascimento"));
			modelLogin.setRendamensal(resultado.getDouble("rendamensal"));
			
		}
		
		return modelLogin;
		
	}

	
	public boolean validarLogin(String login) throws Exception {
		
		String sql = "select count(1) > 0 as existe from model_login where upper(login) = upper('"+login+"')";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		resultado.next();
		return resultado.getBoolean("existe");
				
		
	}
	
	public boolean validarNome(String nome) throws Exception {
		
		String sql = "select count(1) > 0 as existe from model_login where upper(nome) = upper('"+nome+"')";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		resultado.next();
		return resultado.getBoolean("existe");
				
		
	}
	
	public void deleteUser(String idUser) throws Exception {
		String sql = "DELETE FROM model_login WHERE id = ? and useradmin is false;";
		
		PreparedStatement prepareSql = connection.prepareStatement(sql);
		
		prepareSql.setLong(1, Long.parseLong(idUser));  
		prepareSql.executeUpdate();
		
		connection.commit();
		
		
				
	}
	
public List<ModelTelefone> listFone(Long idUserPai) throws Exception {
		
		List<ModelTelefone> retorno = new ArrayList<ModelTelefone>();
		
		String sql = "select * from telefone where usuario_pai_id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, idUserPai);
		
		ResultSet rs = preparedStatement.executeQuery();
		
		while (rs.next()) {
			
			ModelTelefone modelTelefone = new ModelTelefone();
			
			modelTelefone.setId(rs.getLong("id"));
			modelTelefone.setNumero(rs.getString("numero"));
		//	modelTelefone.setUsuario_cad_id(this.consultaUsuarioID(rs.getLong("usuario_cad_id")));
		//	modelTelefone.setUsuario_pai_id(this.consultaUsuarioID(rs.getLong("usuario_pai_id")));
			
			retorno.add(modelTelefone);
			
		}
		
		return retorno;
	}

public List<ModelProduto> listProduto(Long idUserPai) throws Exception {
	
	List<ModelProduto> retorno = new ArrayList<ModelProduto>();
	
	String sql = "select * from produto2 where usuario_pai_id = ?";
	PreparedStatement preparedStatement = connection.prepareStatement(sql);
	
	preparedStatement.setLong(1, idUserPai);
	
	ResultSet rs = preparedStatement.executeQuery();
	
	while (rs.next()) {
		
		ModelProduto modelProduto = new ModelProduto();
		
		modelProduto.setIdproduto(rs.getLong("idproduto"));
		modelProduto.setNomeproduto(rs.getString("nomeproduto"));
	//	modelTelefone.setUsuario_cad_id(this.consultaUsuarioID(rs.getLong("usuario_cad_id")));
	//	modelTelefone.setUsuario_pai_id(this.consultaUsuarioID(rs.getLong("usuario_pai_id")));
		
		retorno.add(modelProduto);
		
	}
	
	return retorno;
}

public List<ModelProduto> listProdutoIdproduto(Long idUserPai) throws Exception {
	
	List<ModelProduto> retorno = new ArrayList<ModelProduto>();
	
	String sql = "select * from produto where id = ?";
	PreparedStatement preparedStatement = connection.prepareStatement(sql);
	
	preparedStatement.setLong(1, idUserPai);
	
	ResultSet rs = preparedStatement.executeQuery();
	
	while (rs.next()) {
		
		ModelProduto modelProduto = new ModelProduto();
		
		modelProduto.setIdproduto(rs.getLong("id"));
		modelProduto.setNomeproduto(rs.getString("nomeproduto"));
	//	modelTelefone.setUsuario_cad_id(this.consultaUsuarioID(rs.getLong("usuario_cad_id")));
	//	modelTelefone.setUsuario_pai_id(this.consultaUsuarioID(rs.getLong("usuario_pai_id")));
		
		retorno.add(modelProduto);
		
	}
	
	return retorno;
}


public boolean existefone(String fone, Long idUse) throws Exception {
	
	
	
	String sql ="select count(1) > 0 as existe from telefone1 where usuario_pai_id = ? and numero = ?";
	
	PreparedStatement preparedStatement = connection.prepareStatement(sql);
	
	preparedStatement.setLong(1, idUse);
	preparedStatement.setString(2, fone);
	
	ResultSet resultSet = preparedStatement.executeQuery();
	
	resultSet.next();
	
	return resultSet.getBoolean("existe");
	
}
	
	
	

}
