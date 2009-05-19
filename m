From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] New: panic when reading data from IDE CDROM with >=
 2.6.29 kernels
Date: Tue, 19 May 2009 21:29:01 GMT
Message-ID: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:38619 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZESV27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:28:59 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4JLT1ri030087
	for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 21:29:01 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345

           Summary: panic when reading data from IDE CDROM with >= 2.6.29
                    kernels
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30-rc5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: modestas@vainius.eu
        Regression: Yes


Created an attachment (id=21439)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21439)
Backtrace of the OOPS with 2.6.30-rc5

Hello,

I get kernel panic when data is read from IDE CDROM with 2.6.29 or later
kernels (testing 2.6.30-rc5 at the moment). I have never had the issue with
2.6.28 and earlier kernels.

I suspect the cause though. My CD/DVD drive is pretty old and might be a bit
faulty (or this might kernel be misinterpreting my drive sometimes). <= 2.6.28
kernels used to turn off DMA due to seek errors (if I recall correctly)
sometimes. However, I used to be able to turn DMA back on with hdparm and I
have never really had read() failures. Now with >= 2.6.29 I have never seen DMA
being turn off on my CD/DVD drive but I guess kernel just panics instead. So I
suspect there is a regression in the latest kernels which triggers
unrecoverable panic instead of drive reset.

I got the attached backtrace (sorry, I couldn't do better than this picture)
with 2.6.30-rc5 on Debian unstable amd64 box while doing a simple:

$ dd if=/dev/cdrom of=/dev/null bs=1M

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
