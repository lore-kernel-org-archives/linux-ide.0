From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12874] New: Seagate STT20000A no longer works
Date: Sun, 15 Mar 2009 01:23:45 -0700 (PDT)
Message-ID: <bug-12874-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59903 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbZCOIYy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Mar 2009 04:24:54 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2F8NjRH014598
	for <linux-ide@vger.kernel.org>; Sun, 15 Mar 2009 01:24:21 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874

           Summary: Seagate STT20000A no longer works
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.29-rc7
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: koraq@xs4all.nl


Latest working kernel version: 2.6.25
Earliest failing kernel version: 2.6.26
Distribution: Debian Lenny (tested with vanilla kernel)
Hardware Environment: i386
Problem Description: 
The Seagate STT20000A tapestreamer is no longer usable 
when modprobing the ide_tape module there's kernel BUG.

It was reported on the lkml[1][2], I tested with 2.6.29-rc7
and the problem still remains. Attached the boot dmesg and
the kernel BUG dmesg. Please let me know if more information
is needed. 

[1]http://marc.info/?l=linux-kernel&m=122203193728465&w=2
[2]http://marc.info/?l=linux-kernel&m=122202406417545&w=2


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
