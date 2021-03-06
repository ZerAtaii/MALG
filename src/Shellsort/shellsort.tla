------------------MODULE shellsort------------------------
EXTENDS TLC, Naturals, Sequences
CONSTANTS sizeTab

(*
--algorithm main{
variables a,trucinc=0,i=0,j=0,tmp=0;
{
    a:=<<5,8,9,6,7,2,1,3>>;
    trucinc:=1;
    i:=1;
    print <<"Array before sorting: ",a>>;
    while(trucinc>0)
    {
        
        while (i<=sizeTab) {
            
           j:=i;
           tmp:=a[i];
           
                
           while ((j>trucinc) /\ (a[j-trucinc] > tmp))
           {
                    
               a[j]:=a[j-trucinc];
               j:=j-trucinc;
               
            };
            a[j] := tmp;
                
            
            i:=i+1;
        };
            
        if  ((trucinc \div 2)#0) {
            trucinc:=trucinc \div 2;
                
        };
        else if (trucinc=1) {
                trucinc:=0;
                    
        };
        else {
                    
            trucinc:=1;
            
        };
            
        
    
        
    };
    
    print <<"Array after sorting: ",a>>;
}
}
            
           
*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES a, trucinc, i, j, tmp, pc

vars == << a, trucinc, i, j, tmp, pc >>

Init == (* Global variables *)
        /\ a = defaultInitValue
        /\ trucinc = 0
        /\ i = 0
        /\ j = 0
        /\ tmp = 0
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ a' = <<5,8,9,6,7,2,1,3>>
         /\ trucinc' = 1
         /\ i' = 1
         /\ PrintT(<<"Array before sorting: ",a'>>)
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << j, tmp >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF trucinc>0
               THEN /\ pc' = "Lbl_3"
               ELSE /\ PrintT(<<"Array after sorting: ",a>>)
                    /\ pc' = "Done"
         /\ UNCHANGED << a, trucinc, i, j, tmp >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ IF i<=sizeTab
               THEN /\ j' = i
                    /\ tmp' = a[i]
                    /\ pc' = "Lbl_4"
                    /\ UNCHANGED trucinc
               ELSE /\ IF (trucinc \div 2)#0
                          THEN /\ trucinc' = (trucinc \div 2)
                          ELSE /\ IF trucinc=1
                                     THEN /\ trucinc' = 0
                                     ELSE /\ trucinc' = 1
                    /\ pc' = "Lbl_2"
                    /\ UNCHANGED << j, tmp >>
         /\ UNCHANGED << a, i >>

Lbl_4 == /\ pc = "Lbl_4"
         /\ IF (j>trucinc) /\ (a[j-trucinc] > tmp)
               THEN /\ a' = [a EXCEPT ![j] = a[j-trucinc]]
                    /\ j' = j-trucinc
                    /\ pc' = "Lbl_4"
                    /\ i' = i
               ELSE /\ a' = [a EXCEPT ![j] = tmp]
                    /\ i' = i+1
                    /\ pc' = "Lbl_3"
                    /\ j' = j
         /\ UNCHANGED << trucinc, tmp >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3 \/ Lbl_4
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

safe == i>=0 /\ j>=0 /\ tmp>=0 /\ trucinc>=0 /\ (pc="Done"=> \A k \in 1..sizeTab-1: a[k]<=a[k+1] )

Temporal == pc = "Lbl_1" \/ pc = "Lbl_2" \/ pc = "Lbl_3" \/ pc = "Lbl_4" \/ pc = "Done"

\* END TRANSLATION





==========================================================
