with Ada.Text_IO, Ada.Float_Text_IO;
with ada.Numerics.Generic_Elementary_Functions;
use Ada.Text_IO, Ada.float_Text_IO;
with AdaptiveQuad;

procedure AQMain is
   Epsilon : Float;

   package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
   use FloatFunctions;

   package Int_Io is new Integer_Io(Integer);  -- always need these two lines
   use Int_Io;
   function MyF( x: float) return float is
   begin
     return sin(x*x);
   end MyF;

   package AdaptiveQuadInstance is new AdaptiveQuad(MyF);

   task ReadPairs;
   task ComputeArea is
      entry Go(A1,B1 : Float);
   end ComputeArea;
    task PrintResult is
      entry prin(App,Bpp,Resultpp : Float);
   end PrintResult;

   task body ReadPairs is
      Ar, Br : Float;
      begin
      for I in 1..5 loop
--         Put("in accept loop read");
        -- Put(I);
      get(Ar);
     -- Put("got ar");
      get(Br);
      --Put("got br");
         ComputeArea.Go(Ar,Br);
     end loop;
   end ReadPairs;
   task body ComputeArea is
      Ac,Bc,result : FLoat;
   begin
      for i in 1..5 loop
         accept Go(A1,B1 : FLoat) do
          -- Put("in accept loop compute"); -- if this entry call comes in,
         Ac:=A1;
         Bc:=B1;
      end Go;
            Epsilon:= 0.000000001;
            result := AdaptiveQuadInstance.AQuad(Ac,Bc,Epsilon);
            PrintResult.prin(Ac,Bc,result);
        end loop;

   end ComputeArea;
   task body PrintResult is
      Ap,Bp,resultp:float;
   begin
     -- put("in printresult");
      for i in 1..5 loop
      accept prin(App,Bpp,resultpp:Float) do
         --put("in prin accept");
         Ap:=App;
         Bp:=Bpp;
         resultp:=resultpp;
         end prin;
      Put("The area under sin(x^2) for x = ");
      Put(Ap);
      Put(" to ");
      Put(Bp);
      Put(" is ");
      Put(resultp);
      end loop;

   end PrintResult;




begin
null;
end AQMain;
