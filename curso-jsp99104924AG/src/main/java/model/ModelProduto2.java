package model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

public class ModelProduto2 implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long idproduto;
	private String nomeproduto;
	//private Date dataproduto;
	private Double valor;
	//private String categoria;
	private String fotoproduto;
	private String extensaofotoproduto;
	
	
	private ModelLogin usuario_pai_id;
	
	private ModelLogin usuario_cad_id;
	
	public Long getId() {
		return idproduto;
	}
	
	public void setId(Long id) {
		this.idproduto = id;
	}
	 
	public String getNomeproduto() {
		return nomeproduto;
	}
	
	public void setNomeproduto(String nomeproduto) {
		this.nomeproduto = nomeproduto;
	}
	

	
	public Double getValor() {
		return valor;
	}
	public void setValor(Double valor) {
		this.valor = valor;
	}
	
	public String getFotoproduto() {
		return fotoproduto;
	}

	public void setFotoproduto(String fotoproduto) {
		this.fotoproduto = fotoproduto;
	}

	public String getExtensaofotoproduto() {
		return extensaofotoproduto;
	}

	public void setExtensaofotoproduto(String extensaofotoproduto) {
		this.extensaofotoproduto = extensaofotoproduto;
	}

	public ModelLogin getUsuario_pai_id() {
		return usuario_pai_id;
	}

	public void setUsuario_pai_id(ModelLogin usuario_pai_id) {
		this.usuario_pai_id = usuario_pai_id;
	}

	public ModelLogin getUsuario_cad_id() {
		return usuario_cad_id;
	}

	public void setUsuario_cad_id(ModelLogin usuario_cad_id) {
		this.usuario_cad_id = usuario_cad_id;
	}

	public boolean isNovo() {
		
		if(this.usuario_pai_id != null && this.nomeproduto.isEmpty()) {
			return true; //inserir
		}else if(this.usuario_pai_id != null && !this.nomeproduto.isEmpty()) {
			return false; //atualizar
		}
		
		return usuario_pai_id != null;
	}
	

	@Override
	public int hashCode() {
		return Objects.hash(idproduto);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ModelProduto2 other = (ModelProduto2) obj;
		return Objects.equals(idproduto, other.idproduto);
	}
	
	

	
	
	

}
