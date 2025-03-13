import grpc
import csv
import sys
import os
import a2f_pb2
import a2f_pb2_grpc

output_csv_path = "C:\\path\\to\\output_keyframes.csv"

#input: audio_file
#input: config_file
#input: ip_port - default 51000
#input: output_csv_path - "C:\\path\\to\\output_keyframes.csv"

#output: out.wav
#output: animation_frames.csv
#output: a2f_input_emotions.csv
#output: a2e_emotion

def send_audio(audio_file, config_file, ip_port, output_csv_path):
    # Validate input files
    if not os.path.exists(audio_file):
        print(f"Error: Audio file '{audio_file}' not found.")
        return
    if not os.path.exists(config_file):
        print(f"Error: Config file '{config_file}' not found.")
        return
    
    # Establish gRPC channel with timeout and error handling
    try:
        channel = grpc.insecure_channel(ip_port)
        stub = a2f_pb2_grpc.A2FServiceStub(channel)
    except grpc.RpcError as e:
        print(f"gRPC Error: {e}")
        return
    
    # Read audio file
    try:
        with open(audio_file, "rb") as f:
            audio_data = f.read()
    except Exception as e:
        print(f"Error reading audio file: {e}")
        return
    
    # Create request and send to A2F Controller
    request = a2f_pb2.A2FRequest(audio=audio_data, config=config_file)
    
    try:
        response = stub.ProcessAudio(request, timeout=10)  # 10s timeout
    except grpc.RpcError as e:
        print(f"gRPC Processing Error: {e}")
        return
    
    # Ensure output directory exists
    output_csv = output_csv_path
    os.makedirs(os.path.dirname(output_csv), exist_ok=True)
    
    # Save keyframes to CSV
    try:
        with open(output_csv, "w", newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(["frame", "blendshape", "value"])
            for frame in response.keyframes:
                writer.writerow([frame.time, frame.name, frame.value])
        print(f"Keyframes saved to {output_csv}")
    except Exception as e:
        print(f"Error writing CSV: {e}")
    
if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python client.py <audio_file> <config_file> <ip:port>")
    else:
        send_audio(sys.argv[1], sys.argv[2], sys.argv[3])