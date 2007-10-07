From: Marc MERLIN <marc@merlins.org>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330 (mostly solved)
Date: Sun, 7 Oct 2007 10:22:38 -0700
Message-ID: <20071007172238.GL2068@merlins.org>
References: <20071002170445.GB2902@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:38129 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbXJGRWl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 13:22:41 -0400
Content-Disposition: inline
In-Reply-To: <20071002170445.GB2902@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

On Tue, Oct 02, 2007 at 10:04:45AM -0700, Marc MERLIN wrote:
> Howdy,
> 
> I've had a system with 2.6.22.1 for a while, running 10 drives
> behind a PMP on a sil24 card with no problems.
> 
> Recently, I swapped 5 250GB drives with 5 TB drives.
> The 5 TB drives eventually get detected, but do not work reliably.

It took many days of moving things around and trying, and I think I finally
got to something that works.
Unfortuantely, it still boots with errors and resets, but works reliably
after that. This however means that while I was changing things, I missed 
which thing I changed and that fixed the problem (since it lookid like it
was still broken).

I had already changed all the sata cables and tried plugging the drives
directly into the PMP, but that didn't help.

I did eventually add a second SATA card, but the new drives weren't even
seen on that card, until I upgraded the bios on it (it was some early 4.x
bios, and 6.x was available). Upgrading the bios on that card allowed the
drives to be seen (I also upgraded the other card from a later 4.x to 6.x
too).
I then upgraded the bios on both PMPs (sil 3726CB). By then, when I tried
the disk array on my almost similar PMP with a 3132 (2 port PCIe) and it
booted and worked flawlessly.
Unfortunately, when I would put it back in my original system with a 3124,
I would get some boot errors, until I let it boot once anyway, and realized
that it did recover from those errors now and worked reasonably fine
afterwards (see the few exception frozen errors below:
ata4.01: exc eption Emask 0x0 SAct 0x4000000 SErr 0x0 action 0x2 frozen
ata4.01: cmd 60/20:d0:1f:27:8b/00:00:6a:00:00/40 tag 26 cdb 0x0 data 16384 in
ata4.04: exception Emask 0x0 SAct 0x80 SErr 0x0 action 0x2 frozen
ata4.04: cmd 60/08:38:b7:2d:b3/00:00:6b:00:00/40 tag 7 cdb 0x0 data 4096 in
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 60/68:00:d7:d0:ba/00:00:6b:00:00/40 tag 0 cdb 0x0 data 53248 in
ata4.01: exception Emask 0x0 SAct 0x40 SErr 0x0 action 0x2 frozen
ata4.01: cmd 60/58:30:3f:ca:f1/00:00:46:00:00/40 tag 6 cdb 0x0 data 45056 in )


Unfortunately, I don't know for sure if it's the card or the PMP bios upgrade
that improved the situation enough to fix it, but either way, it seems to
work now.

