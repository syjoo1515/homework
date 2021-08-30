package homework;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import sist.com.util.ServiceUtil;
import sist.com.vo.DbStudentVO;
import sist.com.vo.StudentVO;

public class StudentDao {
	
	static StudentDao dao;
	//싱글톤
	public static StudentDao getStudentDao() {
		if(dao==null) {
			dao=new StudentDao();
		}
		return dao;
	}
	 

	// Insert
	public static void insertStudent(DbStudentVO vo) {
		Connection con = ServiceUtil.getConnection();
		String sql = "INSERT INTO DBSTUDENT(STUDNO,NAME,GRADE,HEIGHT) VALUES(?,?,?,?) ";
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false); // true하면 rollback불가능
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStudno());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getGrade());
			pstmt.setDouble(4, vo.getHeight());
			int rs = pstmt.executeUpdate(); // 데이터베이스에서 데이터를 추가(Insert), 삭제(Delete), 수정(Update)하는 SQL 문을 실행
			con.commit();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				con.rollback();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
	}

	// SelectAll
	public List<DbStudentVO> selectDbStudent() {
		Connection con = ServiceUtil.getConnection();
		PreparedStatement pstmt = null;// 운반객체
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT STUDNO, NAME, GRADE, HEIGHT FROM DBSTUDENT");

		ArrayList<DbStudentVO> list = new ArrayList<DbStudentVO>();
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sb.toString()); // prepareStatement: SQL문 실행시키는 기능을 가진 객체. 객체 생성시에 지정된 sql명령어만을 실행할수 있다.
			rs = pstmt.executeQuery(); // executeQuery: 데이터베이스에서 데이터를 가져와서 결과 집합을 반환
			while (rs.next()) {
				DbStudentVO vo = new DbStudentVO();
				vo.setStudno(rs.getString(1)); // 오라클은 인덱스가 1부터 시작해서
				vo.setName(rs.getString(2));
				vo.setGrade(rs.getString(3));
				vo.setHeight(rs.getDouble(4));
				list.add(vo);
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
		return list;
	}

	// Delete할 데이터 선택
	public List<String> selectDeleteDbStudno(DbStudentVO vo) {
		Connection con = ServiceUtil.getConnection();
		PreparedStatement pstmt = null;// 운반객체
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT STUDNO, NAME, GRADE, HEIGHT FROM DBSTUDENT");
		ArrayList<String> studnolist = new ArrayList<String>();
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sb.toString()); // prepareStatement: SQL문 실행시키는 기능을 가진 객체. 객체 생성시에 지정된 sql명령어만을
															// 실행할수 있다.
			rs = pstmt.executeQuery(); // executeQuery: 데이터베이스에서 데이터를 가져와서 결과 집합을 반환
			while (rs.next()) {
				vo.setStudno(rs.getString(1)); // 오라클은 인덱스가 1부터 시작해서
				vo.setName(rs.getString(2));
				vo.setGrade(rs.getString(3));
				vo.setHeight(rs.getDouble(4));
				studnolist.add(rs.getString(1));
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
		return studnolist;
	}

	// Delete
	public void deleteStudent(DbStudentVO vo, String i) {
		Connection con = ServiceUtil.getConnection();
		String sb = "DELETE FROM DBSTUDENT WHERE STUDNO=" + i;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			pstmt.executeUpdate();
			con.commit();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				con.rollback();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
	}

	// 학번 있는지 없는지 체크
	public boolean studnoCheck(String studno) {
		Connection con = ServiceUtil.getConnection();
		String sql = "SELECT STUDNO FROM DBSTUDENT WHERE STUDNO=?";
		PreparedStatement pstmt = null;// 운반객체
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql); // 운반객체에 쿼리문 넣어서 반환
			pstmt.setString(1, studno); // 1:첫번째 물음표
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
		return false;
	}
 
	//update
	public void updateStudent(DbStudentVO vo) {
		Connection con = ServiceUtil.getConnection();
		String sql = "UPDATE DBSTUDENT SET NAME=?,GRADE=?,HEIGHT=? WHERE STUDNO=?";
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getGrade());
			pstmt.setDouble(3, vo.getHeight());
			pstmt.setString(4, vo.getStudno());
			if (pstmt.executeUpdate() > 0) {
				System.out.println("UpdateSuccess!");
			}
			pstmt.executeUpdate();
			con.commit();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				con.rollback();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
	}

	//info
	public DbStudentVO infoStudent(String studno) {
		Connection con = ServiceUtil.getConnection();
		String sql = "select studno, name, grade, height from dbstudent where studno=?";
		PreparedStatement pstmt = null;// 운반객체
		ResultSet rs = null;
		DbStudentVO vo = new DbStudentVO();
		try {
			pstmt = con.prepareStatement(sql); // prepareStatement: SQL문 실행시키는 기능을 가진 객체. 객체 생성시에 지정된 sql명령어만을 실행할수 있다.
			pstmt.setString(1, studno);
			rs = pstmt.executeQuery(); // executeQuery: 데이터베이스에서 데이터를 가져와서 결과 집합을 반환
			while (rs.next()) {
			vo.setStudno(rs.getString(1));
			vo.setName(rs.getString(2));
			vo.setGrade(rs.getString(3));
			vo.setHeight(rs.getDouble(4));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				con.close();
			}catch(Exception e2){
				
			}
		}
		return vo;
	}

//   public static List<StudentVO> selectStudent() {
//      PreparedStatement pstmt=null;//운반객체 
//      //String sql="SELECT STUDNO, NAME,WEIGHT, HEIGHT FROM STUDENT"; //;는 파싱할 수 없어서 제거해야한다
//      StringBuffer sb=new StringBuffer();
//      sb.append("SELECT STUDNO, NAME,WEIGHT, HEIGHT FROM STUDENT").append("WHERE GRADE=2");
//      
//      ArrayList<StudentVO>list=new ArrayList<StudentVO>();
//      ResultSet rs=null;
//      try {
//         pstmt=con.prepareStatement(sb.toString());
//         rs=pstmt.executeQuery();
//         while(rs.next()) {
//            StudentVO vo=new StudentVO();
//            vo.setStudno(rs.getString(1)); //오라클은 인덱스가 1부터 시작해서
//            vo.setName(rs.getString(2));
//            vo.setWeight(rs.getDouble(3));
//            vo.setWeight(rs.getDouble(4));
//            list.add(vo);
//         }
//         
//      } catch (Exception e) {
//         // TODO: handle exception
//         e.printStackTrace();
//      }
//      return list;
//      
//   }

}
