package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnection;
import model.ModelProduto;


public class DAOProdutoRepositoryback {
	
	private Connection connection;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
	
	public DAOProdutoRepositoryback() {
		connection = SingleConnection.getConnection();
	}
	
	public void gravarProduto (ModelProduto modelProduto) throws Exception {
		
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
	}
	
	
	public List<ModelProduto> listproduto(Long idUserPai) throws Exception {
		
		List<ModelProduto> retorno = new ArrayList<ModelProduto>();
		
		String sql = "select * from produto where usuario_pai_id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, idUserPai);;
		
		ResultSet rs = preparedStatement.executeQuery();
		
		while(rs.next()) {
			
			ModelProduto modelProduto = new ModelProduto();
			
			modelProduto.setIdproduto(rs.getLong("idproduto"));
			modelProduto.setNomeproduto(rs.getString("nomeproduto"));
			modelProduto.setValor(rs.getDouble("valor"));
			modelProduto.setDataProduto(rs.getDate("dataproduto"));	
			modelProduto.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_cad_id")));
			modelProduto.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario_pai_id")));
			
			retorno.add(modelProduto);
		}
		
		return retorno;
		
	}
	
	
	public void deleteProduto(Long id) throws Exception {
		
		String sql = "delete from produto where id = ?";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, id);
		
		preparedStatement.executeUpdate();
		
		connection.commit();
	}
	/*
public List<ModelProduto> listfone(Long idUserPai) throws Exception {
		
		List<ModelProduto> retorno = new ArrayList<ModelProduto>();
		
		String sql = "select * from produto where usuario1_pai_id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		
		preparedStatement.setLong(1, idUserPai);;
		
		ResultSet rs = preparedStatement.executeQuery();
		
		while(rs.next()) {
			
			ModelProduto modelProduto = new ModelProduto();
			
			modelProduto.setId(rs.getLong("id"));
			//modelTelefone.setNumero(rs.getString("numero"));
		//	modelTelefone.setUsuario_cad_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario1_cad_id")));
		//	modelTelefone.setUsuario_pai_id(daoUsuarioRepository.consultarUsuarioID(rs.getLong("usuario1_pai_id")));
	
			retorno.add(modelTelefone);
		}
		
		return retorno;
		
	}
*/
}
