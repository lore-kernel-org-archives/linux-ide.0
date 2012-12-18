From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Crash with Z77 chipset
Date: Mon, 17 Dec 2012 21:41:23 -0600
Message-ID: <50CFE5E3.9080003@gmail.com>
References: <50CF5143.5020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38867 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2LRDl0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Dec 2012 22:41:26 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so189942iea.7
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2012 19:41:26 -0800 (PST)
In-Reply-To: <50CF5143.5020207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrius Narbutas <andrius.narbutas@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/17/2012 11:07 AM, Andrius Narbutas wrote:
> Hello,
> (probably a bit long mail, but i will try to describe what i did or tried)
> using ASRock Z77 Pro3 motherboard with Z77 chipset, 4xSATA WDC
> WD1002FAEX-00Z3A0 drives, Debian Linux (basic installation, no X or
> other services).
> Problem: any intense I/O to disk causes system to crash. Easiest method
> (for me) to reproduce (100% so far) problem - just do mkfs.ext2
> /dev/sdb3 (any failsystem will work, the same goes for `dd if=/dev/zero
> of=/dev/sdb bs=1M`, just a bit slower). Before crash inode creation
> slows down, for ~10 seconds, then stops at all (and crash immediately).
> What i tried:

My first thought would be that a power problem is a possibility. These 
kinds of setups with multiple HDs in a RAID setup are known to cause 
these issues in some cases if the PSU isn't adequate. It tends to show 
up in situations like this where all hard drives are maxed out with disk 
activity and they all pull their peak power at the same time - if the 
voltage dips too low you can get problems with the SATA link dropping, etc.

You might want to try running with only one or two disks powered up, or 
try moving disks to different power cables, etc. to see if that affects 
the problem.

>   - first i noticed that system will crash with default debian kernel
> (2.6.32-5-amd64). This is only one kernel which writes something to
> message log, and crashes when writing inodes at count ~3250/7464. It
> writes info to /var/log/messages and console, system becomes
> unresponsive (kernel.panic from sysctl does not reboot system, same goes
> for software watchdog - you need to "manually" reboot system)
>   - i recompiled current stable kernel (3.6.10) with
> CONFIG_DETECT_HUNG_TASK=y and CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y and
> re-tested. System hangs when writing inodes at ~3450/7464, no info on
> screen or syslog. System could be rebooted with `echo b >
> /proc/sysrq-trigger` on another console, console is responsive, but any
> disk access will hung console. Sometimes (rarely) system becomes
> unresponsive, and reboots after timeout
>   - i recompiled todays git kernel, recompiled with the same parameters.
> It hangs ~6400/7464 (note - goes much further than previous versions),
> but completely - does not reboot itself, does not respond to ping, only
> poweroff helps. Nothing in syslog, photo from screen will be attached
> with logs in next post (can't be scrolled up/down - so no info what
> happened earlier)
>
> Observations:
>   - system could be "alive" and working with low disk activity for long
> time (at least, more than week). But enough to do some disk I/O - crash
> (for example, copying bzip'ed kernel image from one place to another is
> enough to trigger crash)
>   - disk type does not matter. I tried to attach Hitachi HDS722020ALA330
> disk instead of WD - the same (i would say, it crashed even earlier, but
> didn't measured exactly)
>   - SATA cables are replaced, system could run prime95 torture test for
> several hours - so i could say that RAM/CPU isn't a problem here
>   - could be crashed with activity on any disk. I tried to make RAID10,
> LVM on top - crash; disassembled md array, tested with disk activity to
> _all_ disks separately - any disk activity could crash system
>   - tested all "quick" solutions i could find on internet, including
> module params "acpi=off noapic", "libata.noacpi=1",
> "libata.force=1.5Gbps", some other woodoo magic like disabling write
> cache or disabling NCQ - no difference (probably tested something more,
> like 'norst', i forgot already)
> Attached zip'ed logs - one from 2.6 kernel (with trace), another from
> today's git kernel (entire log from boot to crash, next line in log
> starts again with rsyslog...).
> Also, screen images from "dead" system (nothing in logs, and i can't
> scroll up):
>   - todays git kernel: http://i49.tinypic.com/js0xl2.jpg
>   - 3.6.10 on shutdown (crashed): http://i47.tinypic.com/2exv4fr.jpg
>
> Because this problem is easily reproducible - i could try to get as much
> information as i can, if you ask. Minor problem - i do not have physical
> access to system, so if tests should be done with latest kernel (which
> hangs completely and needs access to system for restart) - i can do
> tests only at day, when others could access and reboot system.
>
> Thanks.
>

