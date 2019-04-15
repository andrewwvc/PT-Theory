#include <cmath>
#include <fstream>
#include <iostream>
//#include <windows.h>
using namespace std;

//Template is original code written by Michael Thomas Greer
namespace little_endian_io
{
	template <typename Word>
	std::ostream& write_word(std::ostream& outs, Word value, unsigned size = sizeof(Word))
	{
		for (; size; --size, value >>= 8)
			outs.put(static_cast <char> (value & 0xFF));
		return outs;
	}
}
using namespace little_endian_io;

// Write the audio samples
// (We'll generate a single C4 note with a sine wave, fading from left to right)
const double tau = 6.283185307179586476925286766559;
const double max_amplitude = 32760;  // "volume"
const double hz = 44100;    // samples per second
const double equal_temp_mult = 1.0594630943592952646;

const double e0 = 1;
const double e1 = equal_temp_mult;
const double e2 = e1*equal_temp_mult;
const double e3 = e2*equal_temp_mult;
const double e4 = e2*e2;
const double e5 = e4*equal_temp_mult;
const double e6 = e5*equal_temp_mult;
const double e7 = e6*equal_temp_mult;
const double e8 = e4*e4;
const double e9 = e4*e5;
const double e10 = e5*e5;
const double e11 = e10*equal_temp_mult;
const double e12 = 2;

const double equal_temperment[] = {e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12};

const double *chromatic_temperment = equal_temperment;

const double m2 = chromatic_temperment[1];
const double M2 = chromatic_temperment[2];
const double m3 = chromatic_temperment[3];
const double M3 = chromatic_temperment[4];
const double P4 = chromatic_temperment[5];
const double TT = chromatic_temperment[6];
const double P5 = chromatic_temperment[7];
const double m6 = chromatic_temperment[8];
const double M6 = chromatic_temperment[9];
const double m7 = chromatic_temperment[10];
const double M7 = chromatic_temperment[11];
const double OCT = chromatic_temperment[12];

//stream: Pass the stream to be written to
//tones: An array of tones that make up  the chord (in Hz) to be passed in
//volume: A series of values from 0.0 to 1.0 if present. Can be NULL, in which case volumes default to 1.0
//time: Length of the tone in seconds
//master_volume: A value from 0.0 to 1.0 if present, that scales and limits the max volume of the chord
void writeChord(ofstream &stream, const double tones[], const double volumes[], int numberOfTones, double time, double master_volume = 0.25, double attack = 0.1, double decay = 0.1)
{
	double *toneX = new double[numberOfTones];
	double *volumeX = new double[numberOfTones];

	if (master_volume > 1.0)
		master_volume = max_amplitude;
	else
		master_volume = master_volume * max_amplitude;

	if (volumes)
	{
		for (int ii = 0; ii < numberOfTones; ++ii)
		{
			toneX[ii] = tau*tones[ii] / hz;

			if (volumes[ii] > 1.0)
				volumeX[ii] = 1.0;
			else
				volumeX[ii] = volumes[ii];
		}
	}
	else
	{
		for (int ii = 0; ii < numberOfTones; ++ii)
		{
			toneX[ii] = tau*tones[ii] / hz;

			volumeX[ii] = 1.0;
		}
	}

	int N = hz * time;  // total number of samples
	int attackPoint;
	int decayPoint;
	if (decay > time)
		decayPoint = 0;
	else
		decayPoint = N - hz * decay;

	if (attack > time - decay)
		attackPoint = decayPoint;
	else
		attackPoint = hz * attack;

	for (int n = 0; n < attackPoint; n++)
	{
		double value = 0;
		for (int ii = 0; ii < numberOfTones; ++ii)
		{
			value += sin(toneX[ii] * n) * volumeX[ii] * n / (double)attackPoint;
		}

		write_word(stream, (int)(master_volume*value), 2);
		write_word(stream, (int)(master_volume*value), 2);
	}

	for (int n = attackPoint; n < decayPoint; n++)
	{
		double value = 0;
		for (int ii = 0; ii < numberOfTones; ++ii)
		{
			value += sin(toneX[ii] * n) * volumeX[ii];
		}

		write_word(stream, (int)(master_volume*value), 2);
		write_word(stream, (int)(master_volume*value), 2);
	}

	for (int n = decayPoint; n < N; n++)
	{
		double value = 0;
		for (int ii = 0; ii < numberOfTones; ++ii)
		{
			value += sin(toneX[ii] * n) * volumeX[ii] * (N - n) / (double)(N - decayPoint);
		}

		write_word(stream, (int)(master_volume*value), 2);
		write_word(stream, (int)(master_volume*value), 2);
	}

	delete[] toneX;
	delete[] volumeX;
}

//Function is nodified from original code written by Michael Thomas Greer
int main()
{
	ofstream f("example.wav", ios::binary);

	// Write the file headers
	f << "RIFF----WAVEfmt ";     // (chunk size to be filled in later)
	write_word(f, 16, 4);  // no extension data
	write_word(f, 1, 2);  // PCM - integer samples
	write_word(f, 2, 2);  // two channels (stereo file)
	write_word(f, 44100, 4);  // samples per second (Hz)
	write_word(f, 176400, 4);  // (Sample Rate * BitsPerSample * Channels) / 8
	write_word(f, 4, 2);  // data block size (size of two integer samples, one for each channel, in bytes)
	write_word(f, 16, 2);  // number of bits per sample (use a multiple of 8)

	// Write the data chunk header
	size_t data_chunk_pos = f.tellp();
	f << "data----";  // (chunk size to be filled in later)

	//typedef enum chromatic {U, m2, M2, m3, P4, TT, P5, m6, M6, m7, M7, OCT};

	
	double A = 220.0;  // middle A
	double C = A*e3;
	double cycle = tau * A / hz;
	double cycle2 = cycle*OCT*M7;
	double seconds = 1.0;      // time
	double volume = max_amplitude / 4.0;

	int N = hz * seconds;  // total number of samples
	for (int n = 0; n < N; n++)
	{
		double value = sin(cycle * n)/1.5 +sin(cycle2 * n)/3;
		write_word(f, (int)(volume  * value), 2);
		write_word(f, (int)(volume  * value), 2);
	}

	cycle2 = cycle*m3;
	N = hz * seconds;  // total number of samples
	for (int n = 0; n < N; n++)
	{
		double value = sin(cycle * n) / 1.5 + sin(cycle2 * n) / 3;
		write_word(f, (int)(volume  * value), 2);
		write_word(f, (int)(volume  * value), 2);
	}

	double freqs[] = { C, C*M3, C*P5 };
	writeChord(f, freqs, NULL, 3, 2.0, 0.25, 0.2, 0.6);

	//double freqs2[] = { C };
	writeChord(f, NULL, NULL, 0, 1.0);

	// (We'll need the final file size to fix the chunk sizes above)
	size_t file_length = f.tellp();

	// Fix the data chunk header to contain the data size
	f.seekp(data_chunk_pos + 4);
	write_word(f, file_length - data_chunk_pos + 8);

	// Fix the file header to contain the proper RIFF chunk size, which is (file size - 8) bytes
	f.seekp(0 + 4);
	write_word(f, file_length - 8, 4);

	f.close();

	//PlaySound(L"example.wav", NULL, SND_FILENAME | SND_SYNC);

	return 0;
}