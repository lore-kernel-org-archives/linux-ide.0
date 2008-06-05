From: Nick Piggin <npiggin@suse.de>
Subject: patch "libata-sff: Fix oops for pnp devices with no ctl" causes regression
Date: Thu, 5 Jun 2008 07:09:23 +0200
Message-ID: <20080605050923.GD11811@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35694 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbYFEFJY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2008 01:09:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, jgarzik@redhat.com, linux-ide@vger.kernel.org

Hi,

I bisected a sata regression to commit a57c1bade5a0ee5cd8b74502db9cbebb7f5780b2

The details are as follows:

System is a powerpc (g5)

CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_SATA_PMP is not set
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y
CONFIG_SATA_SVW=y

lspci:
0000:00:0b.0 PCI bridge: Apple Computer Inc. Device 005b
0000:0a:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)
0001:00:00.0 Host bridge: Apple Computer Inc. U4 HT Bridge
0001:00:01.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)
0001:00:02.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-X bridge (rev a3)
0001:00:03.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev a3)
0001:00:04.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev a3)
0001:00:05.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev a3)
0001:00:06.0 PCI bridge: Broadcom BCM5780 [HT2000] PCI-Express Bridge (rev a3)
0001:00:07.0 PCI bridge: Apple Computer Inc. Shasta PCI Bridge
0001:00:08.0 PCI bridge: Apple Computer Inc. Shasta PCI Bridge
0001:00:09.0 PCI bridge: Apple Computer Inc. Shasta PCI Bridge
0001:01:07.0 Class ff00: Apple Computer Inc. Shasta Mac I/O
0001:01:0b.0 USB Controller: NEC Corporation USB (rev 43)
0001:01:0b.1 USB Controller: NEC Corporation USB (rev 43)
0001:01:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
0001:03:0c.0 IDE interface: Broadcom K2 SATA
0001:03:0d.0 Class ff00: Apple Computer Inc. Shasta IDE
0001:03:0e.0 FireWire (IEEE 1394): Apple Computer Inc. Shasta Firewire
0001:05:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 03)
0001:05:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5780 Gigabit Ethernet (rev 03)

dmesg (from the kernel previous to the commit in question):
sata_svw 0001:03:0c.0: version 2.3
scsi0 : sata_svw
scsi1 : sata_svw
scsi2 : sata_svw
scsi3 : sata_svw
ata1: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402000 irq 18
ata2: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402100 irq 18
ata3: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402200 irq 18
ata4: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402300 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
ata1.00: 490234752 sectors, multi 0: LBA48
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: Maxtor 7Y250M0, YAR51HW0, max UDMA/133
ata2.00: 490234752 sectors, multi 0: LBA48
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: [mac] sda1 sda2

And when booting with the commit applied, I instead get a whole lot of
messages like this (this is the first one, copied by hand):

ata2.00: exception Emask 0x0 SAct 0x0 Serr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:08:20/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete


Thanks,
Nick
