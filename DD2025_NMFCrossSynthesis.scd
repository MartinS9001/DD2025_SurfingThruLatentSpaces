Platform.userExtensionDir.openOS; //use this line to open a folder, under Resource and Audio Files throw in some new sounds
s.boot; // boot the server

(
~target = Buffer.readChannel(s,FluidFilesPath("DD2025_Presentation_FluCoMaTarget.wav"),channels:[0]); //change the name here for your target sound
~source = Buffer.readChannel(s,FluidFilesPath("DD2025_Presentation_FluCoMaMechLatch.wav"),channels:[0]); //change the name here for your source sound
~output = Buffer(s);
)



//Processing routine - wait until the command line throw out 'done'
(
Routine{
	~cross = FluidBufNMFCross.process(s,~source,~target,~output,timeSparsity: 70, polyphony: 4, continuity: 70, windowSize: 4096);

	{
		FreeSelfWhenDone.kr(~cross.kr).poll;
	}.play;

	~cross.wait;

	"done".postln;

}.play;
)

~output.play; // play the result here