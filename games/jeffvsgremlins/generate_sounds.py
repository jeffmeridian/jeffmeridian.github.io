import wave
import struct
import math
import random
import os

def generate_wav(filename, duration, callback, sample_rate=44100):
    with wave.open(filename, 'w') as f:
        f.setnchannels(1)
        f.setsampwidth(2)
        f.setframerate(sample_rate)
        
        num_frames = int(duration * sample_rate)
        
        for i in range(num_frames):
            t = float(i) / sample_rate
            value = callback(t, i)
            # clamp value between -1.0 and 1.0
            value = max(-1.0, min(1.0, value))
            data = struct.pack('<h', int(value * 32767.0))
            f.writeframesraw(data)

def shoot_sound(t, i):
    # Short white noise burst + descending square wave
    freq = 800 - (t * 4000)
    if freq < 100: freq = 100
    sq = 1.0 if math.sin(2 * math.pi * freq * t) > 0 else -1.0
    noise = random.uniform(-1.0, 1.0)
    env = max(0, 1.0 - (t * 5.0))
    return (sq * 0.5 + noise * 0.5) * env * 0.5

def jump_sound(t, i):
    # Ascending square wave
    freq = 300 + (t * 800)
    sq = 1.0 if math.sin(2 * math.pi * freq * t) > 0 else -1.0
    env = max(0, 1.0 - (t * 4.0))
    return sq * env * 0.5

def pickup_sound(t, i):
    # Two quick ascending sine waves
    if t < 0.1:
        freq = 600 + (t * 2000)
        env = 1.0
    else:
        freq = 800 + ((t-0.1) * 2000)
        env = max(0, 1.0 - ((t-0.1) * 5.0))
    return math.sin(2 * math.pi * freq * t) * env * 0.5

def explosion_sound(t, i):
    # Decaying white noise
    noise = random.uniform(-1.0, 1.0)
    env = max(0, 1.0 - (t * 2.0))
    return noise * env * 0.7

def chaser_sound(t, i):
    # Short, alert-like rising frequency tone
    freq = 600 + (t * 1000)
    sq = 1.0 if math.sin(2 * math.pi * freq * t) > 0 else -1.0
    env = max(0, 1.0 - (t * 10.0))
    return sq * env * 0.3

if __name__ == '__main__':
    os.makedirs('assets', exist_ok=True)
    generate_wav('assets/shoot.wav', 0.2, shoot_sound)
    generate_wav('assets/jump.wav', 0.25, jump_sound)
    generate_wav('assets/pickup.wav', 0.3, pickup_sound)
    generate_wav('assets/explosion.wav', 0.5, explosion_sound)
    generate_wav('assets/chaser.wav', 0.1, chaser_sound)
    print("Sound generation complete!")
