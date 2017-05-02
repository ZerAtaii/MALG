------------------------MODULE other-------------------
EXTENDS TLC, Naturals, Integer
CONSTANTS x

(*
--algorithm p2{
variables z=0, v=0, w=1, t=3, u=0, varun;
{
    while(u<x)
    {
        varun:=v+w;
        z:=z+varun;
        v:=v+t;
        t:=t+6;
        w:=w+3;
        u:=u+1;
    };
}
}



*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES z, v, w, t, u, varun, pc

vars == << z, v, w, t, u, varun, pc >>

Init == (* Global variables *)
        /\ z = 0
        /\ v = 0
        /\ w = 1
        /\ t = 3
        /\ u = 0
        /\ varun = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF u<x
               THEN /\ varun' = v+w
                    /\ z' = z+varun'
                    /\ v' = v+t
                    /\ t' = t+6
                    /\ w' = w+3
                    /\ u' = u+1
                    /\ pc' = "Lbl_1"
               ELSE /\ pc' = "Done"
                    /\ UNCHANGED << z, v, w, t, u, varun >>

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION








=======================================================
