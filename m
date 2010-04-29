From: Olof Johansson <olof@lixom.net>
Subject: link resets with SSD on AHCI
Date: Thu, 29 Apr 2010 16:59:35 -0500
Message-ID: <20100429215935.GA9796@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lixom.net ([66.141.50.11]:48162 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759099Ab0D3SDs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Apr 2010 14:03:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hi,

I've been investigating a puzzling error here. It seems to happen on my
netbook, the chipset/controller is "82801GR/GH (ICH7 Family) SATA AHCI
Controller (rev 02)".

The problem is: Once per boot, it will pop an error:

[  282.701448] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  282.701465] ata1.00: failed command: WRITE DMA
[  282.701492] ata1.00: cmd ca/00:00:00:ae:cc/00:00:00:00:00/e0 tag 0 dma 131072 out
[  282.701498]          res 40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
[  282.701509] ata1.00: status: { DRDY }
[  282.701527] ata1: hard resetting link
[  283.006179] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  283.007491] ata1.00: configured for UDMA/100
[  283.007506] ata1.00: device reported invalid CHS sector 0
[  283.007529] ata1: EH complete

This will happen only once. I've found reasonably reliable ways to
trigger it within a few minutes by running dbench (which does not stress
the disks hard). Errors are of the exact same format as above, just LBA
numbers and transfer sizes/directions differing.

Things I have tried without helping:

* acpi=off
* pci=nomsi
* running single cpu / no ht (makes it take much longer to happen but still does)
* making sure no laptop-mode hdparm tunings are done
* various other combinations of the above

I have seen it with different SSD vendors and products, as well as
possibly on another chipset but I can't confirm that at the moment.

It only happens exactly once, and never again.

Boot time messages are:

[    1.310632] ahci 0000:00:1f.2: version 3.0
[    1.310662] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.310750] ahci: SSS flag set, parallel bus scan disabled
[    1.310801] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x3 impl SATA mode
[    1.310810] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part 
[    1.310820] ahci 0000:00:1f.2: setting latency timer to 64
[...]
[    1.621051] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.630878] ata1.00: ATA-7: TOSHIBA THNSA16G1P4L, A090228a, max UDMA/100
[    1.630886] ata1.00: 31309824 sectors, multi 1: LBA 
[    1.631590] ata1.00: configured for UDMA/100
[    1.643227] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA THNSA16G A090 PQ: 0 ANSI: 5
[    1.643829] sd 0:0:0:0: [sda] 31309824 512-byte logical blocks: (16.0 GB/14.9 GiB)
[    1.644000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.644095] sd 0:0:0:0: [sda] Write Protect is off
[    1.644105] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.644198] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

I did notice that ALPM is enabled at boot, and doesn't seem to be
re-enabled after the error reset. Based on this, I experimented with
disabling it (just returning -EINVAL in ahci_enable_alpm). That did make
the problem not happen after a significant test run (overnight vs 4.5
minutes above).

Jeff, any known issues with this chipset? I tried doing a decent amount
of searching of similar issues, but besides the ones from running the
chipset in PIIX mode I'm not seeing anything out there.


-Olof

