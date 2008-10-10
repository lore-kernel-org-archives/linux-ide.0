From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] New: delkin_cb fails after resume
Date: Fri, 10 Oct 2008 13:48:18 -0700 (PDT)
Message-ID: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56530 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760040AbYJJUtU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 16:49:20 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9AKmmrZ003367
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 13:48:49 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735

           Summary: delkin_cb fails after resume
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc9
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: bumble.bee@xs4all.nl


Distribution:
gentoo
Hardware Environment:
x86 (Dell laptop, yenta cardbus), "02:00.0 Mass storage controller [0180]:
Workbit Corporation Device [1145:f021] (rev 01)"
Problem Description:
The delkin_cb driver works with ~3 mb/s performance, top shows the CPU in 98%
wait state with heavy I/O. If you suspend to ram or disk, the system comes up
but any further I/O to a CF card in the adapter will not complete, top shows
~100% wait state but commands to read from the card do not complete.
pata_ninja32 not tested because it performs much worse than delkin_cb (~1
mb/s).
Steps to reproduce: 
1. boot, mount a CF card through the adapter (or have root on the CF card, as I
do)
2. echo mem > /sys/power/state
3. resume from sleep
4. do I/O from the card, say "ls /mnt/card"
5. <crickets chirp> ... top shows 100% wait state


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
