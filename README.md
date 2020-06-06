# Multi-line commands in Bash

Shell commands in Unix-like systems often take the following format:

```bash
command argument0 --option1 argument1 --option2 argument2
```

Sometimes, when applicable options and arguments are numerous or lengthy,
it is helpful to break a command into multiple lines, using backslashes:

```bash
command argument0 \
    --option1 argument1 \
    --option2 argument2
```

# Limitations in Bash syntax

Bash is unable to correctly interpret a multi-line command if comments are
placed at the end of any line except the last, or
between the lines:

```bash
command argument0 \       # this comment breaks the command
    --option1 argument1 \ # this one too
    --option2 argument2   # only this is okay

command argument0 \
    # this breaks things
    --option1 argument1 \
    # so does this
    --option2 argument2
```

Doing the above causes the comments and subsequent lines to be
interpreted as separate commands, contrary to the programmer's intention.

Relevant post on Stack Overflow: [How to put a line comment for a multi-line command](https://stackoverflow.com/questions/9522631/how-to-put-a-line-comment-for-a-multi-line-command)

Relevant post on Unix & Linux Stack Exchange: [How to comment multi-line commands in shell scripts?](https://unix.stackexchange.com/questions/9804/how-to-comment-multi-line-commands-in-shell-scripts)

Having to append backslashes to every line also seems like an avoidable chore.

# The value of comments in multi-line commands

Many programs have one-letter options that are easy to type but
difficult to read:

```bash
du -chs *     # what do options c, h and s do?
du -c -h -s * # equivalent to above
```

Comments would help readers understand the purpose of the command and options
without having to read the `man` page:

```bash
du     # estimate file space usage
    -c # produce a grand total
    -h # print sizes in human-readable format
    -s # display only a total for each argument
    *
```

Note: backslashes have been omitted, see section below

Comments provide not only helpful information
but also a way to toggle/disable certain options without having to delete lines:

```bash
command argument0
    #--option1 argument1
    --option2 argument2
```

# Proposing an alternative to backslashes

Bash assumes that every line is a separate command, unless
the preceding line is terminated by a backslash.

An alternative to this approach is to assume that
every line is a continuation of the line preceding it, unless
the preceeding line is empty.

# Augmenting Bash syntax

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

# For the shell, in the shell

`ha.sh` is itself a Bash script.
Besides Bash builtins,
it uses only `echo` and `sed`,
core utilities that are shipped with most Unix-like systems.

# Installation and Usage

Inspect [`ha.sh`](https://github.com/joel-ling/ha.sh/blob/master/ha.sh)
and give it a try!

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
ha.sh -t /tmp/example.ha.sh
ha.sh -t /tmp/example.ha.sh > /tmp/example.sh
```

Uninstalling `ha.sh` is as easy as:

```bash
rm -v /usr/local/bin/ha.sh
```
