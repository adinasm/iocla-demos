# Commands

Run them either on an executable or on an object file.

## Hexdump
```
xxd main
```

## ELF header
```
readelf -h main
```

## Sections
```
readelf -S main
```

## Disassemby
```
objdump -d -M intel main
```
You can also run this in order to get a nicer output:
```
objdump -d -M intel main | less
```

## Symbols
```
nm main
```
