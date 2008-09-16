From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11576] New: compactflash TRANSCEND at ide adapter failed to IDENTIFY
Date: Tue, 16 Sep 2008 06:19:44 -0700 (PDT)
Message-ID: <bug-11576-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33511 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbYIPNTq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Sep 2008 09:19:46 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8GDJix6004534
	for <linux-ide@vger.kernel.org>; Tue, 16 Sep 2008 06:19:45 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11576

           Summary: compactflash TRANSCEND at ide adapter failed to IDENTIFY
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24-19-generic 64bit (gcc version 4.2.3) #1 SMP Wed
                    Aug 20 17
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: werner.hein@gmx.net


Latest working kernel version: n/a
Earliest failing kernel version: no idea but short tests failed on Ubuntu
6.06.1 & 7.10
Distribution: Kubuntu 8.04.1 Hardy Heron
Hardware Environment: Intel D945GCLF + AtomCPU, CF TRANSCEND TS4GCF120 at
CF->IDE adapter via 80 wire cable to single pata/ide port, CF is master and
only device connected to pata/ide, SAMSUNG 750GB at sata, 2GB DDR2 ram
Software Environment: Kubuntu 8.04.1 Desktop, basic installation
Problem Description: CF fails during boot, partition table cannot be read, no
access to CF

sequence of failure:
libata
- detects at ata1.00 CF including name and size correctly
- configures IF for MWDMA2
- assignes IF to scsi
- goes on with sata
[] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x2090 irq 14
[] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x2098 irq 15
[] ata1.00: ATA-0: TRANSCEND, 20070312, max MWDMA2
[] ata1.00: 8077104 sectors, multi 0: LBA
[] ata1.00: configured for MWDMA2
[] ata1.00: configured for MWDMA2
[] ata1: EH complete
[] ata2: port disabled. ignoring.
[] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2007 PQ: 0 ANSI: 5

sd
- driver takes over and starts with CF as sda
- still starting with correct parameters
- then timeout upon a command + error messages "failed to IDENTIFY" and
"revalidation failed"
[] Driver 'sd' needs updating - please use bus_type methods
[] sd 0:0:0:0: [sda] 8077104 512-byte hardware sectors (4135 MB)
[] sd 0:0:0:0: [sda] Write Protect is off
[] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
[] sd 0:0:0:0: [sda] 8077104 512-byte hardware sectors (4135 MB)
[] sd 0:0:0:0: [sda] Write Protect is off
[] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
[]  sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[] ata1.00: status: { DRDY }
[] ata1: soft resetting link
[] ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[] ata1.00: revalidation failed (errno=-5)
[] ata1: failed to recover some devices, retrying in 5 secs
[] ata1: soft resetting link
... <repetitions> ...
- later on followed by some more error messages
[] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[] end_request: I/O error, dev sda, sector 0
[] Buffer I/O error on device sda, logical block 0
[] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[] end_request: I/O error, dev sda, sector 0
[] Buffer I/O error on device sda, logical block 0
[] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[] end_request: I/O error, dev sda, sector 0
[] Buffer I/O error on device sda, logical block 0
... <repetitions> ...

sudo hdparm -I /dev/sda

/dev/sda:
 HDIO_DRIVE_CMD(identify) failed: Input/output error

needless to say that CF has been checked in a CF card reader on same board's
usb and works perfectly there

Steps to reproduce:
- failure comes every time


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
