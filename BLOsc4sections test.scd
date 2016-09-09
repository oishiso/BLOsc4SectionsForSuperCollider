// SynthDef
(
SynthDef(\BLOsc4sectionsExample, {
	arg
	freq = 220.0,

	loHarmonics1 = 1.0,
	hiHarmonics1 = 6.0,
	slope1 = 1.0,
	evenOddRatio1 = 1.0,
	spread1 = 1,
	sectionAmp1 = 1,

	loHarmonics2 = 0.0,
	hiHarmonics2 = 0.0,
	slope2 = 1.0,
	evenOddRatio2 = 1.0,
	spread2 = 1,
	sectionAmp2 = 1,

	loHarmonics3 = 0.0,
	hiHarmonics3 = 0.0,
	slope3 = 1.0,
	evenOddRatio3 = 1.0,
	spread3 = 1,
	sectionAmp3 = 1,

	loHarmonics4 = 0.0,
	hiHarmonics4 = 0.0,
	slope4 = 1.0,
	evenOddRatio4 = 1.0,
	spread4 = 1,
	sectionAmp4 = 1,

	spreadCompensation = 1,

	amp = 1.0
	;

	Out.ar(0,
		BLOsc4sections.ar(
			freq: freq,

			loHarmonics1: loHarmonics1,
			hiHarmonics1: hiHarmonics1,
			slope1: slope1,
			evenOddRatio1: evenOddRatio1,
			spread1: spread1,
			sectionAmp1: sectionAmp1,

			loHarmonics2: loHarmonics2,
			hiHarmonics2: hiHarmonics2,
			slope2: slope2,
			evenOddRatio2: evenOddRatio2,
			spread2: spread2,
			sectionAmp2: sectionAmp2,

			loHarmonics3: loHarmonics3,
			hiHarmonics3: hiHarmonics3,
			slope3: slope3,
			evenOddRatio3: evenOddRatio3,
			spread3: spread3,
			sectionAmp3: sectionAmp3,

			loHarmonics4: loHarmonics4,
			hiHarmonics4: hiHarmonics4,
			slope4: slope4,
			evenOddRatio4: evenOddRatio4,
			spread4: spread4,
			sectionAmp4: sectionAmp4,

			spreadCompensation: spreadCompensation,

			mul: amp))
}).add;
)

// Spectrum Analyzer
(
~openAnalyzer = {
	var window, func;
	window = Window("Analyzer", Rect(100, 100, 511, 300)); // width should be 511
	func = FreqScopeView(window, window.view.bounds);
	func.active_(true); // turn it on the first time;
	func.freqMode_(1); //log scale
	window.onClose_({ func.kill }); // you must have this
	window.front;
}.value
)

FreqScope.new

(
{
	BLOsc4sections.ar(
		freq: SinOsc.ar(0.01).range(100,200),

		loHarmonics1: 1.0,
		hiHarmonics1: LFNoise2.ar(0.4).range(3.0, 5.0),
		slope1: LFNoise2.ar(0.3).range(0.1, 1.9),
		evenOddRatio1: LFNoise2.ar(0.2).range(0.0, 1),
		spread1: 2,
		sectionAmp1: LFNoise2.ar(0.1).range(-128.0, 0).dbamp,

		loHarmonics2: LFNoise2.ar(0.4).range(5.0, 7.0),
		hiHarmonics2: LFNoise2.ar(0.4).range(7.0, 9.0),
		slope2: LFNoise2.ar(0.3).range(0.1, 1.9),
		evenOddRatio2: LFNoise2.ar(0.2).range(0.0, 1),
		spread2: 1,
		sectionAmp2: LFNoise2.ar(0.1).range(-128.0, 0).dbamp,

		loHarmonics3: LFNoise2.ar(0.4).range(9.0, 11.0),
		hiHarmonics3: LFNoise2.ar(0.4).range(11.0, 13.0),
		slope3: LFNoise2.ar(0.3).range(0.1, 1.9),
		evenOddRatio3: LFNoise2.ar(0.2).range(0.0, 1),
		spread3: 2,
		sectionAmp3: LFNoise2.ar(0.1).range(-128.0, 0).dbamp,

		loHarmonics4: LFNoise2.ar(0.4).range(13.0, 15.0),
		hiHarmonics4: LFNoise2.ar(0.4).range(15.0, 18.0),
		slope4: LFNoise2.ar(0.3).range(0.1, 1.9),
		evenOddRatio4: LFNoise2.ar(0.2).range(0.0, 1),
		spread4: 1,
		sectionAmp4: LFNoise2.ar(0.1).range(-128.0, 0).dbamp,

		spreadCompensation: 1,

		mul: 1.0,
		add: 0.0
	)
}.play
)


