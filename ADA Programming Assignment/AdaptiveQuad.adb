with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.float_Text_IO;

package body AdaptiveQuad is
   --simprule,recaquad,aquad
   function simpsonsrule(a,b : float) return float is
   c, h3 : float;
   begin
      c:= (a+b)/2.0;
      h3:= abs(b-a)/6.0;
      return h3*(f(a)+4.0*f(c)+f(b));
   end simpsonsrule;


   function RecAQuad(a,b,eps,whole : float) return Float is
      rec1,rec2,c,left, right: Float;
      procedure Rec is
         task one;
         task two;
         task body one is
         begin
          --  Put("in rec1");
            rec1 := RecAQuad(a,c,eps/2.0,left);
         end one;
         task body two is
         begin
            rec2 := RecAQuad(c,b,eps/2.0,right);
         end two;
   begin
      null;
   end Rec;


   begin
       c:=(a+b)/2.0;
   left:= simpsonsrule(a,c);
   right:= simpsonsrule(c,b);
   if abs(left+right-whole)<=15.0*eps then
      return left+right+(left+right-whole)/15.0;
      else
           rec;
           return rec1+rec2;
         --return RecAQuad(a,c,eps/2.0,left)+ RecAQuad(c,b,eps/2.0,right); --Rec();
      end if;
   end RecAQuad;

   function AQuad(A,B,Eps : Float) return float is
   begin
      -- return f(y)
      return RecAQuad(a,b,eps,simpsonsrule(a,b));
   end AQuad;

   end AdaptiveQuad;
