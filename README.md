# VIPERA (🐍)

The most simple VIPER module generator for Swift projects.


## Install

Just clone or download this repository & run:

```shell
make install
```

## Usage

Just run:

```
vipera MyModule
```

## Requirements

[VIPER](https://github.com/CoreKit/VIPER) - In order to use the global template (v3.0.0)

Install via SPM

```
 .package(url: "https://github.com/CoreKit/VIPER", from: "3.0.0")
```

```swift
@_exported import VIPER
```

## Templates

The global template is located under the `~/.vipera` path. Please don't change it!

You can put your own templates under a local `.viper` folder inside your Xcode project.

VIPERA will use every `*.swift` file as a template source.


## Template variables

You can use the following variables (in the file names too):

- module - given module name (capitalized)
- project - based on `.xcodeproj` or `.xcworkspace` name
- author - based on git config
- date - current date in local short format

eg. {module} -> MyModule


## License

[WTFPL](https://github.com/BinaryBirds/Shell/blob/master/LICENSE) - Do what the fuck you want to.
