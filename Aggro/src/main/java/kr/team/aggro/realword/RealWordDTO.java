package kr.team.aggro.realword;

public class RealWordDTO {
	private int rank;
	private String word;
	
	public RealWordDTO() {

	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	@Override
	public String toString() {
		return "RealSearchWordVo [rank=" + rank + ", word=" + word + "]";
	}
	
}
