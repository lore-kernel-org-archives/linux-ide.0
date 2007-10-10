From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: smartd causing SATA timeouts on sleeping drives
Date: Wed, 10 Oct 2007 14:46:39 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710101443300.4797@trinity.phys.uwm.edu>
References: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.phys.uwm.edu ([129.89.57.159]:43630 "EHLO
	trinity.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756594AbXJJTqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 15:46:42 -0400
In-Reply-To: <76366b180710051838h11c63c38o9a4248309ff9ee7d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Andrew,

I forgot to say 'thank you' for tracking this down.

Thank you!

Cheers,
 	Bruce


On Fri, 5 Oct 2007, Andrew Paprocki wrote:

> Tejun/Bruce,
>
> I tracked down the source of timeouts I have been frequently getting.
> It appears smartd is not properly handling drives that are spun down
> by the BIOS ACPI settings. I have SATA timeouts which occur every half
> hour (the default -i 1800 in smartd) that do not occur when smartd is
> not running. The drives smartd is configured to look at have a sleep
> time configured in the BIOS. When the drives are asleep, I get a soft
> reset every half hour as smartd attempts to access the drives. While
> in this state, smartd also reports bad state to syslog (e.g.
> temperature changes to 200C). Just for comparison, hddtemp knows the
> drives are sleeping:
>
> # hddtemp /dev/sda
> /dev/sda: Hitachi HDS721010KLA330                 : drive is sleeping
> # ls /storage
> ... wakes up the drives ...
> # hddtemp /dev/sda
> /dev/sda: Hitachi HDS721010KLA330                 :  29 C or  F
>
> I'm pasting the example cmd / timeout error / soft reset below. Also,
> I'm pasting the invalid settings which smartd detects when in this
> state. What needs to change for smartd to recognize drives are
> sleeping and either not perform its checks, or forcefully wake them up
> to perform them? (Should that be a configuration parameter in smartd?)
>
> Thanks,
> -Andrew
>
> # uname -a
> Linux (none) 2.6.22.6 #5 Mon Sep 10 02:15:22 EDT 2007 i586 unknown
> (Using sata_sil on 3114 chips)
>
> # smartctl -V
> smartmontools release 5.38 dated 2006/12/20 at 20:37:59 UTC
> ...
> smartctl compile dated Sep 17 2007 at 13:47:25
> (repository code checked out on Sep 17th)
>
> # cat /var/run/smartd.conf
> /dev/sda -d ata -a -S on -s (S/../.././02|L/../../6/03)
> /dev/sdb -d ata -a -S on -s (S/../.././02|L/../../6/03)
>
> What happens every 30 minutes when drives are sleeping:
>
> Oct  6 01:05:48 (none) user.err kernel: ata2.00: exception Emask 0x0
> SAct 0x0 SErr 0x0 action 0x2 frozen
> Oct  6 01:05:48 (none) user.err kernel: ata2.00: cmd
> b0/da:00:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
> Oct  6 01:05:48 (none) user.warn kernel:          res
> 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
> Oct  6 01:05:53 (none) user.warn kernel: ata2: port is slow to
> respond, please be patient (Status 0xd0)
> Oct  6 01:05:55 (none) user.info kernel: ata2: soft resetting port
> Oct  6 01:05:56 (none) user.info kernel: ata2: SATA link up 1.5 Gbps
> (SStatus 113 SControl 310)
> Oct  6 01:05:56 (none) user.info kernel: ata2.00: configured for UDMA/100
> Oct  6 01:05:56 (none) user.info kernel: ata2: EH complete
> Oct  6 01:05:56 (none) user.notice kernel: sd 1:0:0:0: [sdb]
> 1953525168 512-byte hardware sectors (1000205 MB)
> Oct  6 01:05:56 (none) user.notice kernel: sd 1:0:0:0: [sdb] Write
> Protect is off
> Oct  6 01:05:56 (none) user.debug kernel: sd 1:0:0:0: [sdb] Mode
> Sense: 00 3a 00 00
> Oct  6 01:05:56 (none) user.notice kernel: sd 1:0:0:0: [sdb] Write
> cache: enabled, read cache: enabled, doesn't support DPO or FUA
>
> Invalid attribute values:
>
> Oct  2 22:35:21 (none) daemon.info smartd[585]: Device: /dev/sda,
> SMART Prefailure Attribute: 7 Seek_Error_Rate changed from 87 to 86
> Oct  2 23:35:21 (none) daemon.info smartd[585]: Device: /dev/sda,
> SMART Prefailure Attribute: 7 Seek_Error_Rate changed from 86 to 85
> Oct  5 20:05:56 (none) daemon.info smartd[585]: Device: /dev/sdb,
> SMART Prefailure Attribute: 3 Spin_Up_Time changed from 84 to 85
> Oct  6 01:05:38 (none) daemon.info smartd[585]: Device: /dev/sda,
> SMART Usage Attribute: 194 Temperature_Celsius changed from 200 to 206
> Oct  6 01:05:56 (none) daemon.info smartd[585]: Device: /dev/sdb,
> SMART Usage Attribute: 194 Temperature_Celsius changed from 193 to 200
>
> Once the drives are started up, those values report:
>
>  3 Spin_Up_Time            0x0007   085   085   024    Pre-fail
> Always       -       821 (Average 820)
>  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail
> Always       -       0
> 194 Temperature_Celsius     0x0002   193   193   000    Old_age
> Always       -       31 (Lifetime Min/Max 24/67)
>
