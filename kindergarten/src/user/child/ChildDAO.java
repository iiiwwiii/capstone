package user.child;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class ChildDAO {
	
private static ChildDAO instance = new ChildDAO();
	
	public static ChildDAO getInstance() {
        return instance;
    }
	
	private ChildDAO() {}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/aban");
        return ds.getConnection();
	}

	
	/**parents signup - child check*/
	public int childCheck(String child_name, String child_class) throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 1; 
		try{
			conn = getConnection();		            
			pstmt = conn.prepareStatement("select child_name from child where child_name = ? and child_class = ?");	
			pstmt.setString(1, child_name);	
			pstmt.setString(2, child_class);		
			rs = pstmt.executeQuery();		
			if(rs.next()) {
				result =  0; //결과가 나옴 -> 인증 성공
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
        	if (rs != null) 
        		try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return result;
	}
	
	/**teacher - child insert (원아등록) */
    public void childinsert(ChildVO vo)  //나중에 반 넘길때 로그인 한 선생 반 잡아서 넘기기 -> 일단 A반 기준  + void말고 int로 바꿔서 체크하기 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();			 //1. pk인 child_num이랑 parents_id 제외하고 insert함 -> 학부모 정보랑 연결된거 없어서 나중에 에러생김 
            								//2. parents_id not null이라 '미인증' 넣어줌. 나중에 학부모가 회원가입 + 승인 시 회원id 들어감. -> test완료 
            pstmt = conn.prepareStatement(	//미인증 이어도 원아 리스트 뿌리는데 문제 없음 (join 안하고 원아 정보만 뿌려서) 
            	"insert into child(parents_id, child_class, child_name, child_sex, child_birth, child_post, child_addr, child_pic, child_memo, child_date) "
            	+ "values ('미인증','A',?,?,?,?,?,?,?,?)");
            pstmt.setString(1, vo.getChild_name());
            pstmt.setString(2, vo.getChild_sex());
            pstmt.setDate(3, vo.getChild_birth());
            pstmt.setString(4, vo.getChild_post());
            pstmt.setString(5, vo.getChild_addr());
            pstmt.setString(6, vo.getChild_pic());
            pstmt.setString(7, vo.getChild_memo());
			pstmt.setTimestamp(8, vo.getChild_date());
			
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
}
