------------------------MODULE other-------------------
EXTENDS TLC, Naturals, Integer
CONSTANTS x,v0

(*

--algorithm main{
variables v=v0, r, vardeux,z=0, v1=0, w=1, t=3, u=0, varun;
procedure p2(x) {
    while(u<x)
    {
        varun:=v1+w;
        z:=z+varun;
        v1:=v1+t;
        t:=t+6;
        w:=w+3;
        u:=u+1;
    }; 
}
{
    vardeux:=v*v;
    r:=vardeux*v;
    print<< " La solution trouvee est ",p2(v)>>;
    print<<" et devrait etre ",r>>;
}    
}

*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES v, r, vardeux, z, v1, w, t, u, varun, pc, stack, x

vars == << v, r, vardeux, z, v1, w, t, u, varun, pc, stack, x >>

Init == (* Global variables *)
        /\ v = v0
        /\ r = defaultInitValue
        /\ vardeux = defaultInitValue
        /\ z = 0
        /\ v1 = 0
        /\ w = 1
        /\ t = 3
        /\ u = 0
        /\ varun = defaultInitValue
        (* Procedure p2 *)
        /\ x = defaultInitValue
        /\ stack = << >>
        /\ pc = "Lbl_2"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF u<x
               THEN /\ varun' = v1+w
                    /\ z' = z+varun'
                    /\ v1' = v1+t
                    /\ t' = t+6
                    /\ w' = w+3
                    /\ u' = u+1
                    /\ pc' = "Lbl_1"
               ELSE /\ pc' = "Error"
                    /\ UNCHANGED << z, v1, w, t, u, varun >>
         /\ UNCHANGED << v, r, vardeux, stack, x >>

p2 == Lbl_1

Lbl_2 == /\ pc = "Lbl_2"
         /\ vardeux' = v*v
         /\ r' = vardeux'*v
         /\ PrintT(<< " La solution trouvee est ",p2(v)>>)
         /\ PrintT(<<" et devrait etre ",r'>>)
         /\ pc' = "Done"
         /\ UNCHANGED << v, z, v1, w, t, u, varun, stack, x >>

Next == p2 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION










=======================================================
