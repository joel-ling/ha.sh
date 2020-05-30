# Can we have

## Better comments in Bash scripts

In [How to put a line comment for a multi-line command](https://stackoverflow.com/questions/9522631/how-to-put-a-line-comment-for-a-multi-line-command),
Peter Lee asked Stack Overflow how one might
"add a comment for each line in a multiline command", like this:

```bash
CommandName InputFiles      \ # This is the comment for the 1st line
            --option1 arg1  \ # This is the comment for the 2nd line
            --option2 arg2    # This is the comment for the 3nd line
```

In [How to comment multi-line commands in shell scripts?](https://unix.stackexchange.com/questions/9804/how-to-comment-multi-line-commands-in-shell-scripts),
user4518 asked Unix & Linux Stack Exchange if there is
"an easy way to comment [out] lines" in "long, switch-heavy commands":

```bash
command \
  #--bad-switch \
  --good-switch \
```

## Better line breaks in Bash scripts

Appending backslashes to every line in a multi-line command is troublesome;
forgetting to do that is even more so!

# Yes we can

`ha.sh` gives the ability to execute shell scripts with the following syntax:

```bash
command         # look Ma, no backslashes!
    #--switch   # use comments to turn switches on and off
    -f          # explain non-descriptive options

# remember to leave an empty line between commands

command argument0
    # comments can appear between lines of a command
    --option1 argument1
    # as long as the lines are contiguous
    --option2 argument2
```

`ha.sh` is itself a Bash script.
Besides Bash builtins,
it uses only `echo` and `sed`,
utilities that come pre-installed with most Unix-like systems.

## Installation and Usage

Inspect `ha.sh` and give it a try!

Download `ha.sh` to `/usr/local/bin`:

```bash
sudo curl https://raw.githubusercontent.com/joel-ling/ha.sh/master/ha.sh \
    -o /usr/local/bin/ha.sh 
```

Make it executable:

```bash
sudo chmod 755 /usr/local/bin/ha.sh
```

Check that `/usr/local/bin` is in $PATH:

```bash
echo $PATH | grep /usr/local/bin
```

Execute a shell script written in `ha.sh` syntax:

```bash
ha.sh /tmp/example.ha.sh
```

Translate to vanilla Bash without executing:

```bash
ha.sh -t /tmp/example.ha.sh > /tmp/example.sh
```

Uninstalling `ha.sh` is as easy as:

```bash
rm -v /usr/local/bin/ha.sh
```
