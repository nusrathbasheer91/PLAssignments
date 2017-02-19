
class OInt(z:Int) extends Ordered[OInt]{
  var x = z
  def compare(that : OInt) = if (this.x < that.x) -1 else if (this.x> that.x) 1 else 0
  override def toString(): String = "<"+x+">"
}

abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]
  case class ONode[T <: Ordered[T]](n : List[OTree[T]]) extends OTree[T]{
      def compare(that : OTree[T]): Int =  that match{
      case OLeaf(y) => 1
      case ONode(m) => compareLists(n, m)
  }
     def compareLists(L1 : List[OTree[T]], L2: List[OTree[T]]) :Int = (L1,L2) match {
    //case (Nil,Nil) => 0
    case (List(),List()) => 0
    case (List(),_) => 0-L2.length
    case (_, List()) => L1.length
    case (x::xs,y::ys) => compareLists(xs, ys) + x.compare(y) 
  }
  }
  case class OLeaf[T <: Ordered[T]](l : T) extends OTree[T] {      
    def compare(that : OTree[T]) =that match{
      case OLeaf(y) => l.compare(y)
      case ONode(y::ys) => -1
  } 
  }

object Part2 {
  
  def compareTrees[T <:Ordered[T]](t1 : OTree[T],t2 : OTree[T]) = {
    var c:Int = t1.compare(t2)
    if (c < 0) println("Less")//t1 is less than t2
    else if (c > 0) println("Greater")// t1 is greater that t2
    else println("Equal")   
  }
  
  def test() {
    val tree1 = ONode(List(OLeaf(new OInt(6))))

    val tree2 = ONode(List(OLeaf(new OInt(3)),
			   OLeaf(new OInt(4)), 
			   ONode(List(OLeaf(new OInt(5)))), 
			   ONode(List(OLeaf(new OInt(6)), 
				      OLeaf(new OInt(7))))));

    val treeTree1: OTree[OTree[OInt]] = 
      ONode(List(OLeaf(OLeaf(new OInt(1)))))

    val treeTree2: OTree[OTree[OInt]] = 
      ONode(List(OLeaf(OLeaf(new OInt(1))),
		 OLeaf(ONode(List(OLeaf(new OInt(2)), 
				  OLeaf(new OInt(2)))))))


    print("tree1: ")
    println(tree1)
    print("tree2: ")
    println(tree2)
    print("treeTree1: ")
    println(treeTree1)
    print("treeTree2: ")
    println(treeTree2)
    print("Comparing tree1 and tree2: ")
    compareTrees(tree1, tree2)
    print("Comparing tree2 and tree2: ")
    compareTrees(tree2, tree2)
    print("Comparing tree2 and tree1: ")
    compareTrees(tree2, tree1)
    print("Comparing treeTree1 and treeTree2: ")
    compareTrees(treeTree1, treeTree2)
    print("Comparing treeTree2 and treeTree2: ")
    compareTrees(treeTree2, treeTree2)
    print("Comparing treeTree2 and treeTree1: ")
    compareTrees(treeTree2, treeTree1)

  }
  
  def main(args: Array[String]) {    
    test()
  }
  
}