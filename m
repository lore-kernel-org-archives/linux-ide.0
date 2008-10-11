From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] New: Device buffer on a DVD multi standard writer runs out burning a CD
Date: Sat, 11 Oct 2008 15:54:52 -0700 (PDT)
Message-ID: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60738 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757335AbYJKWyy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 18:54:54 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9BMsqlA011496
	for <linux-ide@vger.kernel.org>; Sat, 11 Oct 2008 15:54:53 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742

           Summary: Device buffer on a DVD multi standard writer runs out
                    burning a CD
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: valerio.p@libero.it


Latest working kernel version: 2.6.26
Earliest failing kernel version:2.6.27
Distribution: Debian Unstable
Hardware Environment: Laptop Acer 5920G with a Samsung CDDVDW TS-L632H
connected through IDE 
Software Environment: KDE 3.5.9; k3b 1.0.5; Brasero
Problem Description: I have compiled the 2.6.27 kernel using make oldconf, thus
almost copying the passed 2.6.26.5 configuration. Since then, when I burn a CD
the internal buffer in my DVD burner reaches 0% obliging k3b and brasero to
slow down the writing speed. It happens even if I don't run any other
application. I have noticed that the device buffer runs out even if the
software buffer is full, like there was not a fast transfer from the software
buffer to the device buffer. In the end, k3b reports a big amount of buffer
under-runs (> 100).Everything works as expected with an older 2.6.26.5 kernel.
What I need to do to help solving this bug? See you

Valerio

Steps to reproduce: Using 2.6.27 kernel and k3b or brasero to burn a CD. It
works in simulation mode too (so you don't waste too much CD's ;))


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
