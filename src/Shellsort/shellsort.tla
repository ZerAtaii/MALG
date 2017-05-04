------------------MODULE shellsort------------------------
EXTENDS TLC, Naturals, Integer
CONSTANTS x

(*
--algorithm main{
variables sizeTab=8,a=[5,6,3,1,7,8,2,4],trucinc,i=0,j,tmp,var;
procedure shellsort(b,size){
    trucinc:=3;
    while(inc>0)
    {
        i:=0..size;
        while (i#{}) {
            with (p \in i){
                await ~b[p];
                i := i \ {p} ;
            };
            (*for i:=0 step 1 until size do*)
            j:=i;
            tmp:=b[i];
            var:=j-trucinc;
            while (j>=trucinc /\ a(var)>tmp)
            {
                b[j]:=b[var];
                j:=j-trucinc;
            };
            b[j]:=tmp;
         
        (*end*)        
        };
        var:=trucinc \div 2;
        if  (var#0) {
            trucinc:=var;
        };
        else if (inc=1) {
            trucinc:=0;
        }
        else {
            trucinc:=1;
        };
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
VARIABLES sizeTab, a, trucinc, i, j, tmp, var, pc, stack, b, size

vars == << sizeTab, a, trucinc, i, j, tmp, var, pc, stack, b, size >>

Init == (* Global variables *)
        /\ sizeTab = 8
        /\ a = [5,6,3,1,7,8,2,4]
        /\ trucinc = defaultInitValue
        /\ i = 0
        /\ j = defaultInitValue
        /\ tmp = defaultInitValue
        /\ var = defaultInitValue
        (* Procedure shellsort *)
        /\ b = defaultInitValue
        /\ size = defaultInitValue
        /\ stack = << >>
        /\ pc = "Lbl_5"

Lbl_1 == /\ pc = "Lbl_1"
         /\ trucinc' = 3
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << sizeTab, a, i, j, tmp, var, stack, b, size >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF inc>0
               THEN /\ i' = 0..size
                    /\ pc' = "Lbl_3"
               ELSE /\ pc' = "Error"
                    /\ i' = i
         /\ UNCHANGED << sizeTab, a, trucinc, j, tmp, var, stack, b, size >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF i#{}
               THEN /\ \E p \in i:
                         /\ ~b[p]
                         /\ i' = i \ {p}
                    /\ j' = i'
                    /\ tmp' = b[i']
                    /\ var' = j'-trucinc
                    /\ pc' = "Lbl_4"
                    /\ UNCHANGED trucinc
               ELSE /\ var' = (trucinc \div 2)
                    /\ IF var'#0
                          THEN /\ trucinc' = var'
                          ELSE /\ IF inc=1
                                     THEN /\ trucinc' = 0
                                     ELSE /\ trucinc' = 1
                    /\ pc' = "Lbl_2"
                    /\ UNCHANGED << i, j, tmp >>
         /\ UNCHANGED << sizeTab, a, stack, b, size >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF j>=trucinc /\ a(var)>tmp
               THEN /\ b' = [b EXCEPT ![j] = b[var]]
                    /\ j' = j-trucinc
                    /\ pc' = "Lbl_4"
               ELSE /\ b' = [b EXCEPT ![j] = tmp]
                    /\ pc' = "Lbl_3"
                    /\ j' = j
         /\ UNCHANGED << sizeTab, a, trucinc, i, tmp, var, stack, size >>

shellsort == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4

Lbl_5 == /\ pc = "Lbl_5"
         /\ PrintT(<<"Array before sorting: ",a>>)
         /\ PrintT(<<"Array after sorting: ",shellsort(a,sizeTab)>>)
         /\ pc' = "Done"
         /\ UNCHANGED << sizeTab, a, trucinc, i, j, tmp, var, stack, b, size >>

Next == shellsort \/ Lbl_5
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION





==========================================================
