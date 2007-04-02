From: Stephen Clark <Stephen.Clark@seclark.us>
Subject: CD problems booting FC7 RC3
Date: Mon, 02 Apr 2007 15:58:19 -0400
Message-ID: <4611605B.6060601@seclark.us>
Reply-To: Stephen.Clark@seclark.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpauth02.prod.mesa1.secureserver.net ([64.202.165.182]:52731
	"HELO smtpauth02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965774AbXDBT6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2007 15:58:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

When trying to boot FC7 RC3 on my HP N5430 laptop I get the following:

...
Write protecting the kernel read-only data: 845k
input: PS/2 Generic Mouse as /class/input/input2
SCSI subsystem initialized
libata version 2.20 loaded.
ACPI: Unable to derive IRQ for device 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011000 
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011008 
irq 15
scsi0 : pata_ali
PM: Adding info for No Bus:host0
ata1.00: ATA-5: HITACHI_DK23CA-20, 00H1A0A3, max UDMA/100
ata1.00: 39070080 sectors, multi 16: LBA
ata1.00: configured for UDMA/33
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: SGTC: 10000
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: SGTC: 10000
powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.
powernow-k8: Processor cpuid 670 not supported
Using IPI No-Shortcut mode
  Magic number: 3:342:541
Freeing unused kernel memory: 248k freed
Write protecting the kernel read-only data: 845k
input: PS/2 Generic Mouse as /class/input/input2
SCSI subsystem initialized
libata version 2.20 loaded.
ACPI: Unable to derive IRQ for device 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011000 
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011008 
irq 15
scsi0 : pata_ali
PM: Adding info for No Bus:host0
ata1.00: ATA-5: HITACHI_DK23CA-20, 00H1A0A3, max UDMA/100
ata1.00: 39070080 sectors, multi 16: LBA
ata1.00: configured for UDMA/33
scsi1 : pata_ali
PM: Adding info for No Bus:host1
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      HITACHI_DK23CA-2 00H1 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
PM: Adding info for No Bus:target1:0:0
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2: soft resetting port
ATA: abnormal status 0xD0 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0xD0 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2.00: limiting speed to UDMA/33:PIO3
ata2: failed to recover some devices, retrying in 5 secs
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ata2: soft resetting port
ATA: abnormal status 0xD0 on port 0x00010177
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata2.00: revalidation failed (errno=-5)
ata2.00: disabled
ata2: EH complete
PM: Removing info for No Bus:target1:0:0
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO
 or FUA
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO
 or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda

--------------------------------------
WARNING: Cannot find root file system!
--------------------------------------

Create symlink /dev/root and then exit this shell to continue
the boot sequence.

bash: no job control in this shell
bash-3.2#
(END)

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



