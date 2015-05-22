# Experiments with packaging of Ruby apps

## The "app"

The demo app is a CLI app that uses liquid templating language to render an
hello world kind of message.

```
./liquid-previewer Bob
```

ouputs

```
hi Bob
```

### Packaging

To package this app for all platforms (`linux-x86`, `linux-x86_64`, `osx` and `win32`), run

```
rake package
```

See

```
rake -T
```

if you want to package for a single platform

Packages are created into `pkg` folder

## Package usage

Your end user just need to download your package, unzip or untar it and then
directly run the binary file.

**No need to setup Ruby, no need to setup bundler, no need to bundle install**,
it is all packaged for you !
