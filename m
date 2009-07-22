From: dhdurgee@verizon.net
Subject: SATA II NCQ and multi-port support for ICH7
Date: Wed, 22 Jul 2009 10:15:15 -0300
Message-ID: <0KN6003ZATOVGH70@vms173017.mailsrvcs.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:45014 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZGVObx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 10:31:53 -0400
Received: from TP600E ([68.84.129.118]) by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KN6003Z4TOUGH70@vms173017.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 22 Jul 2009 09:31:43 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

I have recently purchased an Areca ARC-5020 external eSATA II RAID to
connect to my system.  This unit supports ICH NCQ and multi-port for
multiple volumes.  I have connected it to my Intel DG41TY mainboard, which
has the Intel 82801GB I/O Controller Hub (ICH7), but I find I am only
seeing the first volume and the unit shows NCQ is inactive.

Looking at udev for the SATA-II port I see the following:

KERNEL[1247932822.419400] add      /devices/pci0000:00/0000:00:1f.2 (pci)
UDEV_LOG=3
ACTION=add
DEVPATH=/devices/pci0000:00/0000:00:1f.2
SUBSYSTEM=pci
DRIVER=ata_piix
PCI_CLASS=1018F
PCI_ID=8086:27C0
PCI_SUBSYS_ID=8086:D612
PCI_SLOT_NAME=0000:00:1f.2
MODALIAS=pci:v00008086d000027C0sv00008086sd0000D612bc01sc01i8f SEQNUM=1221

syslog shows the following:

ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19 ata_piix
0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xf0e0 ctl 0xf0d0 bmdma 0xf0a0 irq 19 ata4:
SATA max UDMA/133 cmd 0xf0c0 ctl 0xf0b0 bmdma 0xf0a8 irq 19 ata3.00:
ATA-6: Areca   ARC-5020-VOL#00, 0100 AX, max UDMA/133 ata3.00: 1052732928
sectors, multi 16: LBA48 NCQ (depth 0/32) ata3.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      Areca   ARC-5020 0100 PQ: 0 ANSI:
5 sd 2:0:0:0: [sda] 1052732928 512-byte hardware sectors: (538 GB/501 GiB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

So NCQ is detected on the RAID unit but is not enabled and only one of the
two volumes is being seen.  Am I missing something that needs to be
enabled for the driver to support the advanced features?  Is my
configuration loading the proper driver?  If not, how can I load it?

-- Dave
-----------------------------------------------------------
dhdurgee@verizon.net
-----------------------------------------------------------

