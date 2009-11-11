From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] New: SSD system stall, HSM Violation
Date: Wed, 11 Nov 2009 06:24:02 GMT
Message-ID: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47461 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbZKKGX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 01:23:56 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAB6O2rI004595
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2009 06:24:02 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583

           Summary: SSD system stall, HSM Violation
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.31
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: andrewnz.simpson@gmail.com
                CC: tj@kernel.org
        Regression: Yes


Created an attachment (id=23737)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=23737)
dmesg

Bug occurring in Ubuntu 9.10 with SSD units, mainly reported in Acer Aspire
One, EEE and Dell Mini 9.  Occurs always on boot and randomly during use.

Mainly reported by users that have physically upgraded the SSD unit to a
newer/larger unit.  Also reported by some users with original factory SSD. 

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/445852


[  112.816122] ata2: lost interrupt (Status 0x58)
[  112.820088] ata2: drained 2048 bytes to clear DRQ.
[  112.824067] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  112.824084] ata2.00: BMDMA stat 0x4
[  112.824117] ata2.00: cmd c8/00:08:87:d4:8e/00:00:00:00:00/e1 tag 0 dma 4096
in
[  112.824123]          res 58/00:08:87:d4:8e/00:00:00:00:00/e1 Emask 0x2 (HSM
violation)
[  112.824138] ata2.00: status: { DRDY DRQ }
[  112.824200] ata2: soft resetting link
[  112.992538] ata2.00: configured for UDMA/100
[  112.992581] ata2: EH complete

The bug is typified by command C8h with response 58h as above.

No reports of problem with Ubuntu 9.04 (2.6.28) on same hardware.

I have found that booting with libata.dma=0 forces mode PIO4 and the bug does
not show.  Booting with libata.force=udma/33 reduces bus speed, but bug still
occurs.

The attached files are from booting LiveCD (on a USB stick):

dmesg.txt (dmesg output)
kern.log
lspci.txt (lspci -nn)

dmesg_libata.dma-0.txt (dmesg with libata.dma=0 )
dmesg_libata.force-udma33.txt (dmesg with libata.force=udma/33)

The following file is from booting Ubuntu 9.04 on the SSD unit:

dmesg_2.6.28-kernel.txt

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
