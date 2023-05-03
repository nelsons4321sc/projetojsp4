package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import model.ModelLogin;
import model.ModelProduto;

public class DAOProdutoRepository {
	
	private Connection connection;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	public DAOProdutoRepository() {

		connection = SingleConnection.getConnection();
	
	}
	
	
//public void gravarProduto(ModelProduto modelProduto) throws Exception {
	
	public ModelProduto gravarProduto(ModelProduto modelProduto) throws Exception  {	
				
		
	if(modelProduto.isNovo()) {
		String sql ="insert into produto2(nomeproduto, valor,usuario_pai_id,usuario_cad_id) values(?,?,?,?)";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setString(1, modelProduto.getNomeproduto());
		preparedStatement.setDouble(2, modelProduto.getValor());
		preparedStatement.setLong(3, modelProduto.getUsuario_pai_id().getId());
		preparedStatement.setLong(4, modelProduto.getUsuario_cad_id().getId());
		
		preparedStatement.execute();
		
		connection.commit();
		
		
		if(modelProduto.getFotoproduto() != null && !modelProduto.getFotoproduto().isEmpty()) {
			
			sql = "UPDATE produto2 set fotoproduto=?, extensaofotoproduto=? where nomeproduto = ?";
			
			preparedStatement = connection.prepareStatement(sql);
			
			preparedStatement.setString(1, modelProduto.getFotoproduto());
			preparedStatement.setString(2, modelProduto.getExtensaofotoproduto());
			preparedStatement.setString(3, modelProduto.getNomeproduto());
						
			preparedStatement.execute();
			
			connection.commit();
			
		}
		
	} else {
		
		String sql = "UPDATE produto2 SET nomeproduto=?, valor=? WHERE idproduto = "+modelProduto.getIdproduto()+";";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setString(1, modelProduto.getNomeproduto());
		preparedStatement.setDouble(2, modelProduto.getValor());
		//preparedStatement.setLong(3, modelProduto.getIdproduto());
		
		preparedStatement.executeUpdate();
		connection.commit();
		
		if(modelProduto.getFotoproduto() != null && !modelProduto.getFotoproduto().isEmpty()) {
			
			sql = "UPDATE produto2 set fotoproduto=?, extensaofotoproduto=? where idproduto = ?";
			
			preparedStatement = connection.prepareStatement(sql);
			
			preparedStatement.setString(1, modelProduto.getFotoproduto());
			preparedStatement.setString(2, modelProduto.getExtensaofotoproduto());
			preparedStatement.setLong(3, modelProduto.getIdproduto());
						
			preparedStatement.execute();
			
			connection.commit();
			
		}
	
	} 
	return this.consultarNomeProduto(modelProduto.getNomeproduto());
	//return modelProduto;
	}

	


	
	

	public List<ModelProduto> listProduto(Long idUserPai) throws Exception {
		//public List<ModelProduto2> listProduto(Long idUserPai, Long id) throws Exception {	
		
		List<ModelProduto> retorno = new ArrayList<ModelProduto>();
		
		//String sql = "select * from produto where nomeproduto = ? and usuario_pai_id = ?";
		String sql = "select * from produto2 where usuario_pai_id =  "+idUserPai+"limit 5";
		//String sql = "select * from produto2 where usuario_pai_id = ? and idproduto = ?";
		//String sql = "select * from produto where id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		//preparedStatement.setLong(1, idUserPai);
		
		ResultSet rs = preparedStatement.executeQuery();
		
		while(rs.next()) {
			
						
			ModelProduto modelProduto = new ModelProduto();
			
			modelProduto.setIdproduto(rs.getLong("idproduto"));
			modelProduto.setNomeproduto(rs.getString("nomeproduto"));
			modelProduto.setFotoproduto(rs.getString("fotoproduto"));
			modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
			modelProduto.setValor(rs.getDouble("valor"));
			modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
			modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
	
			retorno.add(modelProduto);
		}
		
		return retorno;
		
	}
		
		
		public List<ModelProduto> listProduto2(Long id) throws Exception {	
			
			List<ModelProduto> retorno = new ArrayList<ModelProduto>();
			
			//String sql = "select * from produto where nomeproduto = ? and usuario_pai_id = ?";
			//String sql = "select * from produto2 where usuario_pai_id = ? ";
			//String sql = "select * from produto where usuario_pai_id = ? and id = ?";
			String sql = "select * from produto2 where idproduto = ? limit 5 ";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setLong(1, id);
			
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next()) {
				
				
				
				ModelProduto modelProduto = new ModelProduto();
				
				modelProduto.setIdproduto(rs.getLong("idproduto"));
				modelProduto.setNomeproduto(rs.getString("nomeproduto"));
				modelProduto.setFotoproduto(rs.getString("fotoproduto"));
				modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
				modelProduto.setValor(rs.getDouble("valor"));
				modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
				modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
		
				retorno.add(modelProduto);
			}
			
