import subprocess


def get_clipboard_content() -> str:
    try:
        # Run the pbpaste command to get clipboard content
        result = subprocess.run(
            [
                "osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack(\"C*\",pack(\"H*\",substr($_,11,-3)))'"
            ],
            check=True,
            shell=True,
            stdout=subprocess.PIPE,
        )
    except:
        result = subprocess.run("pbpaste", stdout=subprocess.PIPE)
    return result.stdout.decode("utf-8")


def main() -> None:
    clipboard_content = get_clipboard_content()
    print("Clipboard Content:\n", clipboard_content)


if __name__ == "__main__":
    main()
