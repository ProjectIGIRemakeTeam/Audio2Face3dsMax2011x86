import grpc
import wave
import time
import csv
import a2f_pb2
import a2f_pb2_grpc

# Configuration
A2F_HOST = "127.0.0.1"
A2F_PORT = "52000"
AUDIO_FILE = "input.wav"
OUTPUT_CSV = "output_blendshapes.csv"

def read_audio_file(filepath):
    """Reads audio file and returns PCM data."""
    with wave.open(filepath, 'rb') as wav_file:
        return wav_file.readframes(wav_file.getnframes())

def send_audio_to_a2f(audio_data):
    """Streams audio data to A2F and receives blendshape animation data."""
    channel = grpc.insecure_channel(f"{A2F_HOST}:{A2F_PORT}")
    stub = a2f_pb2_grpc.Audio2FaceStub(channel)
    
    request = a2f_pb2.AudioRequest(audio_data=audio_data, sample_rate=16000)
    response_stream = stub.ProcessAudio(request)
    
    blendshapes = []
    for response in response_stream:
        timestamp = response.timestamp
        for blendshape in response.blendshapes:
            blendshapes.append((timestamp, blendshape.name, blendshape.value))
    
    return blendshapes

def save_blendshapes_to_csv(blendshapes, output_file):
    """Saves received blendshapes to CSV for 3ds Max plugin."""
    with open(output_file, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["Timestamp", "Blendshape", "Value"])
        writer.writerows(blendshapes)

if __name__ == "__main__":
    print("Reading audio file...")
    audio_data = read_audio_file(AUDIO_FILE)
    print("Sending audio to A2F...")
    blendshapes = send_audio_to_a2f(audio_data)
    print("Saving blendshapes...")
    save_blendshapes_to_csv(blendshapes, OUTPUT_CSV)
    print(f"Done! Blendshapes saved to {OUTPUT_CSV}")