I'll attach the boot messages and random recoverable errors below:
> PM: Adding info for No Bus:usbdev2.1
> ata3: SATA link down (SStatus 0 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: softreset failed (timeout)
> ata4.01: hard resetting link
> ata4.01: COMRESET failed (errno=-5)
> ata4.01: reset failed, giving up
> ata4.15: hard resetting link
> ata4.15: softreset failed (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: softreset failed (timeout)
> ata4.02: hard resetting link
> ata4.02: COMRESET failed (errno=-5)
> ata4.02: reset failed, giving up
> ata4.15: hard resetting link
> ata4.15: softreset failed (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: softreset failed (timeout)
> ata4.03: hard resetting link
> ata4.03: COMRESET failed (errno=-5)
> ata4.03: reset failed, giving up
> ata4.15: hard resetting link
> ata4.15: softreset failed (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: softreset failed (timeout)
> ata4.04: hard resetting link
> ata4.04: COMRESET failed (errno=-5)
> ata4.04: reset failed, giving up
> ata4.15: hard resetting link
> ata4.15: softreset failed (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.05: hard resetting link
> ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/100
> ata4.01: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.01: configured for UDMA/100
> ata4.02: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.02: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.02: configured for UDMA/100
> ata4.03: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.03: configured for UDMA/100
> ata4.04: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.04: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.04: configured for UDMA/100
> ata4: EH complete
> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 25 (level, low) -> IRQ 23
(...)
> sata_sil24 0000:02:03.0: Applying completion IRQ loss on PCI-X errata fix

To be honest, those were enough boot errors for me to think that
some weird thing still prevented the disk array from working on the system it's supposed to be in (sil3124, but with everything else the same since I 
moved it over from the sil3132 system where it booted fine: same cables,
same PMP, same SATA backplane, same drives).

Turns out however that the system continued to boot, and seems to be working 
fine right now, outside of some exception frozen messages that it seems to
recover from:
>  disk 1, wo:0, o:1, dev:sdb2
> ata4.04: exception Emask 0x0 SAct 0x80 SErr 0x0 action 0x2 frozen
> ata4.04: cmd 60/08:38:b7:2d:b3/00:00:6b:00:00/40 tag 7 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.05: hard resetting link
> ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: configured for UDMA/100
> ata4.01: configured for UDMA/100
> ata4.02: configured for UDMA/100
> ata4.03: configured for UDMA/100
> ata4.04: configured for UDMA/100
> ata4: EH complete
> sd 4:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:0:0:0: [sdc] Write Protect is off
> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:1:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:1:0:0: [sdd] Write Protect is off
> sd 4:1:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 4:1:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:2:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:2:0:0: [sde] Write Protect is off
> sd 4:2:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 4:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:3:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:3:0:0: [sdf] Write Protect is off
> sd 4:3:0:0: [sdf] Mode Sense: 00 3a 00 00
> sd 4:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:4:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:4:0:0: [sdg] Write Protect is off
> sd 4:4:0:0: [sdg] Mode Sense: 00 3a 00 00
> sd 4:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:0:0:0: [sdc] Write Protect is off
> sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:1:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:1:0:0: [sdd] Write Protect is off
> sd 4:1:0:0: [sdd] Mode Sense: 00 3a 00 00
> sd 4:1:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:2:0:0: [sde] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:2:0:0: [sde] Write Protect is off
> sd 4:2:0:0: [sde] Mode Sense: 00 3a 00 00
> sd 4:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:3:0:0: [sdf] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:3:0:0: [sdf] Write Protect is off
> sd 4:3:0:0: [sdf] Mode Sense: 00 3a 00 00
> sd 4:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:4:0:0: [sdg] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 4:4:0:0: [sdg] Write Protect is off
> sd 4:4:0:0: [sdg] Mode Sense: 00 3a 00 00
> sd 4:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata4.00: cmd 60/68:00:d7:d0:ba/00:00:6b:00:00/40 tag 0 cdb 0x0 data 53248 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata4.15: hard resetting link
> ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.05: hard resetting link
> ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: configured for UDMA/100
> ata4.01: configured for UDMA/100
> ata4.02: configured for UDMA/100
> ata4.03: configured for UDMA/100
> ata4.04: configured for UDMA/100
> ata4: EH complete

This is by far the weirdest/most inconsistent hw problem I've worked on so 
far, but I hope this info can help other and the reminder that upgrading
the SATA cards and PMP firmwares can help

Oh, and just to show how this testing has been "fun", the same system
that put out the 30 lines of temp errors and retries above, boots flawlessly
the next time:
> ata3: SATA link down (SStatus 0 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.05: hard resetting link
> ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/100
> ata4.01: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.01: configured for UDMA/100
> ata4.02: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.02: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.02: configured for UDMA/100
> ata4.03: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.03: configured for UDMA/100
> ata4.04: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata4.04: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.04: configured for UDMA/100
> ata4: EH complete

It looks like problems only happen on a cold boot (power off/on).
Once it inits/recovers and boots for real, things work fine on the next boot
if I do a warm reboot.

I'd feel better if it looked a bit more reliable on cold boots, but things
seem to work, so I'll put this on some dogy firmware (I'm going to blame
the drives at this point), which just doesn't work too well on the first
cold boot.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
