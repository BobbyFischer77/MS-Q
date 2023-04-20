namespace ExploringInterference {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;
    
    @EntryPoint()
    operation TestInterference() : Unit {
        use q = Qubit();
        Y(q);
        DumpMachine();
        H(q);
        DumpMachine();
        Reset(q);
    }
}
