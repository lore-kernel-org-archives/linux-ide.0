From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11498] New: Teac DV28EV stops working with ide-cd
Date: Thu,  4 Sep 2008 10:06:05 -0700 (PDT)
Message-ID: <bug-11498-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60691 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750822AbYIDRGI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 13:06:08 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m84H65OK008671
	for <linux-ide@vger.kernel.org>; Thu, 4 Sep 2008 10:06:06 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11498

           Summary: Teac DV28EV stops working with ide-cd
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: bhutchings@solarflare.com


Latest working kernel version: 2.6.18
Earliest failing kernel version: 2.6.26-rc2
Distribution: RHEL 5
Hardware Environment: Dell PowerEdge 6950, TEAC DVD-ROM DV28EV
Software Environment:
Problem Description:
The DVD-ROM drive starts returning status 0xd0 after the machine has been
running for some time. The drive is not being used, but HAL is installed and
appears to open the device every 5 seconds, so at least its status is being
read. This could be a hardware/firmware problem but has only been observed when
running recent kernels (2.6.26-rc2 and 2.6.27-rc5). It has also been observed
on a Dell PowerEdge 2950 with the same model of DVD-ROM drive.


Steps to reproduce:


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
