# Godot iOS Extracted Headers
> Help for faster building Godot iOS plugin

# Why

Rather than compile the headers for each version during building your plugins. I prebuilt em to save some time and also reduce works for my CI.

Download the headers in [release tab](https://github.com/kyoz/godot-ios-extracted-headers/releases)

Or you can download it with wget or curl or whatever through your build script/CI...

# Build it your self

Currenty, i just build some version that people use the most.

To build your own headers file. Clone this repo.

Adjust `SUPPORT_VERSIONS` in `build.env`

Then run:

```sh
./scripts/extract-headers.sh <godot-version>
```

If `godot-version` was not provided, it will build all version in `SUPPORT_VERSIONS`

The extracted headers are packed in zip file in `.release` folder.


