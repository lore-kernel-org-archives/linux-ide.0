From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: ahci_imx: can read corrupted data successfully
Date: Mon, 24 Aug 2015 11:55:01 +0100
Message-ID: <20150824105501.GX7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:52491 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbbHXKz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Aug 2015 06:55:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
Cc: jon.nettleton@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

I've no idea how this is happening, but it appears that it's possible
to read corrupted data over an eSATA link.

The setup is a Solid-run Cubox-i4pro connected to an external eSATA 2.5"
enclosure with a Corsair Neutron 128GB SSD.

While the issue seems to be the generally poor quality of eSATA cables
(I have two eSATA enclosures, the other enclosure's eSATA cable
interferes with a Logitech wireless receiver - I've had to wrap the
cable in aluminium foil.)  However, it shouldn't be possible to
successfully read faulty data in that condition - and this is what I
find most worrying.

What I've noticed is that at boot, the the SSD is sometimes properly
detected, other times it isn't:

[reboot at 10am]

ata1: softreset failed (device not ready)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: Corsair Neutron SSD, M311, max UDMA/133
ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk

[half an hour passes and a reboot later]

ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: , , max UDMA/133
ata1.00: 250069680 sectors, multi 1: LBA48
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA                       n/a  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
sd 0:0:0:0: [sda] Attached SCSI disk

[replugging the eSATA connector]

ata1: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe frozen
ata1: irq_stat 0x00000040, connection status changed
ata1: SError: { RecovComm PHYRdyChg CommWake DevExch }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: Corsair Neutron SSD, M311, max UDMA/133
ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk

[another reboot]

ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: Corsair Neutron SSD, M311, max UDMA/133
ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Corsair Neutron  M311 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk

When the SSD is mis-detected, as can be seen above, the partition table
isn't recognised.  Reading sector 0 shows:

00000000  18 f0 9f e5 18 f0 9f e5  18 f0 9f e5 18 f0 9f e5  |................|
00000010  18 f0 9f e5 00 00 a0 e1  14 f0 9f e5 14 f0 9f e5  |................|
00000020  f8 09 00 00 3c 00 00 00  40 00 00 00 1c f2 00 00  |....<...@.......|
00000030  04 f2 00 00 5c 12 00 00  90 12 00 00 fe ff ff ea  |....\...........|
00000040  fe ff ff ea 00 00 00 ea  da 0d 00 ea 28 00 8f e2  |............(...|
00000050  00 0c 90 e8 00 a0 8a e0  01 70 4a e2 00 b0 8b e0  |.........pJ.....|

which is some ARM code - it looks like early boot code, code which would
normally be found in the vector page.

What should be there is the partition table:

00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001b0  00 00 00 00 00 00 00 00  bf 64 9b 0b 00 00 00 20  |.........d..... |
000001c0  21 00 83 53 09 0a 00 08  00 00 00 80 02 00 00 53  |!..S...........S|
000001d0  0a 0a 83 a8 0a 1e 00 88  02 00 00 00 00 01 00 a8  |................|
000001e0  0b 1e 83 1d 3f ce 00 88  02 01 b0 3a e5 0d 00 00  |....?......:....|
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|

The SSD has had no ARM executables copied on to it since it was
purchased.  It contains a DOS partition and swap space, so it's possible
that the swap space could have had ARM code swapped to it.  Grepping the
swap partition for the initial sequence of 8 bytes (18 f0 9f e5 18 f0 9f
e5) gives nothing.

Another possibility is we didn't actually read any data from the SSD at
all but ended up copying it from somewhere else.  As I say above, it
looks like what one would expect to find in the ARM vector page.  It
doesn't tie up with the iMX6 ROM nor the uboot image in the SD card.
It's not the kernel's vectors either.  It could be the SSD firmware (I
haven't checked, but I wouldn't be surprised if the SSD has an ARM CPU
on it) but that would point towards a very weird failure of the SSD -
though not if it's receiving corrupted commands and there was no
verification of those commands.  Without a firmware image of the SSD
(which isn't going to be possible to get hold of) it's impossible to
know.

What concerns me is that this incorrect data was successfully read
allegedly from the device.  What happens if a write were to occur -
what would we be writing to?

Also, clearly the identify information is definitely screwed, although
some of it does seem to be correct, such as the capacity, but the
device identifiers are broken.

How does SATA ensure command and data integrity over the link?  I'd
assume that there's a CRC present on the data, like UDMA on PATA.  How
are CRC errors supposed to be reported?  Is it possible that ahci_imx
and other layers are not properly checking for CRC errors?

Any ideas what to look at?

Anyone got any suggestions on where to get a good quality, but not
stupidly expensive eSATA cable from?

I'm waiting for it to happen again, and I'll dump out more of the drive's
"contents" when the cable is bad.  If it is the drive's firmware, it
should contain the manufacturer name/model somewhere in the image.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
