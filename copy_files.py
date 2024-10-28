import os
import shutil
from pathlib import Path

# Define the destination directory
dest_dir = Path("copy_dir")
# Create the destination directory if it doesn't exist
dest_dir.mkdir(exist_ok=True)

# List of folders you're working with
folders = ["dimc_macro", "qkt_macro_handler_hub", "qkv_macro_handler_hub", "snax_req_handler", 
           "qkt_macro_handler_unit", "qkv_macro_handler_unit", "snax_interfaces", "streamer_handler"]

# Loop through each folder and copy the required files and folders
for folder in folders:
    # Define the source directory
    src_dir = Path(folder) / "target_all_PIN"
    
    # Handle different RTL file name for dimc_macro
    if folder == "dimc_macro":
        rtl_file = src_dir / "dimc_detail_model_rtl.v"
    else:
        rtl_file = src_dir / f"{folder}_rtl.v"
    
    # Define the source v_rtl and src folders
    v_rtl_dir = src_dir / "v_rtl"
    src_dir_folder = src_dir / "src"

    # Create a destination subdirectory for each module under copy_dir
    module_dest_dir = dest_dir / folder
    module_dest_dir.mkdir(exist_ok=True)

    # Copy the RTL file if it exists
    if rtl_file.is_file():
        shutil.copy(rtl_file, module_dest_dir)
    else:
        print(f"RTL file not found: {rtl_file}")
    
    # Copy the v_rtl directory if it exists
    if v_rtl_dir.is_dir():
        shutil.copytree(v_rtl_dir, module_dest_dir / "v_rtl", dirs_exist_ok=True)
    else:
        print(f"v_rtl directory not found: {v_rtl_dir}")
    
    # Copy the src directory if it exists
    if src_dir_folder.is_dir():
        shutil.copytree(src_dir_folder, module_dest_dir / "src", dirs_exist_ok=True)
    else:
        print(f"src directory not found: {src_dir_folder}")

print(f"Files and directories copied to {dest_dir}")