From: Linda Walsh <lkml@tlinx.org>
Subject: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Wed, 13 Aug 2008 15:27:50 -0700
Message-ID: <48A35FE6.1080903@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:57350 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbYHMWdg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 18:33:36 -0400
Received: from [192.168.3.11] (Athena [192.168.3.11])
	by ishtar.tlinx.org (8.14.1/8.12.10/SuSE Linux 0.7) with ESMTP id m7DMRp1i018611
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 15:27:51 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I can format and initialize it, but attempting to do a massive copy
from one of the PATA drives->the SATA drive, _eventually_ causes the
machine to lock up. 

I don't know if this is the cause, but with closer monitoring
I was trying (again) to move files from PATA disks to a my SATA
controller w/SATA disks a few at a time -- and caught the copy
process going into a 'blocked' state -- which eventually had about
8 processes blocked before the disk was 'disabled' by the kernel
and the processes were all released from the blocked state -- I
then was able to get the log files appended below:

The disk is a Western Digital-1TB (new disk).
The controller is a Promise SATA 300TX4 (4-port Serial 3G with
NCQ/TCQ Support).

Is this a _\lemon\_ controller or brand?  It looked like it
was supported under linux

The boot messages from the controller:
...(saw this: does it apply to the SATA driver? - came out with
first sd drive(SCSI)
Driver 'sd' needs updating - please use bus_type methods
...
sata_promise 0000:00:0d.0: version 2.11
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
scsi1 : sata_promise
scsi2 : sata_promise
scsi3 : sata_promise
scsi4 : sata_promise
ata1: SATA max UDMA/133 mmio m4096@0xfe0e4000 port 0xfe0e4380 irq 17
ata2: SATA max UDMA/133 mmio m4096@0xfe0e4000 port 0xfe0e4280 irq 17
ata3: SATA max UDMA/133 mmio m4096@0xfe0e4000 port 0xfe0e4200 irq 17
ata4: SATA max UDMA/133 mmio m4096@0xfe0e4000 port 0xfe0e4300 irq 17
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD1001FALS-00J7B0, 05.00K05, max UDMA/133
ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 05.0 PQ: 0 ANSI: 5
sd 4:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 4:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000205 MB)
sd 4:0:0:0: [sdb] Write Protect is off
sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sdb: sdb1
sd 4:0:0:0: [sdb] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg1 type 0
-------------------------------------------------------------------
warning and error logs follow ---
    (trimmed some of the prefix material
     (month, host, kernel->kern...))---------------------

13 10:12:20 kern: res ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x12 
(ATA bus error)
13 10:12:20 kern: ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x19 0002 
action 0xa frozen
13 10:12:20 kern: ata4.00: hotplug_status 0x4
13 10:12:20 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar }
13 10:12:20 kern: ata4.00: cmd 35/00:00:bf:3c:af/00:04:2b:00:00/e0 tag 0 
dma 524288 out
13 10:12:20 kern: ata4.00: status: { Busy }
13 10:12:20 kern: ata4.00: error: { ICRC UNC IDNF ABRT }
13 10:12:26 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:13:25 last message repeated 2 times
13 10:13:30 kern: ata4: COMRESET failed (errno=-16)
13 10:12:30 kern: ata4: device not ready (errno=-16), forcing hard reset
13 10:13:30 kern: ata4: reset failed, giving up
13 10:13:30 kern: ata4: exception Emask 0x10 SAct 0x0 SErr 0x41900 02 
action 0xa frozen t4
13 10:13:30 kern: ata4: hotplug_status 0x40
13 10:13:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar DevExch }
13 10:12:37 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:12:40 kern: ata4: COMRESET failed (errno=-16)
13 10:12:57 last message repeated 2 times
13 10:13:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
13 10:13:30 kern: ata4.00: disabled
13 10:13:37 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:13:57 last message repeated 2 times
13 10:14:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
13 10:14:30 kern: ata4: COMRESET failed (errno=-16)
13 10:14:30 kern: ata4: reset failed, giving up
13 10:14:30 kern: ata4: exception Emask 0x10 SAct 0x0 SErr 0x41900 02 
action 0xa frozen t3
13 10:14:30 kern: ata4: hotplug_status 0x40
13 10:14:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar DevExch }
13 10:14:37 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:14:40 kern: ata4: COMRESET failed (errno=-16)
13 10:14:57 last message repeated 2 times
13 10:15:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
13 10:15:25 last message repeated 2 times
13 10:15:30 kern: ata4: COMRESET failed (errno=-16)
13 10:15:30 kern: ata4: reset failed, giving up
13 10:15:30 kern: ata4: exception Emask 0x10 SAct 0x0 SErr 0x4190002 
action 0xa frozen t2
13 10:15:30 kern: ata4: hotplug_status 0x40
13 10:15:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar 
DevExch }
13 10:15:37 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:15:40 kern: ata4: COMRESET failed (errno=-16)
13 10:15:50 kern: ata4: COMRESET failed (errno=-16)
13 10:16:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
13 10:16:30 last message repeated 2 times
13 10:16:30 kern: ata4: reset failed, giving up
13 10:16:30 kern: ata4: exception Emask 0x10 SAct 0x0 SErr 0x41900
02 action 0xa frozen t1
13 10:16:30 kern: ata4: hotplug_status 0x40
13 10:16:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar
 DevExch }
13 10:16:37 kern: ata4: port is slow to respond, please be patient 
(Status 0xff)
13 10:16:40 kern: ata4: COMRESET failed (errno=-16)
13 10:16:50 kern: ata4: COMRESET failed (errno=-16)
13 10:16:57 last message repeated 2 times
13 10:17:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
13 10:17:30 kern: Descriptor sense data with sense descriptors (in hex):
13 10:17:30 kern: end_request: I/O error, dev sdb, sector 732904639
13 10:17:30 kern: end_request: I/O error, dev sdb, sector 732905663
13 10:17:30 kern: lost page write due to I/O error on sdb1
13 10:17:30 last message repeated 2 times
13 10:17:30 kern: ata4: reset failed, giving up
13 10:17:30 kern: ata4: EH pending after 5 tries, giving up
13 10:17:30 kern: sd 4:0:0:0: rejecting I/O to offline device
13 10:17:30 last message repeated 152 times
13 10:17:30 kern: Buffer I/O error on device sdb1, logical block 91613461
13 10:17:30 kern: Buffer I/O error on device sdb1, logical block 91613462
13 10:17:30 kern: Buffer I/O error on device sdb1, logical block 91613463
13 10:17:30 kern: Buffer I/O error on device sdb1, logical block 91613464
13 10:17:31 last message repeated 9 times
13 10:17:31 kern: sd 4:0:0:0: [sdb] START_STOP FAILED
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613465
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613466
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613467
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613468
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613469
13 10:17:31 kern: Buffer I/O error on device sdb1, logical block 91613470
13 12:35:13 kern: printk: 17932 messages suppressed.

----
please 'CC' me, as my subscription to linux-ide has "lapsed" again
    (kernel.org seems to drop subscriptions randomly...; no I don't
    think is bounced email...too specific to k.o)


