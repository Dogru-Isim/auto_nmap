Every time I do an nmap scan, I run three commands;

```console
$ sudo nmap -v -T4 $ip                                                # Query the top 1000 ports
$ sudo nmap -T4 $ip -p $open_ports -sC -sV -oN nmap/initial.lst      # Scan the open ports with nmap's default scripts - Save to `nmap/initial.lst`
$ sudo nmap -v -T4 $ip -p- -oN nmap/allports.lst                      # Query all open ports - save to `nmap/allports.lst`
$ sudo nmap -T4 $ip -p $all_ports -sC -sV -oN nmap/comprehensive.lst  # Scan all the ports with nmap's default scripts - Save to `nmap/comprehensive.lst`
```

I don't really like automation tools since I like to think before I run something, but there is actually no thinking in these 4 commands.

`If you're doing your thing like a robot, then let a robot do your thing.`
