From: "Sagar Borikar" <sagar.borikar@gmail.com>
Subject: System reboots after insertion and removal of disks in 2.6.18 kernel
Date: Sat, 29 Mar 2008 08:18:44 +0530
Message-ID: <3fb94e50803281948v3e08df7fu2135ed1c113b5431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:45190 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbYC2Csp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 22:48:45 -0400
Received: by py-out-1112.google.com with SMTP id u52so786662pyb.10
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 19:48:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello folks,
I am currently working on NAS which has sil 3114 SATA controller.There
is some strange scenario reported by product validation team.When I
insert the drive and remove immediately without settling down,
the system gets reset after roughly 30 seconds. Tried to capture the
log from drivers but couldn't get any of the stack dump or kernel
panic in due course. I am using 2.6.18 kernel and sata_sil is enabled.
Rest functionality works pretty fine. But only when I do insert and
remove without time gap, the system resets. Strange thing is when I
insert the disk and remove it back immediately the interrupt line
asserted is only for insert and not for removal.  But if I insert
another disk, then this interrupt is recognised properly. Sata
controller is not getting interrupt for second immediate drive
removal.Now based on the logs captured, I can say that in this typical
case, sata controller first gets the request to handle drive
insertion. It waits for some time to check the status to ensure that
it is proper request and after that it again reads the line. It finds
that drive is removed till that time. But actually SATA controller is
not detecting the remove instance as it is not reflected in GPIO
transition as well. So I get messages like COMRESET Failed and hard
reset failed. This doesn't happen if I insert back the drive
immediately. The system immediately recovers.
Attaching the log
After only inserting drive:
( No issues here: )
?[root@NAS00180001310e ~]# Drive 2 inserted
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth
0/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/100
ata2: EH complete
 Vendor: ATA       Model: WDC WD2500YS-01S  Rev: 20.0
 Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
 sdd:
sd 1:0:0:0: Attached scsi disk sdd
sd 1:0:0:0: Attached scsi generic sg3 type 0
After insertion and immediate removal: Reboot:

?[root@NAS00180001310e ~]# Drive 2 inserted
ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)  ---------------------> At this
state, actually the drive is removed. But not detected.
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 310)
ata2: EH complete
?
PMON2000 MIPS Initializing. Standby...
ERRORPC=bfc00004 CONFIG=0042e4bb STATUS=00400000
CPU PRID 000034c1, MaskID 00001320
Initializing caches...done (CONFIG=0042e4bb)
Switching to runtime address map...done
Setting up SDRAM controller: sdram config 0x80010000
master clock 100 Mhz, MulFundBIU 0x02, DivXSDRAM 0x02
sdram freq 0x09ef21aa hz, sdram period: 0x06 nsec
dimm0: density 256Mbit, width 16, single-sided, unbuffered, size
0x08000000
 supported CAS latency: 2.5 2, using 2.5 cycles, byte18=0x0c
 RAS to CAS delay (tRCD) 0x12 nsec, byte29=0x

Any pointers are really appreciated.
Thanks in advance,
Sagar
