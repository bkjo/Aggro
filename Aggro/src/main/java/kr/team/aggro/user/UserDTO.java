package kr.team.aggro.user;

public class UserDTO {
	private String nickName;
	
	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "UserDTO [nickName=" + nickName + "]";
	}
	
}
