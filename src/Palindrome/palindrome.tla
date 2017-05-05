----------------------------------MODULE palindrome ------------------------------
EXTENDS TLC, Naturals
CONSTANTS n0

(*
--algorithm pal{
variables n=n0, reverse=0, temp, var;
{
    temp:=n;
    while(temp#0)
    {
        var := temp % 10;
        reverse := reverse*10;
        reverse := var + reverse;
        temp := temp \div 10;
    };
    if (n=reverse) {
        print <<"It's a palindrome number",n>>;
    }
    else
    {
        print <<"It is not a palindrome number",n>>;
    }
}
}

*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES n, reverse, temp, var, pc

vars == << n, reverse, temp, var, pc >>

Init == (* Global variables *)
        /\ n = n0
        /\ reverse = 0
        /\ temp = defaultInitValue
        /\ var = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ temp' = n
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << n, reverse, var >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF temp#0
               THEN /\ var' = temp % 10
                    /\ reverse' = reverse*10
                    /\ pc' = "Lbl_3"
               ELSE /\ IF n=reverse
                          THEN /\ PrintT(<<"It's a palindrome number",n>>)
                          ELSE /\ PrintT(<<"It is not a palindrome number",n>>)
                    /\ pc' = "Done"
                    /\ UNCHANGED << reverse, var >>
         /\ UNCHANGED << n, temp >>

Lbl_3 == /\ pc = "Lbl_3"
         /\ reverse' = var + reverse
         /\ temp' = (temp \div 10)
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << n, var >>

Next == Lbl_1 \/ Lbl_2 \/ Lbl_3
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == pc = "Done" \/ pc = "Lbl_2" \/ pc = "Lbl_1" \/ pc = "Lbl_3"

safe == n>=0 /\ reverse>=0

\* END TRANSLATION






===========================================
