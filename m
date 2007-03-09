From: Jim Paris <jim@jtan.com>
Subject: timeout errors on sata_sil24 with port multiplier & PCI-X
Date: Fri, 9 Mar 2007 17:16:28 -0500
Message-ID: <20070309221628.GA12330@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:59703 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbXCIWQb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 17:16:31 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi Tejun,

I know you're not working on PMP at the moment, but maybe you have some insight here:

I have a SiI3124 PCI-X controller, currently plugged into a PCI slot:

02:06.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller [1095:3124] (rev 01)
        Subsystem: Silicon Image, Inc. Unknown device [1095:7124]
        Flags: bus master, stepping, 66MHz, medium devsel, latency 32, IRQ 177
        Memory at fdfff000 (64-bit, non-prefetchable) [size=128]
        Memory at fdff0000 (64-bit, non-prefetchable) [size=32K]
        I/O ports at 9c00 [size=16]
        Expansion ROM at 80000000 [disabled] [size=512K]
        Capabilities: [64] Power Management version 2
        Capabilities: [40] PCI-X non-bridge device
        Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-

I have been using this configuration with a DS-1220 external enclosure + port multiplier:

Mar  9 01:09:32 localhost kernel: ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Mar  9 01:09:32 localhost kernel: ata7.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 5 ports, feat 0x9/0xb

The system is currently running linux-2.6.18.8 + libata-tj-2.6.18.1-20061020
but behaves the same with linux-2.6.17.4 + libata-tj-2.6.17.4-20060710 

Generally this configuration has been working well for a long time.
Occasionally, I get an error like this:

Mar  9 12:53:18 localhost kernel: ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
Mar  9 12:53:18 localhost kernel: ata8.00: tag 0 cmd 0x61 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  9 12:53:18 localhost kernel: ata8.15: hard resetting port
Mar  9 12:53:20 localhost kernel: ata8.15: SATA link down (SStatus 0 SControl 300)
Mar  9 12:53:20 localhost kernel: ata8.15: failed to read PMP GSCR[0] (errno=-16)
Mar  9 12:53:20 localhost kernel: ata8.15: PMP revalidation failed (errno=-16)
Mar  9 12:53:20 localhost kernel: ata8.15: retrying hardreset in 5 secs
Mar  9 12:53:25 localhost kernel: ata8.15: hard resetting port
Mar  9 12:53:28 localhost kernel: ata8.15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Mar  9 12:53:28 localhost kernel: ata8.00: hard resetting port
Mar  9 12:53:29 localhost kernel: ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  9 12:53:29 localhost kernel: ata8.01: hard resetting port
Mar  9 12:53:29 localhost kernel: ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  9 12:53:29 localhost kernel: ata8.02: hard resetting port
Mar  9 12:53:30 localhost kernel: ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  9 12:53:30 localhost kernel: ata8.03: hard resetting port
Mar  9 12:53:30 localhost kernel: ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  9 12:53:30 localhost kernel: ata8.04: hard resetting port
Mar  9 12:53:31 localhost kernel: ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar  9 12:53:31 localhost kernel: ata8.00: configured for UDMA/100
Mar  9 12:53:32 localhost kernel: ata8.01: configured for UDMA/100
Mar  9 12:53:32 localhost kernel: ata8.02: configured for UDMA/100
Mar  9 12:53:32 localhost kernel: ata8.03: configured for UDMA/100
Mar  9 12:53:32 localhost kernel: ata8.04: configured for UDMA/100
Mar  9 12:53:32 localhost kernel: ata8: EH complete

On the "old" machine, these were infrequent -- maybe once every few
hours, or every couple days.  They just caused a small delay and
everything keeps running fine.  However, I've recently upgraded the
motherboard to one with PCI-X and tried placing the card in a PCI-X
slot.  Then the errors sometimes occur so frequently as to render the
disks almost unusable:

$ grep timeout syslog.0
Mar  8 22:02:03 localhost kernel: ata7.03: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:02:47 localhost kernel: ata8.02: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:03:33 localhost kernel: ata7.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:04:48 localhost kernel: ata7.04: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:05:32 localhost kernel: ata8.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:06:16 localhost kernel: ata8.02: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:07:00 localhost kernel: ata7.03: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:08:26 localhost kernel: ata8.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:09:12 localhost kernel: ata7.03: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:11:04 localhost kernel: ata8.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:11:48 localhost kernel: ata7.03: tag 3 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:12:48 localhost kernel: ata7.04: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:13:32 localhost kernel: ata7.04: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Mar  8 22:14:19 localhost kernel: ata8.03: tag 4 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
..

As far as I can tell, there was never any data corruption, just
frequent timeouts.  It definitely seems related to load, something
like deleting large files or running fsck.ext3 would trigger it
continuously, while copying files from the array to another disk
triggered it maybe every once every 5-10 minutes.

After noticing this in the syslog:

Mar  9 01:17:28 localhost kernel: sata_sil24 0000:04:01.0: Applying completion IRQ loss on PCI-X errata fix

I decided to try putting the card into a plain PCI slot on the new
motherboard and it's much better again, back to the point where the
timeouts are infrequent enough to be not a big problem.

Any idea what the cause of these timeouts are?  

If not I think my next course of action will be to try swapping the
controller to a PCIe SiI3132, then maybe give Robin H. Johnson's
2.6.20 port of the PMP patches a try.

-jim
