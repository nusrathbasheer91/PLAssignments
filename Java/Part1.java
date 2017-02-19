import java.util.ArrayList;

class ComparableList<T extends Comparable<T>> extends ArrayList<T> implements Comparable<ComparableList<T>> {

	public int compareTo(ComparableList<T> L2) {
		int diff = this.size()-L2.size();//if lengths are not same
		if (Math.abs(diff)==0) //if lengths are the same
		{
			diff=0;
			int i=0;
			while(diff==0 && i<this.size()){
				if(this.get(i)!=L2.get(i))
				{
					diff=this.get(i).compareTo(L2.get(i));
				}
				i++;
			}
		}
		return diff;
			
	}
	
	@Override
	public String toString(){
		String out = "[";
		for (int i=0;i<this.size();i++){
			out+= " "+this.get(i);
		}
		out+="]";
		return out;
	}
}


class A implements Comparable<A>{
	Integer a;
	public A(Integer x){
		a=x;
	}
	
	@Override
	public int compareTo(A o) {
		if (this.a == o.a) return 0;
		else
		return (this.a> o.a) ? 1 : -1;
	}	
	
	@Override
	public String toString(){
		return "A<"+this.a.toString()+">";
	}
}
class B extends A{
	Integer m,n;
	
	public B(Integer x, Integer y){
		super(x+y);
		m=x;
		n=y;
	}
	
	@Override
	public String toString(){
		return "B<"+this.m.toString()+","+this.n.toString()+">";
	}
	
	/*@Override
	public int compareTo(A o) {
		if ((this.m+this.n) == o.a) return 0;
		else
		return ((this.m+this.n)> o.a) ? 1 : -1;
	}*/
	
	public int compareTo(B o) {
		if ((this.m+this.n) == (o.m+o.n)) return 0;
		else
		return ((this.m+this.n)> (o.m+o.n)) ? 1 : -1;
	}
}




public class Part1 {

	static void test() {
		ComparableList<A> c1 = new ComparableList<A>();
		ComparableList<A> c2 = new ComparableList<A>();
		for(int i = 0; i < 10; i++) {
		    addToCList(new A(i), c1);
		    addToCList(new A(i), c2);
		}
		
		addToCList(new A(12), c1);
		addToCList(new B(6,6), c2);
		
		addToCList(new B(7,11), c1);
		addToCList(new A(13), c2);

		System.out.print("c1: ");
		System.out.println(c1);
		
		System.out.print("c2: ");
		System.out.println(c2);

		switch (c1.compareTo(c2)) {
		case -1: 
		    System.out.println("c1 < c2");
		    break;
		case 0:
		    System.out.println("c1 = c2");
		    break;
		case 1:
		    System.out.println("c1 > c2");
		    break;
		default:
		    System.out.println("Uh Oh");
		    break;
		}

	    }
	
	private static <T extends Comparable<T>> void addToCList(T z, ComparableList<T> L) {
		L.add(z);
	}

	public static void main(String[] args)
	{
		test();
	}
}














