namespace ExploringGroversSearch {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    
    operation MarkColorEquality(c0 : Qubit[], c1 : Qubit[], target : Qubit) : Unit is Adj+Ctl {
        within{
            // iterate over pairs of qubits in matching positions in c0 and c1
            for (q0, q1) in Zipped(c0, c1){
                //compute XOR of bits q0 and q1 in place (storing it in q1)
                Message("-------------------------------Q0");
                DumpRegister((), [q0]);
                Message("-------------------------------Q1");
                DumpRegister((), [q1]);
                CNOT(q0, q1);
            }
        } apply{
            //if all computed XORs are 0, the bit strings are equal - flip the state of the target
            (ControlledOnInt(2, X))(c1, target);
            Message("-------------------------------Target");
            DumpRegister((), [target]);
        }
    }

    @EntryPoint()
    operation ShowColorEqualityTest() : Unit {
        use (c0, c1, target) = (Qubit[2], Qubit[2], Qubit());
        //Leave register c0 in the |00> state

        //Prepare a quantum state that is a superposition of all possible colors on register c1
        //ApplyToEach(H, c1);

        //Output the initial state of qubits c1 and target
        //We do not inlcude the state of the qubits in the register for brevity
        //since they will remain |00> throughout the program
        //Message("The starting states of qubits c1 and target:");
        //DumpRegister((), c1 + [target]);

        //Compare registers and mark the result in target qubit
        //X(c1[0]);
        X(c1[1]);
        MarkColorEquality(c0, c1, target);

        //Message("");
        //Message("The state of qubits c1 and target after the equality check:");
        //DumpRegister((), c1 + [target]);

        //Return the qubits to |0> state before releasing
        ResetAll(c1 + [target]);
    }
}