// Demonstration with Gui
(
var window, sound,

knob_freq,

knob_loHarmonics1,
knob_hiHarmonics1,
knob_slope1,
knob_evenOddRatio1,
knob_spread1,
knob_sectionAmp1,

knob_loHarmonics2,
knob_hiHarmonics2,
knob_slope2,
knob_evenOddRatio2,
knob_spread2,
knob_sectionAmp2,

knob_loHarmonics3,
knob_hiHarmonics3,
knob_slope3,
knob_evenOddRatio3,
knob_spread3,
knob_sectionAmp3,

knob_loHarmonics4,
knob_hiHarmonics4,
knob_slope4,
knob_evenOddRatio4,
knob_spread4,
knob_sectionAmp4,

knob_spreadCompensation,
knob_amp;


window = Window("Band Limited Oscillator", Rect(left: 100, top: 100, width: 800, height: 700));
window.view.decorator = FlowLayout(window.view.bounds);
StaticText(window,500 @ 40).string_("Band Limited Oscillator").align_(\center)
.font_(Font("Helvetica", 16));
window.view.decorator.nextLine;

knob_freq = EZKnob(window, 120 @ 90, "freq", ControlSpec(20,440, \lin, step: 10, default: 220),
	{|view| if (sound.notNil) { sound.set(\freq, view.value) }},
	labelWidth: 50);


window.view.decorator.nextLine;


knob_loHarmonics1 = EZKnob(window, 120 @ 90, "loHarmonics1", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\loHarmonics1, view.value) }},
	labelWidth: 50);

knob_hiHarmonics1 = EZKnob(window, 120 @ 90, "hiHarmonics1", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 6.0),
	{|view| if (sound.notNil) { sound.set(\hiHarmonics1, view.value) }},
	labelWidth: 50);

knob_slope1 = EZKnob(window, 120 @ 90, "slope1", ControlSpec(0.1, 2.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\slope1, view.value) }},
	labelWidth: 50);

knob_evenOddRatio1 = EZKnob(window, 120 @ 90, "evenOddRatio1", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\evenOddRatio1, view.value) }},
	labelWidth: 50);

knob_spread1 = EZKnob(window, 120 @ 90, "spread1", ControlSpec(1, 5, \lin, step: 1, default: 1),
	{|view| if (sound.notNil) { sound.set(\spread1, view.value) }},
	labelWidth: 50);

knob_sectionAmp1 = EZKnob(window, 120 @ 90, "sectionAmp1(in dB)", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\sectionAmp1, view.value) }},
	labelWidth: 50);


window.view.decorator.nextLine;


knob_loHarmonics2 = EZKnob(window, 120 @ 90, "loHarmonics2", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\loHarmonics2, view.value) }},
	labelWidth: 50);

knob_hiHarmonics2 = EZKnob(window, 120 @ 90, "hiHarmonics2", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\hiHarmonics2, view.value) }},
	labelWidth: 50);

knob_slope2 = EZKnob(window, 120 @ 90, "slope2", ControlSpec(0.1, 2.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\slope2, view.value) }},
	labelWidth: 50);

knob_evenOddRatio2 = EZKnob(window, 120 @ 90, "evenOddRatio2", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\evenOddRatio2, view.value) }},
	labelWidth: 50);

knob_spread2 = EZKnob(window, 120 @ 90, "spread2", ControlSpec(1, 5, \lin, step: 1, default: 1),
	{|view| if (sound.notNil) { sound.set(\spread2, view.value) }},
	labelWidth: 50);

knob_sectionAmp2 = EZKnob(window, 120 @ 90, "sectionAmp2(in dB)", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\sectionAmp2, view.value) }},
	labelWidth: 50);


window.view.decorator.nextLine;


knob_loHarmonics3 = EZKnob(window, 120 @ 90, "loHarmonics3", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\loHarmonics3, view.value) }},
	labelWidth: 50);

knob_hiHarmonics3 = EZKnob(window, 120 @ 90, "hiHarmonics3", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\hiHarmonics3, view.value) }},
	labelWidth: 50);

knob_slope3 = EZKnob(window, 120 @ 90, "slope3", ControlSpec(0.1, 2.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\slope3, view.value) }},
	labelWidth: 50);

knob_evenOddRatio3 = EZKnob(window, 120 @ 90, "evenOddRatio3", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\evenOddRatio3, view.value) }},
	labelWidth: 50);

