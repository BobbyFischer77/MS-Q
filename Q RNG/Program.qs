namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation GenerateRandomBit() : Result {
    // Allocate a qubit
        use q = Qubit();
    // Put the qubit to superposition
        H(q);
    // It has now a 50% chance of being measured 0 or 1
    // Measure the qubit value and return
        return M(q);    
    }

    operation SampleRandomNumberInRange(max : Int , min : Int) : Int {
        mutable output = 0; 
        repeat {
            mutable bits = []; 
            for idxBit in 1..BitSizeI(max) {
                set bits += [GenerateRandomBit()]; 
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max and output >= min );
         return output;
    }

   @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 50;
        let min = 40;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max,min);
    }
}
