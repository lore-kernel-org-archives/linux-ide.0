From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10296] New: System freezes after I/O on pata_jmicron device
Date: Fri, 21 Mar 2008 02:58:57 -0700 (PDT)
Message-ID: <bug-10296-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753077AbYCUJ7a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 05:59:30 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2L9wv1t010666
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2008 02:58:58 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10296

           Summary: System freezes after I/O on pata_jmicron device
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jniklast@web.de


Latest working kernel version: 2.6.23.17
Earliest failing kernel version: 2.6.24.0
Distribution: Gentoo
Hardware Environment: JMicron 20360/20363 AHCI Controller (rev 02) on Asus P5W
DH Deluxe Mainboard (Intel 975X + ICH7R chipset)
Software Environment: gcc 4.1.2, binutils 2.18, glibc 2.6.1-r0
Problem Description:
I have pata_jmicron as a module and use a IDE-Harddisk on the JMicron
controller. Whenever I do some I/O on that harddisk the I/O waiting load goes
up within a few seconds until it is at or close to 100% which renders the
system unusable. Magic SysRq makes a graceful reboot possible sometimes.
Steps to reproduce:
1. Do some I/O on a IDE-Harddisk which uses pata_jmicron


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
