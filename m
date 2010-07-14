From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16382] New: driver 'pata_hpt37x' attempts to run HPT device
 x0006 subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
Date: Wed, 14 Jul 2010 00:27:44 GMT
Message-ID: <bug-16382-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41119 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab0GNA1p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jul 2010 20:27:45 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6E0Ri6a013846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 00:27:44 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16382

           Summary: driver 'pata_hpt37x' attempts to run HPT device x0006
                    subd x0001. Doesn't work! 'pata_hpt3x2n' works well.
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.35
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rickstockton@reno-computerhelp.com
        Regression: No


Mandriva bug #60010. https://qa.mandriva.com/show_bug.cgi?id=60010

I formerly used driver 'hpt366' (NOT pata_366), completely functional. But a
totally new installation results in usage of 'pata_hpt37x', with the following
result:

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
pata_hpt37x 0000:01:0a.0: PCI INT A -> Link[LNKC] -> GSI 19 (level, low) -> IRQ
19
pata_hpt37x 0000:01:0a.0: PCI INT A disabled


The marketing name of the device is "Highpoint 133SB". Hewre is the PCI ID:
pata_hpt302     : HighPoint Technologies, Inc.|HPT302/302N [STORAGE_RAID]
(vendor:1103 device:0006 subv:1103 subd:0001) (rev: 02)

Rebuilt initrd to include pata_hpt3x2n instead (BOTH drivers claim to support
this device, so I didn't need to rebuild the hpt3x2n driver). Blacklisted
hpt37x. This driver Successful use of disk and/or DVD/RW per the following
follows: 

libata version 3.00 loaded.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 19
pata_hpt3x2n 0000:01:0a.0: PCI INT A -> Link[LNKC] -> GSI 19 (level, low) ->
IRQ 19
pata_hpt37x: bus clock 33MHz, using 66MHz DPLL.
scsi0 : pata_hpt3x2n
scsi1 : pata_hpt3x2n
ata1: PATA max UDMA/133 cmd 0xdc00 ctl 0xd880 bmdma 0xd000 irq 19
ata2: PATA max UDMA/133 cmd 0xd800 ctl 0xd480 bmdma 0xd008 irq 19
ata2.00: ATAPI: Memorex DVD+-RAM 530L v1, 5M64, max UDMA/66
ata2.00: configured for UDMA/66
scsi 1:0:0:0: CD-ROM            Memorex  DVD+-RAM 530L v1 5M64 PQ: 0 ANSI: 5

works!

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
