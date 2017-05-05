------------------------MODULE other-------------------
EXTENDS TLC, Naturals, Sequences
CONSTANTS v0

(*

--algorithm main{
variables v=v0, r, vardeux,z=0, v1=0, w=1, t=3, u=0, varun, test;
{

    while(u<v)
    {
        varun:=v1+w;
        z:=z+varun;
        v1:=v1+t;
        t:=t+6;
        w:=w+3;
        u:=u+1;
    }; 
    vardeux:=v*v;
    r:=vardeux*v;
    print<< " La solution trouvee est ",z>>;
    print<<" et devrait etre ",r>>;  
}
}

*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES v, r, vardeux, z, v1, w, t, u, varun, test, pc

vars == << v, r, vardeux, z, v1, w, t, u, varun, test, pc >>

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
        /\ test = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF u<v
               THEN /\ varun' = v1+w
                    /\ z' = z+varun'
                    /\ v1' = v1+t
                    /\ t' = t+6
                    /\ w' = w+3
                    /\ u' = u+1
                    /\ pc' = "Lbl_1"
                    /\ UNCHANGED << r, vardeux >>
               ELSE /\ vardeux' = v*v
                    /\ r' = vardeux'*v
                    /\ PrintT(<< " La solution trouvee est ",z>>)
                    /\ PrintT(<<" et devrait etre ",r'>>)
                    /\ pc' = "Done"
                    /\ UNCHANGED << z, v1, w, t, u, varun >>
         /\ UNCHANGED << v, test >>

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination ==  pc = "Done" \/ pc = "Lbl_1"

safe ==  u<=v /\ (pc="Done" => r=v*v*v /\ z = v*v*v)
\* END TRANSLATION










=======================================================
