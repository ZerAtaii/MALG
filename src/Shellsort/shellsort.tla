------------------MODULE Shellsort------------------------
EXTENDS TLC, Naturals, Integer
CONSTANTS x

(*
--algorithm main{
variables sizeTab=8,a=[5,6,3,1,7,8,2,4],inc,i,j,tmp,var;
procedure shellsort(b,size){
    inc:=3;
    while(inc>0)
    {
        (*i:=0..size;
        while (i#{}) {
            with (p \in i){
                await ~b[p];
                i := i \ {p} ;
            };*)
            for i:=0 step 1 until size do
            j:=i;
            tmp:=b[i];
            var:=j-inc;
            while (j>=inc and a(var)>tmp)
            {
                b[j]:=b[var];
                j:=j-inc;
            };
            b[j]:=tmp;
         
        end        
        (*};*)
        var:=inc \div 2;
        if  (var#0) then
            inc:=var;
        else if (inc=1) then
            inc:=0;
        else
            inc:=1;
    };
}
{
    print<<"Array before sorting: ",a>>;
    print<<"Array after sorting: ",shellsort(a,sizeTab)>>;
}
}
            
           
*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES sizeTab, a, inc, i, j, tmp, var, pc, stack, b, size

vars == << sizeTab, a, inc, i, j, tmp, var, pc, stack, b, size >>

Init == (* Global variables *)
        /\ sizeTab = 8
        /\ a = [5,6,3,1,7,8,2,4]
        /\ inc = defaultInitValue
        /\ i = defaultInitValue
        /\ j = defaultInitValue
        /\ tmp = defaultInitValue
        /\ var = defaultInitValue
        (* Procedure shellsort *)
        /\ b = defaultInitValue
        /\ size = defaultInitValue
        /\ stack = << >>
        /\ pc = "Lbl_4"

Lbl_1 == /\ pc = "Lbl_1"
         /\ inc' = 3
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << sizeTab, a, i, j, tmp, var, stack, b, size >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF inc>0
               THEN /\ for' = [for EXCEPT !i = 0 step 1 until size]
                    /\ do' = [do EXCEPT !j = i]
                    /\ tmp' = b[i]
                    /\ var' = j-inc
                    /\ pc' = "Lbl_3"
               ELSE /\ pc' = "Error"
                    /\ UNCHANGED << tmp, var >>
         /\ UNCHANGED << sizeTab, a, inc, i, j, stack, b, size >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF j>=inc and a(var)>tmp
               THEN /\ b' = [b EXCEPT ![j] = b[var]]
                    /\ j' = j-inc
                    /\ pc' = "Lbl_3"
                    /\ inc' = inc
               ELSE /\ b' = [b EXCEPT ![j] = tmp]
                    /\ end' = [end EXCEPT !var = inc \div 2]
                    /\ IF var#0
                          THEN /\ then' = [then EXCEPT !inc = var]
                               /\ inc' = inc
                          ELSE /\ IF inc=1
                                     THEN /\ then' = [then EXCEPT !inc = 0]
                                          /\ inc' = inc
                                     ELSE /\ inc' = 1
                    /\ pc' = "Lbl_2"
                    /\ j' = j
         /\ UNCHANGED << sizeTab, a, i, tmp, var, stack, size >>

shellsort == Lbl_1 \/ Lbl_2 \/ Lbl_3

Lbl_4 == /\ pc = "Lbl_4"
         /\ PrintT(<<"Array before sorting: ",a>>)
         /\ PrintT(<<"Array after sorting: ",shellsort(a,sizeTab)>>)
         /\ pc' = "Done"
         /\ UNCHANGED << sizeTab, a, inc, i, j, tmp, var, stack, b, size >>

Next == shellsort \/ Lbl_4
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION






==========================================================