			return retorno;
			
		}
	
		public List<ModelProduto> listTodosProduto(Long idUserPai) throws Exception {
				
				List<ModelProduto> retorno = new ArrayList<ModelProduto>();
				
				//String sql = "select * from produto where nomeproduto = ? and usuario_pai_id = ?";
				String sql = "select * from produto2 as prod inner join model_login as login on prod.usuario_pai_id = login.id limit 5 ";
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				//preparedStatement.setLong(1, idUserPai);
				
				
				ResultSet rs = preparedStatement.executeQuery();
				
				while(rs.next()) {
					
					
					
					ModelProduto modelProduto = new ModelProduto();
					
					//String valor = Double.parseDouble(modelProduto.getValor()); 
					
					modelProduto.setIdproduto(rs.getLong("idproduto"));
					modelProduto.setNomeproduto(rs.getString("nomeproduto"));
					modelProduto.setFotoproduto(rs.getString("fotoproduto"));
					modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
					modelProduto.setValor(rs.getDouble("valor"));
					modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
					modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
			
					retorno.add(modelProduto);
				}
				
				return retorno;
				
			}
	
	
	 
	
	
	//public List<ModelProduto> listProduto(Long idUserPai) throws Exception {
		//public ModelProduto consultarProdutoID(String id,Long usuario_pai_id) throws Exception { //NÃO FUNCIONA, 
               //POIS NÃO RETORNA OS VALORES DO PRODUTO, SOMENTE OS VALORES DO USUÁRIO QUE CADASTROU
		public ModelProduto consultarProdutoID(String id) throws Exception {	
		
		ModelProduto  modelProduto = new ModelProduto();
		//ERRO QUERER USAR usuario_pai_id JUNTO  NO SELECT, TRAZIA SOMENTE VALORES DO USUÁRIO
		// select * from produto where id = 3 and usuario_pai_id = 16
		//ERROS ABAIXO OCORRIAM, POIS NO SELECT NÃO ERA RECONHECIDO A CHAVE ESTRANGEIRA, NA BUSCA DO ID DO PRODUTO
		//String sql = "select * from produto where id ="+id+" and where usuario_pai_id ="+ usuario_pai_id; ERRO  The column index is out of range: {0}, number of columns: {1}
		//String sql = "select * from produto where id ="+id+" and where usuario_pai_id = ?"; ERRO  The column index is out of range: {0}, number of columns: {1}
		//String sql = "select * from produto where id ="+id; ERRO  The column index is out of range: {0}, number of columns: {1}
		String sql = "select * from produto2 where idproduto = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setLong(1,Long.parseLong(id));
		
		
		
		ResultSet rs = preparedStatement.executeQuery();
		
		while(rs.next()) {
			
			modelProduto.setIdproduto(rs.getLong("idproduto"));
			modelProduto.setNomeproduto(rs.getString("nomeproduto"));
			modelProduto.setFotoproduto(rs.getString("fotoproduto"));
			modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
			modelProduto.setValor(rs.getDouble("valor"));
			modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
			modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
	
		
		}
		
		return modelProduto;
		
	}
		
		
		
		//public ModelProduto consultarNomeProduto(String nomeproduto) throws Exception {
		
		public ModelProduto consultarNomeProduto(String nomeproduto) throws Exception {
			
			ModelProduto  modelProduto = new ModelProduto();
			//String sql = "select * from model_login where upper(login) = upper('"+login+"') and useradmin is false and usuario_id = "+userLogado;
			String sql = "select * from produto2 where nomeproduto = ?";
			
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, nomeproduto);
						
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next()) {
								
				modelProduto.setIdproduto(rs.getLong("idproduto"));
				modelProduto.setNomeproduto(rs.getString("nomeproduto"));
				modelProduto.setFotoproduto(rs.getString("fotoproduto"));
				modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
				modelProduto.setValor(rs.getDouble("valor"));
				modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
				modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
		
			
			}
			
			return modelProduto;
			
		}
	
	
	
	
	
	public void deleteProduto(Long id) throws Exception {
		
		String sql = "delete from produto2 where idproduto = ?";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, id);
		
		preparedStatement.executeUpdate();
		
		connection.commit();
	}
	
	
