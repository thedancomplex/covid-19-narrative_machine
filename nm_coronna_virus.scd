s.boot;
s.meter;


(
// New cases in percentage
n = {
	var percentNewCases =
    [0.46,0.56,0.53,0.39,0.64,0.32,0.29,0.26,0.22,0.22,0.2,0.19,0.19,0.15,0.11,0.11,0.08,0.08,0.06,0.05,0.31,0.09,0.04,0.03,0.03,0.03];
	var totalCases =
    [845,1317,2015,2800,4581,6058,7813,9821,11948,14551,17389,20628,24553,28276,31439,34876,37552,40553,43099,45170,59283,64437,67100,69197,71329,73332];
	[percentNewCases, totalCases];
}
)

(
//Osilators at two freq
SynthDef.new(\sinTest, {
	arg freqLFO_L=7, freqLFO_R=1, freqL=150, freqR=200;
    var sig, amp;
	amp = SinOsc.kr([freqLFO_L,freqLFO_R]).range(0,1);
	sig = SinOsc.ar([freqL,freqR]);
	sig = sig * amp;
	//sig = Mix.new(sig).dup(2) * 0.5;
	Out.ar(0,sig);
}).add;

t = {
    Task({
      loop {
			26.do({ arg item;
	            var pwmTmp, hzTmp, pwm = n.value[0][item], freq=n.value[1][item]/10000;
				x.set(\freqLFO_L,freq, \freqLFO_R, freq*(1+pwm));
				freq.postln;
				8.wait;
            });
      }
    });
};
)





x = Synth.new(\sinTest);
t.value.play;

x.set(\freqLFO_L,0.1);


n.value[0][1];
