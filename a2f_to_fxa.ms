import csv
import json
import os

# Define a mapping of A2F blendshapes to FaceFX bones
BLENDSHAPE_TO_BONE_MAP = {
    "jawOpen": "jaw",
    "browInnerUp": "brow_inner",
    "browOuterUpLeft": "brow_outer_L",
    "browOuterUpRight": "brow_outer_R",
    "eyeBlinkLeft": "eye_blink_L",
    "eyeBlinkRight": "eye_blink_R",
    "mouthSmileLeft": "mouth_smile_L",
    "mouthSmileRight": "mouth_smile_R",
    # Add more mappings as needed
}

def read_a2f_csv(csv_path):
    """Reads an Audio2Face CSV and extracts blendshape keyframe data."""
    keyframes = {}
    
    with open(csv_path, 'r') as f:
        reader = csv.reader(f)
        next(reader)  # Skip header
        
        for row in reader:
            frame, blendshape, value = int(row[0]), row[1], float(row[2])
            
            if blendshape in BLENDSHAPE_TO_BONE_MAP:
                bone = BLENDSHAPE_TO_BONE_MAP[blendshape]
                if frame not in keyframes:
                    keyframes[frame] = {}
                keyframes[frame][bone] = value
    
    return keyframes

def convert_to_facefx_format(keyframes):
    """Converts the parsed keyframes into FaceFX-compatible JSON."""
    facefx_animation = {"animation": []}
    
    for frame, bones in keyframes.items():
        frame_data = {"frame": frame, "bones": []}
        
        for bone, value in bones.items():
            frame_data["bones"].append({
                "bone": bone,
                "rotation": [0, 0, value * 30],  # Example: Mapping blendshape value to bone rotation
                "position": [0, 0, 0]
            })
        
        facefx_animation["animation"].append(frame_data)
    
    return facefx_animation

def save_facefx_json(output_path, facefx_animation):
    """Saves the converted animation as a JSON file for FaceFX import."""
    with open(output_path, 'w') as f:
        json.dump(facefx_animation, f, indent=4)
    print(f"FaceFX animation saved to {output_path}")

if __name__ == "__main__":
    a2f_csv_path = "a2f_output.csv"  # Change this to the actual CSV path
    facefx_output_path = "facefx_animation.json"
    
    keyframes = read_a2f_csv(a2f_csv_path)
    facefx_animation = convert_to_facefx_format(keyframes)
    save_facefx_json(facefx_output_path, facefx_animation)
