From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11328] New: kernel 2.6.26 reports massive filesystem errors on RAID5 device;  on 2.6.24 it is working but not well
Date: Thu, 14 Aug 2008 01:02:50 -0700 (PDT)
Message-ID: <bug-11328-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52000 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042AbYHNIDU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 04:03:20 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7E82oPv017459
	for <linux-ide@vger.kernel.org>; Thu, 14 Aug 2008 01:02:51 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11328

           Summary: kernel 2.6.26 reports massive filesystem errors on RAID5
                    device;  on 2.6.24 it is working but not well
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24 / 2.6.26
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: fpbeekhof@gmail.com


I'm running Ubuntu Hardy on a AMD64 machine with a RAID5 array in it, ext3
formatted. It has been working fine for years, with the exception of
Gutsy's kernel that couldn't handle that many IDE devices (bug 157909,
fixed in hardy).

To make backups, I bought an external drive and an eSata controller. The
controller is not supported in Hardy's kernel (2.6.24), but it is in
Intrepid, so I installed linux-image-2.6.26-5-generic from intrepid.

Running this kernel causes several changes:
1) My new controller is recognized
2) All disks are now known as /dev/sd* and not /dev/hd*
3) Copying from /dev/md0 results in many filesystem errors
4) e2fsck reports massive errors on the filesystem on /dev/md0

If I reboot into 2.6.24, all problems are gone and everything is back to
normal. This implies that there is a major problem somewhere! I happen
to mount the device read-only, but mounting it rw will no doubt result
in severe damage to the fs. I accidentally tested this by running e2fsck
under 2.6.26, which did introduce real errors that I then had to fix
under 2.6.24. Now, under 2.6.24, all is fine and 2.6.26 still reports
many errors.

Since then, Tejun Heo pointed out that under 2.6.24 were not that good either,
all disks on my HPT controller were working in PIO4 (but at least, without
error), and advised opening a bug report.

See attachments for details.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
