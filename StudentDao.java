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
	//�̱���
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
			con.setAutoCommit(false); // true�ϸ� rollback�Ұ���
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getStudno());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getGrade());
			pstmt.setDouble(4, vo.getHeight());
			int rs = pstmt.executeUpdate(); // �����ͺ��̽����� �����͸� �߰�(Insert), ����(Delete), ����(Update)�ϴ� SQL ���� ����
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
		PreparedStatement pstmt = null;// ��ݰ�ü
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT STUDNO, NAME, GRADE, HEIGHT FROM DBSTUDENT");

		ArrayList<DbStudentVO> list = new ArrayList<DbStudentVO>();
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sb.toString()); // prepareStatement: SQL�� �����Ű�� ����� ���� ��ü. ��ü �����ÿ� ������ sql��ɾ�� �����Ҽ� �ִ�.
			rs = pstmt.executeQuery(); // executeQuery: �����ͺ��̽����� �����͸� �����ͼ� ��� ������ ��ȯ
			while (rs.next()) {
				DbStudentVO vo = new DbStudentVO();
				vo.setStudno(rs.getString(1)); // ����Ŭ�� �ε����� 1���� �����ؼ�
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

	// Delete�� ������ ����
	public List<String> selectDeleteDbStudno(DbStudentVO vo) {
		Connection con = ServiceUtil.getConnection();
		PreparedStatement pstmt = null;// ��ݰ�ü
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT STUDNO, NAME, GRADE, HEIGHT FROM DBSTUDENT");
		ArrayList<String> studnolist = new ArrayList<String>();
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sb.toString()); // prepareStatement: SQL�� �����Ű�� ����� ���� ��ü. ��ü �����ÿ� ������ sql��ɾ��
															// �����Ҽ� �ִ�.
			rs = pstmt.executeQuery(); // executeQuery: �����ͺ��̽����� �����͸� �����ͼ� ��� ������ ��ȯ
			while (rs.next()) {
				vo.setStudno(rs.getString(1)); // ����Ŭ�� �ε����� 1���� �����ؼ�
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

	// �й� �ִ��� ������ üũ
	public boolean studnoCheck(String studno) {
		Connection con = ServiceUtil.getConnection();
		String sql = "SELECT STUDNO FROM DBSTUDENT WHERE STUDNO=?";
		PreparedStatement pstmt = null;// ��ݰ�ü
		ResultSet rs = null;
		try {
			pstmt = con.prepareStatement(sql); // ��ݰ�ü�� ������ �־ ��ȯ
			pstmt.setString(1, studno); // 1:ù��° ����ǥ
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
		PreparedStatement pstmt = null;// ��ݰ�ü
		ResultSet rs = null;
		DbStudentVO vo = new DbStudentVO();
		try {
			pstmt = con.prepareStatement(sql); // prepareStatement: SQL�� �����Ű�� ����� ���� ��ü. ��ü �����ÿ� ������ sql��ɾ�� �����Ҽ� �ִ�.
			pstmt.setString(1, studno);
			rs = pstmt.executeQuery(); // executeQuery: �����ͺ��̽����� �����͸� �����ͼ� ��� ������ ��ȯ
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
//      PreparedStatement pstmt=null;//��ݰ�ü 
//      //String sql="SELECT STUDNO, NAME,WEIGHT, HEIGHT FROM STUDENT"; //;�� �Ľ��� �� ��� �����ؾ��Ѵ�
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
//            vo.setStudno(rs.getString(1)); //����Ŭ�� �ε����� 1���� �����ؼ�
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
