# README

How to use this system to turn obsidian vaults into books.

## Create book directory from obsidian vault

```sh
cat toc.txt | ./obsidian-to-book -5 -i $OBSIDIAN/We
```

## Create book pdf from book directory

```sh
make
```