public boolean existeProduto(String nomeproduto) throws Exception {
		
		String sql ="select count(1) > 0 as existe from produto2 where nomeproduto = ?";
		
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, nomeproduto);
		
		ResultSet resultSet = preparedStatement.executeQuery();
		
		resultSet.next();
		
		return resultSet.getBoolean("existe");
		
	}


public int totalPagina(Long userLogado) throws Exception {
	
	String sql ="select count(1) as total  from produto2 where usuario_pai_id = "+userLogado +" limit 15";
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

public List<ModelProduto> consultaProdutoListPagina(String nome, Long userLogado) throws Exception {
	
	List<ModelProduto> retorno = new ArrayList<ModelProduto>();
	
	String sql ="select * from produto2 where upper(nomeproduto) like upper(?) and usuario_pai_id = ? limit 5"; 
	
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, "%" + nome + "%");
	statement.setLong(2,  userLogado);
			
	ResultSet rs = statement.executeQuery();
	
	while(rs.next()) {
ModelProduto modelProduto = new ModelProduto();
		
		//String valor = Double.parseDouble(modelProduto.getValor()); 
		
		modelProduto.setIdproduto(rs.getLong("idproduto"));
		modelProduto.setNomeproduto(rs.getString("nomeproduto"));
		modelProduto.setFotoproduto(rs.getString("fotoproduto"));
		modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
		modelProduto.setValor(rs.getDouble("valor"));
		modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
		modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));

		retorno.add(modelProduto);
	}
	
	return retorno;
	
}


/*	
public List<ModelProduto> consultaProdutoListPaginada(Long userLogado, Integer offset ) throws Exception {
	
	List<ModelProduto> retorno = new ArrayList<ModelProduto>();
	
	String sql ="select * from produto2 where usuario_pai_id = "+userLogado +" order by nome offset "+offset+" limit 15"; 
	
	PreparedStatement statement = connection.prepareStatement(sql);
					
	ResultSet rs = statement.executeQuery();
	
	while(rs.next()) {
		
		
		
		ModelProduto modelProduto = new ModelProduto();
		
		//String valor = Double.parseDouble(modelProduto.getValor()); 
		
		modelProduto.setIdproduto(rs.getLong("idproduto"));
		modelProduto.setNomeproduto(rs.getString("nomeproduto"));
		modelProduto.setFotoproduto(rs.getString("fotoproduto"));
		modelProduto.setExtensaofotoproduto(rs.getString("extensaofotoproduto"));
		modelProduto.setValor(rs.getDouble("valor"));
		modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
		modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));

		retorno.add(modelProduto);
	}
	
	return retorno;
	
}
	*/

//public List<ModelProduto> consultaProdutoList(String nome, Long userLogado) throws Exception {
public List<ModelProduto> consultaProdutoList(String nome) throws Exception {
	
	List<ModelProduto> retorno = new ArrayList<ModelProduto>();
	
	//String sql ="select * from produto2 where nomeproduto = "+nome +" limit 15"; 
	//String sql ="select * from produto2 where upper(nomeproduto) like upper(?) and usuario_pai_id = ? limit 5";
	String sql = "select * from produto2 where upper(nomeproduto) like upper(?) limit 5";
	PreparedStatement statement = connection.prepareStatement(sql);
	statement.setString(1, "%" + nome + "%");
	//statement.setLong(2,  userLogado);
	
	ResultSet rs = statement.executeQuery();
	
	while(rs.next()) {
		ModelProduto modelProduto = new ModelProduto();
		
		//String valor = Double.parseDouble(modelProduto.getValor()); 
		
		modelProduto.setIdproduto(rs.getLong("idproduto"));
		modelProduto.setNomeproduto(rs.getString("nomeproduto"));
		modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
		modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));

		retorno.add(modelProduto);
	}
	
	return retorno;
	
}
}
