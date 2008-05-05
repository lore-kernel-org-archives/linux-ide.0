From: Johan van den Berg <johanvdb@teqcle.co.za>
Subject: Initio 162x SATA controllers
Date: Mon, 5 May 2008 17:57:38 +0200
Message-ID: <B0DB428E-D75D-4E79-A749-B6E89C19E8E5@teqcle.co.za>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ctb-mesg-2-1.saix.net ([196.25.240.86]:43390 "EHLO
	ctb-mesg-2-1.saix.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbYEEQyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 12:54:19 -0400
Received: from [192.168.1.154] (dsl-242-61-169.telkomadsl.co.za [41.242.61.169])
	by ctb-mesg-2-1.saix.net (Postfix) with ESMTP id 90BB1B997
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2008 18:54:17 +0200 (SAST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have run into the same issue as reported before and as is well known  
and discussed on this list:

ata14.00: ERROR: This driver doesn't support LBA48 yet and may cause
                data corruption on such devices.  Disabling.

Commenting out the LBA48 check and actually testing the driver did  
confirm that the driver causes problems:

sata_inic162x 0000:02:01.0: version 0.2
PCI: Enabling device 0000:02:01.0 (0110 -> 0113)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 22 (level, low) -> IRQ 201
scsi14 : sata_inic162x
scsi15 : sata_inic162x
ata15: SATA max UDMA/133 cmd 0x0001b800 ctl 0x0001b402 bmdma  
0x00000000 irq 201
ata16: SATA max UDMA/133 cmd 0x0001b000 ctl 0x0001a802 bmdma  
0x00000000 irq 201
ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata15.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata15.00: ATA-8: ST3750330AS, SD15, max UDMA/133
ata15.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata15.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata15.00: configured for UDMA/133
ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata16.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata16.00: ATA-8: ST3750330AS, SD15, max UDMA/133
ata16.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata16.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata16.00: configured for UDMA/133
  Vendor: ATA       Model: ST3750330AS       Rev: SD15
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: sdb1
sd 14:0:0:0: Attached scsi disk sdb

An mke2fs runs up to 1204 inodes and then starts spitting out the  
following on console:

ata15.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata15.00: cmd 35/00:00:cf:01:00/00:01:10:00:00/e0 tag 0 cdb 0x0 data  
131072 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata15: hard resetting port
ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata15.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata15.00: Host Protected Area detected:
	current size: 1465149168 sectors
	native size: -279681296 sectors
ata15.00: configured for UDMA/133
ata15: EH complete

I have read up as much as possible to start looking into hacking the  
driver to support LBA48. Any pointers / suggestions before I start  
bumping my head?

I am an experienced linux programmer with a lot of unpolished skills  
in kernel development.

I really need to get my drives working...

lspci -v produces the following:

02:01.0 SATA controller: Initio Corporation INI-1623 PCI SATA-II  
Controller (rev 02) (prog-if 00 [Vendor specific])
	Subsystem: Initio Corporation INI-1623 PCI SATA-II Controller
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 201
	I/O ports at b800 [size=256]
	I/O ports at b400 [size=256]
	I/O ports at b000 [size=256]
	I/O ports at a800 [size=256]
	I/O ports at a400 [size=256]
	Memory at ff941000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 50000000 [disabled] [size=256K]
	Capabilities: [dc] Power Management version 2

Johan van den Berg
Managing Director
Teqcle Information Technologies (Pty.) Ltd.

Email: johanvdb@teqcle.co.za
Cel: 0732013520




