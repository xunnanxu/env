import subprocess
import sys


def get_clipboard_content() -> str:
    # opt + \ : left double angle quotation mark 
    # shift + opt \ : right double angle quotation mark
    try:
        # Run the pbpaste command to get clipboard content
        result = subprocess.run(
            [
                "bash",
                "-c",
                "set -o pipefail; osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack(\"C*\",pack(\"H*\",substr($_,11,-3)))'",
            ],
            capture_output=True,
            text=True,
            check=True,
        )
    except subprocess.CalledProcessError as e:
        print(
            f"Unable to read clipboard as HTML: {e.stderr}. Fall back to text mode.",
            flush=True,
        )
        result = subprocess.run("pbpaste", capture_output=True, text=True)
    return result.stdout


def string_to_hex(string) -> str:
    hex_values = [f"{ord(char):02x}" for char in string]
    return ''.join(hex_values)


def copy_to_clipboard(s: str) -> None:
    hex = string_to_hex(s)
    subprocess.run([f"osascript -e 'set the clipboard to «data HTML{hex}»'"], check=True, shell=True)

def main() -> None:
    clipboard_content = get_clipboard_content()
    print("Clipboard Content:\n", clipboard_content)
    # copy_to_clipboard(clipboard_content)


if __name__ == "__main__":
    main()
