# Subtitle Generator Plugin for Audacity

Easily convert label tracks into subtitles (SRT or LRC).

<sub>I highly recommend checking out [Intel's AI plugin for Audacity](https://github.com/intel/openvino-plugins-ai-audacity), which can quickly and efficiently create the transcription.</sub>

<image src='https://github.com/sm18lr88/Audacity_Subtitle_Generator_Plugin/assets/64564447/0a7fa7f5-0afd-4934-99f0-ea4c75a15810' width='600'>

## Installation

1. Download `Subtitle_Generator.ny`.
2. In Audacity, navigate to `Tools` > `Nyquist Plug-in Installer…`
3. Select the downloaded `Subtitle_Generator.ny` file and open it to install.

Or:

1. Place the `Subtitle_Generator.ny` in your Audacity installation folder, in the Plug-Ins folder
2. In Audacity: `Tools` > `Plugin Manager` > `Rescan`
3. That should detect and automatically enable the plugin.

## Usage

1. Open your project in Audacity and ensure you have a label track.
2. Go to `Tools` (or `Analyze` depending on your Audacity version).
3. Select `Subtitle Generator`.
4. Choose a filename and format (SRT or LRC) for your subtitles.
5. Click `Apply`.

### Tip:

To view subtitles for audio files in VLC, start playing the MP3 file in VLC then go to `Audio` > `Visualizations` > `Spectrometer`. Now you have a "visual" and are able to see the subtitles.

## Credit:

- Some unknown guy named "Cheng Huaiyu" created a [post](https://forum.audacityteam.org/t/convert-label-text-to-lrc-file/55495/45) years ago in Audacity's forum, and the code was compiled throughout the thread. So I put it together and shared it here.

---

#### License:
- According to "Cheng Huaiyu", it's released under terms of the GNU General Public License version 2.