knob_spread3 = EZKnob(window, 120 @ 90, "spread3", ControlSpec(1, 5, \lin, step: 1, default: 1),
	{|view| if (sound.notNil) { sound.set(\spread3, view.value) }},
	labelWidth: 50);

knob_sectionAmp3 = EZKnob(window, 120 @ 90, "sectionAmp3(in dB)", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\sectionAmp3, view.value) }},
	labelWidth: 50);


window.view.decorator.nextLine;


knob_loHarmonics4 = EZKnob(window, 120 @ 90, "loHarmonics4", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\loHarmonics4, view.value) }},
	labelWidth: 50);

knob_hiHarmonics4 = EZKnob(window, 120 @ 90, "hiHarmonics4", ControlSpec(0.0, 50.0, \lin, step: 0.25, default: 0.0),
	{|view| if (sound.notNil) { sound.set(\hiHarmonics4, view.value) }},
	labelWidth: 50);

knob_slope4 = EZKnob(window, 120 @ 90, "slope4", ControlSpec(0.1, 2.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\slope4, view.value) }},
	labelWidth: 50);

knob_evenOddRatio4 = EZKnob(window, 120 @ 90, "evenOddRatio4", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\evenOddRatio4, view.value) }},
	labelWidth: 50);

knob_spread4 = EZKnob(window, 120 @ 90, "spread4", ControlSpec(1, 5, \lin, step: 1, default: 1),
	{|view| if (sound.notNil) { sound.set(\spread4, view.value) }},
	labelWidth: 50);

knob_sectionAmp4 = EZKnob(window, 120 @ 90, "sectionAmp4(in dB)", ControlSpec(0.0, 1.0, \lin, step: 0.1, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\sectionAmp4, view.value) }},
	labelWidth: 50);


window.view.decorator.nextLine;

knob_spreadCompensation = EZKnob(window, 120 @ 90, "spreadCompensation", ControlSpec(0, 1, \lin, step: 1, default: 1),
	{|view| if (sound.notNil) { sound.set(\spreadCompensation, view.value) }},
	labelWidth: 50);

knob_amp = EZKnob(window, 120 @ 90, "amp", ControlSpec(0.1, 1.0, \lin, default: 1.0),
	{|view| if (sound.notNil) { sound.set(\amp, view.value) }},
	labelWidth: 50);

