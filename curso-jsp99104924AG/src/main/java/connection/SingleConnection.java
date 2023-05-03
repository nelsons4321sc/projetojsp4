package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnection {
	
	//private static String banco= "jdbc:postgresql://localhost:5432/projetojavawebne_projetojspeservlet2?autoReconnect=true";
	//private static String banco= "jdbc:postgresql://localhost:5433/curso-jsp2?autoReconnect=true";
	private static String banco= "jdbc:postgresql://localhost:5433/curso-jsp3?autoReconnect=true";
	//private static String banco= "jdbc:postgresql://localhost:5433/projeto-vendasJSP2?autoReconnect=true";
	private static String senha = "admin";
	private static String user = "postgres";
	//private static String senha = "Mtsa972106";/*senha da sua hospedagem*/
	//private static String user = "projetojavawebne";
	private static Connection connection = null;
	//projetojavawebne_projetojspeservlet2
	static {
		conectar();
	}
	
	public SingleConnection() {
		conectar();
	}
	
	private static void conectar() {
		try {
			
			if(connection == null) {
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(banco, user, senha);
				connection.setAutoCommit(false);
				System.out.println("Conectou com sucesso");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		return connection;
	}

}
