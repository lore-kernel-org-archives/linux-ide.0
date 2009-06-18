From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13575] New: After S3 resume IDE reports SRST failed (errno=-16)
Date: Thu, 18 Jun 2009 18:39:29 GMT
Message-ID: <bug-13575-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54370 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbZFRSj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 14:39:26 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5IIdTKF027180
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 18:39:29 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13575

           Summary: After S3 resume IDE reports SRST failed (errno=-16)
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: warpme@o2.pl
        Regression: Yes


After resume from S3 IDE reports SRST failed (errno=-16) and HDD LED is always
ON.
Workaround is change jumper from CableSelect to Master, but in this case HDD
LED is always OFF.
All was OK with previous kernels (tested 2.6.28.10, 2.6.27.18 and 2.6.25.5)

HW is:
-MSI K9N2GM (Nvidia MCP77 IGP8200)
-LIteON DVD-RW PATA
LiteOn is single IDE device and alone mass-storage (no any HDD in system. Boot
via PXE)

br

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
