#set -e # exit on error

# Setup
script_path="$(cd "$(dirname "$0")" && pwd -P)"
backup_root=$script_path

# Config
remote_drive="/Users/nick/Dropbox"
remote_folder="$remote_drive/_backup"
external_drive="/Volumes/T7"
drive_folder="$external_drive/_backup"

# Flags
# Use --dry-run for preview
flags="--exclude=node_modules --exclude=bin --exclude=venv --exclude=temp
--exclude=tmp --exclude=_tmp --exclude=.cache --exclude=static_dist
--exclude=__pycache__ --exclude=postgres --exclude=.DS_Store"

mflags="$flags --exclude=_projects --exclude=_lib"

#
# Simple file pass for remote_folder
#
echo "[backup] Backing up files to remote source: $remote_folder"

if [ -d "$remote_drive" ]; then

  mkdir -p $remote_folder

  # cp $backup_root/backup.sh $remote_folder/backup.sh

  rsync -avrL $mflags ~/docs/ $remote_folder/docs
  rsync -avrL $mflags ~/ideas/ $remote_folder/ideas
  #rsync -avrL $mflags ~/dev/ $remote_folder/dev
else
  echo "\n[backup] Remote folder does not exist!"
fi

#
# Extended file pass for drive_folder
#
if mount | grep -q "$external_drive"; then
  echo "\n[backup] Drive connected! Backing up files to drive: $drive_folder"

  mkdir -p $drive_folder

  # cp $backup_root/backup.sh $drive_folder/backup.sh

  rsync -avrL $flags ~/docs/ $drive_folder/docs
  rsync -avrL $flags ~/ideas/ $drive_folder/ideas
  rsync -avrL $flags ~/dev/ $drive_folder/dev
  mkdir -p $drive_folder/music
  rsync -avrL $flags ~/Music/Logic/ $drive_folder/music/Logic
else
  echo "\n[backup] Drive not connected!"
fi

echo "Done! ✨"
