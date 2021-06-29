from __future__ import unicode_literals
import os
from os import listdir
import subprocess


def download_playlist(url, output_folder="", start_date=None, end_date=None, max_videos=0):
    """Downloads videos from a Youtube playlist.

    Parameters
    ----------
    url : str
        Playlist URL.
    output_folder
        Folder to save the downloaded videos in.
    start_date : str
        Only download videos uploaded on and after this date. Date format: YYYYMMDD.
    end_date : str
        Only download videos uploaded until this date. Date format: YYYYMMDD.
    max_videos : int
        Stop after downloading max_videos.

    """

    calls = ["youtube-dl", "-x", "--audio-format", "wav",
             "--write-auto-sub", "--convert-subs=vtt",
             "--yes-playlist"]

    if start_date is not None:
        calls.append(f"--dateafter {start_date}")
    if end_date is not None:
        calls.append(f"--datebefore {end_date}")
    if max_videos > 0:
        calls.append(f"--max-downloads {max_videos}")

    file_name = output_folder + "/" + "%(channel)s_%(upload_date)s_%(title)s.%(ext)s"
    calls.append("-o " + file_name)

    calls.append(url)

    subprocess.call(calls)


def ensure_correct_naming(folder_path):
    """Renames (downloaded) files to remove problematic characters.

    """

    all_file_names = listdir(folder_path)

    for file_name in all_file_names:
        if file_name[-4:] == ".vtt" or file_name[-4:] == ".wav" or file_name[-10:] == ".info.json":
            new_file_name = file_name.replace(" ", "_")
            new_file_name = new_file_name.replace(":", "_")

            old_file_name = os.path.join(folder_path, file_name)
            new_file_name = os.path.join(folder_path, new_file_name)

            os.rename(old_file_name, new_file_name)
