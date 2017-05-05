------------------MODULE shellsort------------------------
EXTENDS TLC, Naturals, Sequences
CONSTANTS a,sizeTab

(*
--algorithm main{
variables trucinc,i,j,tmp,tri=[k \in 1..sizeTab |->k+1 ],p=1;
{
    trucinc:=3;
    i:=1..sizeTab;
    while(trucinc>0)
    {
        
        while (i#{}) {
            i := i \ {p} ;
            j:=p;
            tmp:=a[p];
            if (j>=trucinc) {
                while (a[j-trucinc] > tmp)
                {
                    a[j]:=a[j-trucinc];
                    j:=j-trucinc;
                };
            };
                
            a[j] := tmp; 
        
            
            if  ((trucinc \div 2)#0) {
                trucinc:=trucinc \div 2;
            };
            if (trucinc=1) {
                trucinc:=0;
            }
            else {
                trucinc:=1;
            };
            p:=p+1;
        };
    
        
    };
    print <<"Array before sorting: ",a>>;
    print <<"Array after sorting: ",tri>>;
}
}
            
           
*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES trucinc, i, j, tmp, tri, p, pc

vars == << trucinc, i, j, tmp, tri, p, pc >>

Init == (* Global variables *)
        /\ trucinc = defaultInitValue
        /\ i = defaultInitValue
        /\ j = defaultInitValue
        /\ tmp = defaultInitValue
        /\ tri = [k \in 1..sizeTab |->k+1 ]
        /\ p = 1
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ trucinc' = 3
         /\ i' = 1..sizeTab
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << j, tmp, tri, p >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF trucinc>0
               THEN /\ pc' = "Lbl_3"
               ELSE /\ PrintT(<<"Array before sorting: ",a>>)
                    /\ PrintT(<<"Array after sorting: ",tri>>)
                    /\ pc' = "Done"
         /\ UNCHANGED << trucinc, i, j, tmp, tri, p >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF i#{}
               THEN /\ i' = i \ {p}
                    /\ j' = p
                    /\ tmp' = a[p]
                    /\ IF j'>=trucinc
                          THEN /\ pc' = "Lbl_4"
                          ELSE /\ pc' = "Lbl_5"
               ELSE /\ pc' = "Lbl_2"
                    /\ UNCHANGED << i, j, tmp >>
         /\ UNCHANGED << trucinc, tri, p >>

Lbl_5 == /\ pc = "Lbl_5"
         /\ a' = [a EXCEPT ![j] = tmp]
         /\ IF (trucinc \div 2)#0
               THEN /\ trucinc' = (trucinc \div 2)
               ELSE /\ TRUE
                    /\ UNCHANGED trucinc
         /\ IF trucinc'=1
               THEN /\ pc' = "Lbl_6"
               ELSE /\ pc' = "Lbl_7"
         /\ UNCHANGED << i, j, tmp, tri, p >>

Lbl_6 == /\ pc = "Lbl_6"
         /\ trucinc' = 0
         /\ pc' = "Lbl_8"
         /\ UNCHANGED << i, j, tmp, tri, p >>

Lbl_7 == /\ pc = "Lbl_7"
         /\ trucinc' = 1
         /\ pc' = "Lbl_8"
         /\ UNCHANGED << i, j, tmp, tri, p >>

Lbl_8 == /\ pc = "Lbl_8"
         /\ p' = p+1
         /\ pc' = "Lbl_3"
         /\ UNCHANGED << trucinc, i, j, tmp, tri >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF a[j-trucinc] > tmp
               THEN /\ a' = [a EXCEPT ![j] = a[j-trucinc]]
                    /\ j' = j-trucinc
                    /\ pc' = "Lbl_4"
               ELSE /\ pc' = "Lbl_5"
                    /\ j' = j
         /\ UNCHANGED << trucinc, i, tmp, tri, p >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_5 \/ Lbl_6 \/ Lbl_7 \/ Lbl_8
           \/ Lbl_4
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION





==========================================================
