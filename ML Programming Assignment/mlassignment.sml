Control.Print.printDepth := 100;
Control.Print.printLength := 100;
(* QUESTION 1 : Merge FUNC*)

fun merge [] L2 = L2
| merge L1 [] = L1
| merge (x::xs) (y::ys) = if x<y then x::merge xs (y::ys) else y::merge (x::xs) ys;

(*QUESTION 2 : split*)
fun split [] = ([],[])
| split [x] = ([x],[])
| split (x::y::lizt) = 
	let
		val (xs,ys) = split lizt
	in
		((x::xs),(y::ys))
	end;
	
(*QUESTION 3 : mergeSort*)
fun mergeSort [] = []
| mergeSort [x] =[x]
| mergeSort L = 
	let
		val (L1,L2) = split L
	in
	(merge (mergeSort L1) (mergeSort L2))
	end;
	
(*QUESTION 4 : sort*)
fun sort (op <) []=[]
|sort (op <) [x] = [x]
|sort (op <) L =
let
	fun merge (op <) [] L2 = L2
	|merge (op <) L1 [] = L1
	|merge (op <) (x::xs) (y::ys) = if x < y then (x::(merge (op <) xs (y::ys))) else (y::(merge (op <) (x::xs) ys))
	fun split [] = ([],[])
	| split [x] = ([x],[])
	| split (x::y::lizt) = 
		let
			val (xs,ys) = split lizt
		in
			((x::xs),(y::ys))
		end
	
	val (L1,L2)= split L
	in
		(merge (op <) (sort (op <) L1) (sort (op <) L2))
	end;

(*QUESTION 5 : tree*)
datatype 'a tree = empty|leaf of 'a|node of 'a * 'a tree * 'a tree;

(*QUESTION 6 :labels*)
fun labels (empty) = []
| labels (leaf l) =[l]
| labels (node (x, L, R)) =labels L @  x:: labels R;

(*QUESTION 7 : replace*)
infix ==;

fun replace (op ==) x y (empty) = empty
| replace (op ==) x y (leaf l) = if l == x then leaf y else leaf l
| replace (op ==) x y (node (z, L, R)) = if z == x then node ( y, (replace (op ==) x y L), (replace (op ==) x y R)) else node ( z, (replace (op ==) x y L), (replace (op ==) x y R));

(*QUESTION 8 : replaceEmpty *)

fun replaceEmpty y (empty) = y
| replaceEmpty y (leaf l) = leaf l
|replaceEmpty y (node (z,L,R))= node ( z, replaceEmpty y L, replaceEmpty y R);

(*QUESTION 9 : maptree*)
fun mapTree f (empty) = f empty
|mapTree f (leaf l) = f (leaf l)
|mapTree f (node (z,L,R)) = f (node (z,mapTree f L,mapTree f R));

(*QUESTION 10 : sortTree*)
fun sortTree (op <) T =
mapTree (fn empty=>empty
		|(leaf l) => leaf (sort (op <) l)
		|(node (z,L,R)) => node ((sort (op <) z), L,R)) T;







