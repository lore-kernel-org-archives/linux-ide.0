From: Sebastian Kuzminsky <seb@highlab.com>
Subject: SATA regression 2.6.16.24 -> 2.6.17.4
Date: Mon, 10 Jul 2006 00:51:06 -0600
Message-ID: <E1Fzpbm-0002ce-Ij@highlab.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:13967 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1161351AbWGJGvI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Jul 2006 02:51:08 -0400
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.62)
	(envelope-from <seb@highlab.com>)
	id 1Fzpbm-0002ce-Ij
	for linux-ide@vger.kernel.org; Mon, 10 Jul 2006 00:51:06 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm experiencing a problem that looks very similar to bug 5863
(http://bugzilla.kernel.org/show_bug.cgi?id=5863) - disks that are
detected with some kernels (and with the BIOS), but not detected with
other kernels.

 I've got an Intel D915GEV motherboard with an ICH6 SATA controller.
It works fine with 2.6.15.1, 2.6.16.{1,16,20,24}, but it doesnt work
with 2.6.17.4.

With .17.4 the first two disks (on ata12) show up and work, but the last
two disks (on ata2) are not detected:

libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD800 irq 193
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD808 irq 193
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:207f
ata1: dev 1 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 0:0:1:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0


I actually had this same problem happen once with .16.16 (it didnt detect
the ata2 disks, "SATA port has no device").  And I dont really have a
statistically significant sample here - this is a server and it pretty
much stays up until it gets a hardware or software upgrade.

I'd appreciate any advice on debugging this or patches to try.  :-)


lspci:

    00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express Memory Controller Hub (rev 04)
    00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Express PCI Express Root Port (rev 04)
    00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL Express Chipset Family Graphics Controller (rev 04)
    00:02.1 Display controller: Intel Corporation 82915G Express Chipset Family Graphics Controller (rev 04)
    00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
    00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
    00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
    00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03)
    00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 03)
    00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
    00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
    00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
    00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
    00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
    00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
    00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
    00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
    00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)
    00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
    04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8050 PCI-E ASF Gigabit Ethernet Controller (rev 17)
    06:00.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
    06:02.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 04)
    06:03.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)


-- 
Sebastian Kuzminsky        If it isn't running programs and it isn't fusing
                           atoms, it's just bending space.   -- Ken MacLeod
