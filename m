From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11540] New: hda lost irq on boot
Date: Thu, 11 Sep 2008 07:25:52 -0700 (PDT)
Message-ID: <bug-11540-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44440 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbYIKOZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2008 10:25:55 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BEPqNi032417
	for <linux-ide@vger.kernel.org>; Thu, 11 Sep 2008 07:25:53 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11540

           Summary: hda lost irq on boot
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: Andreas.Matthus@tu-dresden.de


Latest working kernel version: 2.6.24.2 (last tested)
Earliest failing kernel version: 2.6.26.3 (first tested with error)
Distribution: debian etch/sid
Hardware Environment: HP LH-Pro, Dual PentiumPro 200
Software Environment: 
Problem Description: 
bootduration beliefs some hours (I press reset after 35 minutes)
boot-messages like "swapper not tainted kernel", "lost irq" and so on

Steps to reproduce:
booting with kernel 2.6.24.2 all O.K. - booting with 2.6.26.3 show always this
erros. irqpoll and noirqdebug not solve the problem.

lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
00:09.0 EISA bridge: Intel Corporation 82375EB/SB PCI to EISA Bridge (rev 15)
00:0a.0 SCSI storage controller: Adaptec AIC-7880U
00:0b.0 SCSI storage controller: Adaptec AIC-7880U
01:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
01:04.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet Pro 100
(rev 01)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
