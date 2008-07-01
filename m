From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11015] New: Delay on boot: fails to IDENTIFY ata2.01 (I/O error, err_mask=0x1)
Date: Mon, 30 Jun 2008 17:06:52 -0700 (PDT)
Message-ID: <bug-11015-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754831AbYGAAHW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jun 2008 20:07:22 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6106qM0003018
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2008 17:06:53 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11015

           Summary: Delay on boot: fails to IDENTIFY ata2.01 (I/O error,
                    err_mask=0x1)
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25.6
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jon@kapla.se


Latest working kernel version: 2.6.24
Earliest failing kernel version: 2.6.25.4
Distribution: Arch Linux
Hardware Environment: asus a7n8x-x motherboard with nforce2 chipset

Problem Description:
The boot process is delayed (three tries, ~20 seconds) when identifying ata2
devices. The boot then continues normally. The problem occured when Arch was
switching from the 2.6.24 basekernel to 2.6.25. 

Initially reported on bugs.archlinux.org, but rejected as an upstream bug.

Relevant section of dmesg:

SCSI subsystem initialized
libata version 3.00 loaded.
pata_amd 0000:00:09.0: version 0.3.10
PCI: Setting latency timer of device 0000:00:09.0 to 64
scsi0 : pata_amd
scsi1 : pata_amd
ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
ata1.00: ATA-6: ST3120026A, 3.06, max UDMA/100
ata1.00: 234441648 sectors, multi 16: LBA48 
ata1.01: ATA-7: Maxtor 6B300R0, BAH41B10, max UDMA/133
ata1.01: 586114704 sectors, multi 16: LBA48 
ata1: nv_mode_filter: 0x3f39f&0x3f01f->0x3f01f, BIOS=0x3f000 (0xc6c7c000)
ACPI=0x3f01f (20:15:0x1f)
ata1: nv_mode_filter: 0x7f39f&0x7f01f->0x7f01f, BIOS=0x7f000 (0xc6c7c000)
ACPI=0x7f01f (20:15:0x1f)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/133
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2: failed to recover some devices, retrying in 5 secs
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[00023c002105b2d9]
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: ATAPI: SONY    CD-RW  CRX160E, 1.0e, max UDMA/33
ata2: nv_mode_filter: 0x739f&0x701f->0x701f, BIOS=0x7000 (0xc6c7c000)
ACPI=0x701f (60:600:0x13)
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3120026A       3.06 PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6B300R0   BAH4 PQ: 0 ANSI: 5
scsi 1:0:0:0: CD-ROM            SONY     CD-RW  CRX160E   1.0e PQ: 0 ANSI: 5

Steps to reproduce: reboot


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
