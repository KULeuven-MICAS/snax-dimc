import os

# Define the base directory
base_dir = 'rtl'

# Initialize lists to store file paths
submodule_files = []
common_files = []

# Traverse the base directory
for root, dirs, files in os.walk(base_dir):
    if root == base_dir:
        # Iterate over all top-level directories inside rtl/
        for dir_name in dirs:
            dir_path = os.path.join(base_dir, dir_name)

            # Check if there's a src folder inside this directory
            if 'src' in os.listdir(dir_path):
                src_dir_path = os.path.join(dir_path, 'src')

                # Collect all files in the src directory (sub-modules)
                for src_root, _, src_files in os.walk(src_dir_path):
                    for src_file in src_files:
                        submodule_files.append(os.path.join(src_root, src_file).replace('\\', '/'))

            # Collect all files in the main directory (excluding src)
            for file in os.listdir(dir_path):
                file_path = os.path.join(dir_path, file).replace('\\', '/')
                if os.path.isfile(file_path) and file != 'src':
                    common_files.append(file_path)

# Start constructing the YAML content
yaml_content = '''package:
  name: dimc
  authors:
    - "Ce Ma <ce.ma@esat.kuleuven.be>"

sources:
  - target: dimc
    files:
'''

# Add submodule files (files in 'src' directories)
if submodule_files:
    yaml_content += '      #---------------------------\n'
    yaml_content += '      # Sub-Modules\n'
    yaml_content += '      #---------------------------\n'
    for file in submodule_files:
        yaml_content += f'      - {file}\n'

# Add common files (files outside 'src' directories)
if common_files:
    yaml_content += '      #---------------------------\n'
    yaml_content += '      # Common Modules\n'
    yaml_content += '      #---------------------------\n'
    for file in common_files:
        yaml_content += f'      - {file}\n'

# Write the collected data to a YAML file
yaml_file = 'Bender.yml'
with open(yaml_file, 'w') as file:
    file.write(yaml_content)

print(f"YAML file '{yaml_file}' has been created.")