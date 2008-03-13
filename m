From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] New: PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 12:30:42 -0700 (PDT)
Message-ID: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46610 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736AbYCMTaq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 15:30:46 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2DJVYNs030765
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 12:31:35 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239

           Summary: PLEXTOR DVDR PX-740A drive not ready for command
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-rc5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: richard.genoud@gmail.com
                CC: bzolnier@gmail.com


Latest working kernel version:2.6.23
Earliest failing kernel version:2.6.24-rc1
Distribution:N/A
Hardware Environment:
MB : ASUS A7N8X-E deluxe
DVD : PLEXTOR DVDR PX-740A (FW 1.02)
Software Environment: N/A

Problem Description:
During kernel boot, the DVD drive initialisation fails with those errors
(2.6.25-rc5):
hda: status error: error=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status error: error=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: status error: error=0xd0 { Busy }
ide: failed opcode was: unknown
hda: drive not ready for command

Steps to reproduce:
plug a plextor DVDR PX-740A as primary ide master.
boot a kernel >= 2.6.24-rc1

NB: if the plextor is on primary ide slave, there's no error.
(the jumpers are ok).

I bisect to find out where the bug was and I found that this commit is:

b140b99c413ce410197cfcd4014e757cd745226a is first bad commit
commit b140b99c413ce410197cfcd4014e757cd745226a
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Sat Oct 13 17:47:51 2007 +0200

    ide: change master/slave IDENTIFY order

    Need to probe slave device first to make it release PDIAG-
    (this is required for correct device side cable detection).

    Based on libata commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c.

    Thanks to Craig for testing this patch.

    Cc: Craig Block <chblock3@yahoo.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

:040000 040000 fa17f9e66a6e551184b1ec00049cea6fb87f7a1c
89a175312afe235fbdb04a3a593a4b981bdd9188 M      drivers


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