window.view.decorator.left_(10).top_(630);
Button(window, 50@50)
.states_([["Start"], ["Stop", Color.black, Color.red(alpha: 0.2)]])
.action_({|view|  if (view.value ==1 && sound.isNil,
	{sound =
		Synth(\BLOsc4sectionsExample,
			[

				\freq, knob_freq.value,

				\loHarmonics1, knob_loHarmonics1.value,
				\hiHarmonics1, knob_hiHarmonics1.value,
				\slope1, knob_slope1.value,
				\evenOddRatio1, knob_evenOddRatio1.value,
				\spread1, knob_spread1.value,
				\sectionAmp1, knob_sectionAmp1.value,

				\loHarmonics2, knob_loHarmonics2.value,
				\hiHarmonics2, knob_hiHarmonics2.value,
				\slope2, knob_slope2.value,
				\evenOddRatio2, knob_evenOddRatio2.value,
				\spread2, knob_spread2.value,
				\sectionAmp2, knob_sectionAmp2.value,

				\loHarmonics3, knob_loHarmonics3.value,
				\hiHarmonics3, knob_hiHarmonics3.value,
				\slope3, knob_slope3.value,
				\evenOddRatio3, knob_evenOddRatio3.value,
				\spread3, knob_spread3.value,
				\sectionAmp3, knob_sectionAmp3.value,

				\loHarmonics4, knob_loHarmonics4.value,
				\hiHarmonics4, knob_hiHarmonics4.value,
				\slope4, knob_slope4.value,
				\evenOddRatio4, knob_evenOddRatio4.value,
				\spread4, knob_spread4.value,
				\sectionAmp4, knob_sectionAmp4.value,

				\spreadCompensation, knob_spreadCompensation.value,

				\mul, knob_amp.value

	])},
	{sound.free; sound = nil }
	)
});
window.front;
)
/*
(
var window, sound, sl1, sl2, sl3, sl4, sl5, sl6, sl7;
window = Window("Band Limited Oscillator", Rect(100,420,620,300));
window.view.decorator = FlowLayout(window.view.bounds);
StaticText(window,620 @ 40).string_("Band Limited Oscillator").align_(\center)
.font_(Font("Helvetica", 16));
window.view.decorator.nextLine;
sl1 = EZSlider(window, 600 @ 20, "Fundamental Freq", ControlSpec(55.0,880,\exponential,default: 440.0),
	{| view | if (sound.notNil)
		{ sound.set(\freq, view.value)}
	},
	labelWidth: 130);
window.view.decorator.nextLine;
sl2 = EZSlider(window, 600 @ 20, "Lowest Harmonics", ControlSpec(1.0,100,step: 0.1,default: 1.0),
	{| view | if (sound.notNil)
		{ sound.set(\lo, view.value)}
	},
	labelWidth: 130);
window.view.decorator.nextLine;
sl3 = EZSlider(window, 600 @ 20, "Highest Harmonics", ControlSpec(1.0,100,step: 0.1,default: 7.0),
	{| view | if (sound.notNil)
		{ sound.set(\hi, view.value)}
	},
	labelWidth: 130);
window.view.decorator.nextLine;
sl4 = EZSlider(window, 600 @ 20, "Slope", ControlSpec(0.1,2.0,default: 1.0),
	{| view | if (sound.notNil)
		{ sound.set(\slope, view.value)}
	},
	labelWidth: 130);
window.view.decorator.nextLine;
sl5 = EZSlider(window, 600 @ 20, "Even to Odd Ratio", ControlSpec(0,1.0,default: 1.0),
	{| view | if (sound.notNil)
		{ sound.set(\eRatio, view.value)}
	},
	labelWidth: 130);
window.view.decorator.nextLine;
sl6 = EZSlider(window, 600 @ 20, "spread", ControlSpec(0, 16.0, step:1.0, default: 1.0),
	{| view | if (sound.notNil)
		{ sound.set(\spread, view.value)}
	},
labelWidth: 130);
window.view.decorator.nextLine;
sl7 = EZSlider(window, 600 @ 20, "Amp", ControlSpec(0,1.0,\amp,default: 1.0),
	{| view | if (sound.notNil)
		{ sound.set(\amp, view.value)}
	},
	labelWidth: 130);
window.view.decorator.left_(300).top_(230);
Button(window, 50@50)
.states_([["Start"], ["Stop", Color.black, Color.red(alpha: 0.2)]])
.action_({|view|  if (view.value ==1 && sound.isNil,
	{sound =
		Synth(\BLOsc4sectionsExample,
			[\freq,sl1.value,
				\lo, sl2.value,
				\hi, sl3.value,
				\slope, sl4.value,
				\eRatio, sl5.value,
				\spread, sl6.value,
				\spreadCompensation, 1,
				\amp, sl7.value])},
	{sound.free; sound = nil }
	)
});
window.front;
)
*/
// BLOsc_ComplexSinusoid6 is better than BLOsc_ComplexSinusoid7

// modulate slope with higher spread
// {BLOsc_ComplexSinusoid6.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: SinOsc.kr(freq: 2.0).range(0.1, 1.9), evenOddRatio: 1.0, spread: 3.0, mul: 0.8)}.play
// {BLOsc_ComplexSinusoid7.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: SinOsc.kr(freq: 2.0).range(0.1, 1.9), evenOddRatio: 1.0, spread: 3.0, mul: 0.8)}.play
{BLOsc4sections.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: SinOsc.kr(freq: 2.0).range(0.1, 1.9), evenOddRatio: 1.0, spread: 3.0, mul: 0.8)}.play

// {BLOsc_ComplexSinusoid6.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: SinOsc.kr(freq: 0.1).range(0.1, 1.9), evenOddRatio: 1.0, spread: 3.0, mul: 0.8)}.play


/*
// modulate the spread
{BLOsc_ComplexSinusoid6.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play
{BLOsc_ComplexSinusoid6b.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play
{BLOsc_ComplexSinusoid7.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play
{BLOsc4sections.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play

// Where is the distortion coming from for 6b and 7b (the following makes different results)
{BLOsc_ComplexSinusoid7.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread:1.1, mul: 0.8)}.play
{BLOsc4sections.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread:1.1, mul: 0.8)}.play
{BLOsc_ComplexSinusoid7.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread:2, mul: 0.8)}.play
{BLOsc4sections.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 0.5, evenOddRatio: 1.0, spread:2, mul: 0.8)}.play


{BLOsc_ComplexSinusoid6.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 1.0, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play
{BLOsc_ComplexSinusoid7.ar(freq: 100.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 1.0, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 0.1).range(1.0, 5.0), mul: 0.8)}.play

{BLOsc_ComplexSinusoid6.ar(freq: 50.0, loHarmonics: 1.0, hiHarmonics: 6.0, slope: 1.0, evenOddRatio: 1.0, spread: SinOsc.kr(freq: 1.0).range(1.0, 10.0), mul: 0.8)}.play
*/