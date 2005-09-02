From: Bernhard Kuemel <bernhard@bksys.at>
Subject: sata_promise suitable for PDC20376?
Date: Fri, 02 Sep 2005 12:51:18 +0200
Message-ID: <43182EA6.10107@bksys.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rainbow.bksys.at ([212.41.248.75]:61842 "EHLO bksys.at")
	by vger.kernel.org with ESMTP id S1030409AbVIBKvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2005 06:51:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hi Jeff, linux-ide!

Is sata_promise (v 1.02 in linux 2.6.13) suitable to drive a 
PDC20376 controller on an Asus P4PE board?

There's so much irritating info on the web but I risked buying a 
Seagate 250 GB SATA because cause the controller seemed to be 
detected fine. The HD is working fine so far, but I only 'dd'ed 500 
MB to /dev/null (which 66-33 MB/s) and installed lilo on the MBR.

It seems I can only boot from the SATA disk if it is configured as 
RAID in the Fasttrak boot menu. Could this mean any trouble? This is 
a linux only server and I just mean to use the disk normally i.e. 
not as a RAID. Will the RAID setting do something to the data (slow 
it down, access the disk in the configured 64k blocks) or, as I 
read, will linux (sata_promise) just ignore the configured RAID 
settings and bypass any RAID stuff?

Would someone please list the controllers supported by sata_promise 
in the linux menuconfig (if that's appropriate) so ppl can use it 
with more confidence and not waste hours or days to research this. 
Right now it only says: "This option enables support for Promise 
Serial ATA TX2/TX4." Do I have a TX2/TX4?

It seems sata_promise limits transfer rate to 133 MB/s. The 
mainboard manual says:

"Serial ATA connectors (7-pin PRI_SATA1, SEC_SATA1): These next 
generation connectors support the thin Serial ATA cables for primary 
internal storage devices. The current Serial ATA interface allows up 
to 150 MB/s data transfer rate, faster than the standard parallel 
ATA with 133 MB/s (Ultra ATA/133)."


Thank you
Bernhard


dmesg:

libata version 1.12 loaded.
sata_promise version 1.02
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 23 (level, low) -> IRQ 16
ata1: SATA max UDMA/133 cmd 0xD0802200 ctl 0xD0802238 bmdma 0x0 irq 16
ata2: SATA max UDMA/133 cmd 0xD0802280 ctl 0xD08022B8 bmdma 0x0 irq 16
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 
87:4023 88:207f
ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
  sda:
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

lspci -v:

0000:02:04.0 RAID bus controller: Promise Technology, Inc. PDC20376 
(FastTrak 376) (rev 02)
         Subsystem: Asustek Computer, Inc. A7V8X motherboard
         Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 16
         I/O ports at b800 [size=64]
         I/O ports at b400 [size=16]
         I/O ports at b000 [size=128]
         Memory at f5800000 (32-bit, non-prefetchable) [size=4K]
         Memory at f5000000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2

