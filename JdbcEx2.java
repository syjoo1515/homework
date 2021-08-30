package homework;

import java.util.List;
import java.util.Scanner;

import sist.com.dao.StudentDao;
import sist.com.vo.DbStudentVO;
import sist.com.vo.StudentVO;

public class JdbcEx2 {
	Scanner scanner = new Scanner(System.in);

//   public void showStudent() {   
//      for(StudentVO i : StudentDao.selectStudent()) {
//         System.out.println(i);
//      }
//   }
//   public void showProfessor() {
//      System.out.println("showProfessor");
//   }
//   public void menu() {
//      while(true) {
//      System.out.println("1.Student 2.Professor 3.Salgrade");
//      switch (scanner.nextInt()) {
//      case 1:   
//         showStudent();
//         break;
//      case 2:
//         showProfessor();
//         break;
//      default:
//         break;
//      }
//      }
//   }
	
	//insert
	public void insertStudent() {
		DbStudentVO st = new DbStudentVO();
		System.out.println("Studno:");
		st.setStudno(scanner.next().trim());
		System.out.println("Name:");
		st.setName(scanner.next().trim());
		System.out.println("Grade:");
		st.setGrade(scanner.next().trim());
		System.out.println("Height:");
		st.setHeight(scanner.nextDouble());
		StudentDao.insertStudent(st); // 입력받은 값 데이터베이스에 넣음
		System.out.println("InsertSuccess!");
	}

	//select
	public void selectAll() {
		for (DbStudentVO i : StudentDao.getStudentDao().selectDbStudent()) {
			System.out.println(i);
		}
	}

	//delete
	public void delete() {
		DbStudentVO vo = new DbStudentVO();
		System.out.println("DeleteStudno");
		String deleteStudno = scanner.next().trim(); // 삭제할 데이터 studno 입력받음
		for (String i : StudentDao.getStudentDao().selectDeleteDbStudno(vo)) {
			if (deleteStudno.equals(i)) {
				StudentDao.getStudentDao().deleteStudent(vo, i);
				System.out.println("DeleteSuccess!");
			}
		}
	}

	//update
	public void update() {
	      System.out.println("SearchStudno:");
	      String studno=scanner.next().trim();
	      if(!StudentDao.getStudentDao().studnoCheck(studno)) {
	         System.out.println("NoData!");
	         return;
	      }
	      
	      DbStudentVO st=new DbStudentVO();      
	      System.out.println("ModifyName:");
	      st.setName(scanner.next().trim());
	      System.out.println("ModifyGrade:");
	      st.setGrade(scanner.next().trim());
	      System.out.println("ModifyHeight:");
	      st.setHeight(scanner.nextDouble());
	      st.setStudno(studno);
	      StudentDao.getStudentDao().updateStudent(st);

	}
	
	//info
	public void info() {
		System.out.println("InfoStudno:");
		String studno=scanner.next().trim();
		if(!StudentDao.getStudentDao().studnoCheck(studno)) {
	         System.out.println("NoData!");
	         return;
	      }
			System.out.println(StudentDao.getStudentDao().infoStudent(studno));
	}
	

	public void dbStudentMenu() {
		while (true) {
			System.out.println("1.Insert 2.SelectAll 3.Delete 4.Update 5.Info ");
			switch (scanner.nextInt()) {
			case 1:
				insertStudent();
				break;
			case 2:
				selectAll();
				break;
			case 3:
				delete();
				break;
			case 4:
				update();
				break;
			case 5:
				info();
				break;
			default:
				break;
			}
		}
	}

	public static void main(String[] args) {
		new JdbcEx2().dbStudentMenu();
	}

}
