From: Gene Heskett <gene.heskett@gmail.com>
Subject: Drive breakdown or bug?
Date: Sun, 16 Nov 2008 13:25:57 -0500
Message-ID: <200811161325.57557.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:35724 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYKPS0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 13:26:01 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1088561qwe.37
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 10:26:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings;

I have this drive as /boot and / on my system:
Device Model:     MAXTOR STM3500630A
Serial Number:    9QG7T0CJ
Firmware Version: 3.AAE
User Capacity:    500,107,862,016 bytes
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Sun Nov 16 06:56:45 2008 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

System is quad core phenom on an ASUS M2N-SLI Deluxe board, kernel running 
ATM is 2.6.27.6.

The backup program amanda failed last night on a largish dle and has several 
times in the past.  Failure was a 'holding disk read error' on a block that 
should be quite early in the drives mapping.  But badblocks is complaining
about blocks that are 2/3rds of the way to the spindle.

My logs are loaded with resets, and offline messages that don't seem to be 
truthful as the system eventually recovers.  Sample log outputs:

Nov 16 12:55:11 coyote kernel: [57888.336245] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
Nov 16 12:55:11 coyote kernel: [57888.336384] ata1.00: BMDMA stat 0x65
Nov 16 12:55:11 coyote kernel: [57888.336418] ata1.00: cmd 25/00:08:18:c6:ba/00:00:2a:00:00/e0 tag 0 dma 4096 in
Nov 16 12:55:11 coyote kernel: [57888.336419]          res 51/40:08:18:c6:ba/40:00:2a:00:00/e0 Emask 0x9 (media error)
Nov 16 12:55:11 coyote kernel: [57888.336473] ata1.00: status: { DRDY ERR }
Nov 16 12:55:11 coyote kernel: [57888.336498] ata1.00: error: { UNC }
Nov 16 12:55:11 coyote kernel: [57888.345576] ata1.00: configured for UDMA/33
Nov 16 12:55:11 coyote kernel: [57888.345616] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
Nov 16 12:55:11 coyote kernel: [57888.345651] sd 0:0:0:0: [sda] Sense Key : 0x3 [current] [descriptor]
Nov 16 12:55:11 coyote kernel: [57888.345700] Descriptor sense data with sense descriptors (in hex):
Nov 16 12:55:11 coyote kernel: [57888.345736]         72 03 11 04 00 00 00 0c 00 0a 80 00 00 00 00 00
Nov 16 12:55:11 coyote kernel: [57888.345821]         2a ba c6 18
Nov 16 12:55:11 coyote kernel: [57888.345867] sd 0:0:0:0: [sda] ASC=0x11 ASCQ=0x4
Nov 16 12:55:11 coyote kernel: [57888.345906] end_request: I/O error, dev sda, sector 716883480
Nov 16 12:55:11 coyote kernel: [57888.345942] Buffer I/O error on device sda, logical block 89610435
Nov 16 12:55:11 coyote kernel: [57888.346110] ata1: EH complete
Nov 16 12:55:11 coyote kernel: [57888.346234] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or 
FUA
Nov 16 12:55:11 coyote kernel: [57888.365643] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Nov 16 12:55:11 coyote kernel: [57888.375653] sd 0:0:0:0: [sda] Write Protect is off
Nov 16 12:55:11 coyote kernel: [57888.386807] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or 
FUA

So I am running badblocks, and have collected a lengthy list. But the drive 
is not re-allocating them, and has not re-allocated any bad blocks according
to smartctl.

AND, the badblocks being reported are much farther into the disk than as 
reported by amanda when it fails, no correspondence at all.

But smartctl isn't showing corresponding increments in the error count
either unless it was during an amdump run.  There have been 36 of them
but the last 5 all occurred while amdump was running earlier today, and
the last 5 is all the drive apparently keeps.

The question then is:

Bad drive, (un-)known bug, or configuration?

Thanks all.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
In success there's a tendency to keep on doing what you were doing.
		-- Alan Kay
