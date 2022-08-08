package membership;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {
	
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStateMent(query);
			psmt.setString(1,uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
		}
	}
}