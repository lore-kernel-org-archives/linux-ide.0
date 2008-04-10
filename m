From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] New: Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 05:29:18 -0700 (PDT)
Message-ID: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48406 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753955AbYDJM3s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 08:29:48 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3ACTIeB004398
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 05:29:19 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436

           Summary: Compact Flash HD: dma and seek_error/badCRC problems
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24.3 / 2.6.24.4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: marco@absence.it


Latest working kernel version: 2.6.22 about DMA only
Earliest failing kernel version:
Distribution: Debian testing (Lenny)
Hardware Environment: Mini-ITX VIA EPIA SN Motherboard, Sandisk SDCFX4-8192
Compact Flash (hda), Maxtor PATA HD (hdb)
Problem Description:

I'm going to report two different problems but maybe related one with the
other.
I own a VIA SN board that comes with VIA VT8251 South Bridge (that includes a
VT82C5xx IDE interface). It has a single PATA connector (allowing thus max two
PATA drives) and a CF connector soldered in the back of the board (allowing
thus one CF and one PATA drive).
The SanDisk Extreme IV CF I'm using is udma4 capable and rated for 40MB/s.

The first problem:
With a 2.6.24 kernel I see in dmesg:

  hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
  hda: UDMA/33 mode selected

and the CF drive is reported to work with udma2 by hdparm:

  DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

Using dd for some testing, the max throughput "speed" reached is about 28MB/s,
accordingly with the configuration above.
However I discovered that using a 2.6.22 kernel, dmesg still reports that
message but the kernel configures my CF to use udma4 as it should. Now dd shows
a 38MB/s (about) "speed", reaching the maximum speed for this CF.
Well, I don't really know how the CF slot is connected to the South Bridge but
for sure there are really short traces, and I think I can safely say I had no
data corruption using a 2.6.22 kernel and udma4 mode.
Changing the disk BIOS settings has no influence at all.
It seems I'm not the only one suffering this problem:
http://crazyduke.blogspot.com/2007/12/cflinux.html
It's not a big issue, really, but I'd like to understand why this happens and
how to use my CF at full speed with udma4.

The second problem:
Adding a second HD (Maxtor PATA UDMA/133) results in a udma0 setting (for this
drive, while the CF behaves normally) and in lots of errors in dmesg:

  [...]
  hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
  ide: failed opcode was: unknown
  hda: DMA disabled
  hdb: UDMA/100 mode selected
  ide0: reset: success
  [...]
  hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
  hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
  ide: failed opcode was: unknown
  hdb: no DMA mode selected
  ide0: reset: success
  ldm_validate_partition_table(): Disk read failed.
  Dev hdb: unable to read RDB block 0
   unable to read partition table

Once the system was up, only /dev/hdb had been created and I had to rewrite the
partition table to the disk to see the partitions on it and correctly access
them. However when I tried to set udma6 or udma4/2 with hdparm I obtained just
a udma0 mode (infatc the system is lagging when coping files). I don't think I
had data corruption, but in this case I'm not that sure.
In the beginning I though that the CF does not want to share the ide channel
with another device. However I had no problem when I connected a (really) old
CDROM instead (using mdma2), for the system installation to the CF.
Using a 2.6.22 or a 2.6.24 kernel makes no difference.
Here it is a similar problem but without a solution:
http://readlist.com/lists/vger.kernel.org/linux-kernel/69/348695.html
Again, not a huge problem since I'm going to buy a larger SATA drive soon, but
maybe it's usefull to understand why this happens.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
