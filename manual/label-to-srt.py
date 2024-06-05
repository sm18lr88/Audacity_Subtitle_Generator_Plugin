import sys
import os
from tkinter import Tk, filedialog
from tkinter import messagebox

def convert_to_srt(input_file, output_file):
    def format_time(seconds):
        hours = int(seconds // 3600)
        minutes = int((seconds % 3600) // 60)
        seconds = seconds % 60
        milliseconds = int((seconds - int(seconds)) * 1000)
        return f"{hours:02}:{minutes:02}:{int(seconds):02},{milliseconds:03}"

    with open(input_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    with open(output_file, 'w', encoding='utf-8') as file:
        for i, line in enumerate(lines):
            start, end, text = line.strip().split('\t')
            start_time = format_time(float(start))
            end_time = format_time(float(end))
            file.write(f"{i + 1}\n{start_time} --> {end_time}\n{text}\n\n")

    print(f"File exported successfully to: {output_file}")

def cli_mode():
    if len(sys.argv) != 2:
        print("Usage: label-to-srt.py <path_to_labels_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    if not os.path.isfile(input_file):
        print(f"Error: {input_file} does not exist.")
        sys.exit(1)

    output_file = os.path.splitext(input_file)[0] + '.srt'
    convert_to_srt(input_file, output_file)

def gui_mode():
    def browse_file():
        input_file = filedialog.askopenfilename(filetypes=[("Text files", "*.txt")])
        if input_file:
            output_file = os.path.splitext(input_file)[0] + '.srt'
            try:
                convert_to_srt(input_file, output_file)
                messagebox.showinfo("Success", f"File exported successfully to: {output_file}")
            except Exception as e:
                messagebox.showerror("Error", str(e))

    root = Tk()
    root.title("Label to SRT Converter")
    root.geometry("300x150")
    root.resizable(False, False)

    file_button = filedialog.Button(root, text="Select Label File", command=browse_file)
    file_button.pack(expand=True)

    root.mainloop()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        cli_mode()
    else:
        gui_mode()
