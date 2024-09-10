#!/usr/bin/python

import sys
import argparse
import os
import shutil

targets = {
    ".config/waybar": "/home/damien/.config/waybar",
    ".config/hypr": "/home/damien/.config/hypr",
    ".zshrc": "/home/damien/.zshrc",
    ".vimrc": "/home/damien/.vimrc"
}

def main():
    parser = argparse.ArgumentParser(description='Process command line arguments')
    parser.add_argument('command', choices=['collect'], help='Command to execute')
    parser.add_argument('target', nargs='?', default='all', help='Target for collection (default: all)')
    args = parser.parse_args()

    # Process commands
    if args.command == 'collect':
        if args.target == 'all':
            print("Collecting all configurations...")
        else:
            print(f"Collecting {args.target} configurations...")
        collect_configs(args.target)
    else:
        print("Invalid command. Please use 'dotfile collect' or 'dotfile collect <target>'.")

def collect_configs(target):
    if target == 'all':
        for name, path in targets.items():
            collect_single_config(name, path)
    elif target in targets:
        collect_single_config(target, targets[target])
    else:
        print(f"Error: Unknown target '{target}'")

def collect_single_config(name, source_path):
    if not os.path.exists(source_path):
        print(f"Error: Source path for {name} does not exist: {source_path}")
        return

    destination_path = os.path.join(os.getcwd(), name)
    
    if os.path.isdir(source_path):
        shutil.copytree(source_path, destination_path, dirs_exist_ok=True)
    else:
        shutil.copy2(source_path, destination_path)
    
    print(f"Collected {name} configuration from {source_path} to {destination_path}")

if __name__ == '__main__':
    main()
