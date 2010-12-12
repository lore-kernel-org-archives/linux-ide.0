From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 24702] New: Possible bug - crash during IDE interface probing.
Date: Sun, 12 Dec 2010 07:41:36 GMT
Message-ID: <bug-24702-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:56697 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab0LLHlh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2010 02:41:37 -0500
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id oBC7faiA030618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 12 Dec 2010 07:41:36 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=24702

           Summary: Possible bug - crash during IDE interface probing.
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.36.2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: software+linux-kernel@kd6lvw.ampr.org
        Regression: No


With 2.6.36.1, IDE probing worked.  Kernel boots.
With 2.6.36.2, IDE probing crashed kernel.

Hardware:  AMD Athlon (x86) 32-bit single-core.  SiS5513 IDE interface.  PC
Chips 810MLR motherboard (from 2002).  GCC 4.5.1.  [The machine is due for
retirement soon.  Its replacement may be ordered before 2010 ends.]

When I upgraded (using the same basic configuration file) from .1 to .2, the .2
kernel repeatedly crashed at the point where it displayed on the screen "found
SiS5513 IDE interface" and listed it's PCI/IRQ/port numbers, but before it
printed any such device (hard drive, cdrom, etc.) found on the interface cable.
 Interrupts appear disabled as a keyboard CTRL+ALT+DEL was non-functional, nor
was screen buffer lookback or keyboard LEDs for caps, num, or scroll lock.

Since the kernel initalization never finished, I have no logs.  A review of the
changelog for .2 did not yield any change to the IDE driver, but some DMA and
IRQ stuff was changed.  It's quite possible that some kernel configuration
setting combinations yield a non-working kernel.  However, I saw no differences
that explain such.

Therefore, I must ask first:  Is there a bug here?  If so, with what?
If not, then where did my configuration go wrong?  Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
