From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11328] kernel 2.6.26 reports massive filesystem errors on RAID5 device;  on 2.6.24 it is working but not well
Date: Thu, 14 Aug 2008 01:37:35 -0700 (PDT)
Message-ID: <20080814083735.81901108035@picon.linux-foundation.org>
References: <bug-11328-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54332 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752166AbYHNIhh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 04:37:37 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7E8bZ5m020237
	for <linux-ide@vger.kernel.org>; Thu, 14 Aug 2008 01:37:36 -0700
In-Reply-To: <bug-11328-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11328


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #4 from bzolnier@gmail.com  2008-08-14 01:37 -------
According to dmesg-2.6.24 all disks on HPT controller are using UDMA100 and
there are no error messages about dropping to PIO.

....
[   43.835503] hde: Maxtor 7L300R0, ATA DISK drive
[   43.835536] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   43.837037] hde: UDMA/100 mode selected
[   43.838590] ide2 at 0x7000-0x7007,0x6802 on irq 16
[   43.838626] Probing IDE interface ide3...
[   44.127439] hdh: Maxtor 5A300J0, ATA DISK drive
[   44.463041] hdg: Maxtor 5A300J0, ATA DISK drive
[   44.463062] hdg: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   44.463201] hdg: UDMA/100 mode selected
[   44.463340] hdh: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   44.463472] hdh: UDMA/100 mode selected
[   44.463638] ide3 at 0x6400-0x6407,0x6002 on irq 16
[   44.463692] Probing IDE interface ide0...
[   44.750830] hdb: Maxtor 5A300J0, ATA DISK drive
[   45.086698] hda: Maxtor 5A300J0, ATA DISK drive
[   45.086721] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   45.086858] hda: UDMA/100 mode selected
[   45.086997] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   45.087126] hdb: UDMA/100 mode selected
[   45.087295] ide0 at 0x8800-0x8807,0x8402 on irq 16
[   45.087351] Probing IDE interface ide1...
[   45.374370] hdd: Maxtor 5A300J0, ATA DISK drive
[   45.710125] hdc: Maxtor 5A300J0, ATA DISK drive
[   45.710147] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   45.710293] hdc: UDMA/100 mode selected
[   45.710432] hdd: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   45.710564] hdd: UDMA/100 mode selected
[   45.710728] ide1 at 0x8000-0x8007,0x7802 on irq 16
...

[ You can verify if DMA is really used by checking DMA enable setting with
  'hdparm -d /dev/device' and device speed with 'hdparm -Ttf /dev/device'. ]

HPT support in libata (SCSI emulation) is known to be experimental so I advise
to use IDE subsystem.  I'll re-assign the bug to the right people anyway.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
