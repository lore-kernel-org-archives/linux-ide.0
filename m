From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11497] New: Polling of IDE CD status can make machine unresponsive
Date: Thu,  4 Sep 2008 09:57:18 -0700 (PDT)
Message-ID: <bug-11497-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38645 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970AbYIDQ5s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 12:57:48 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m84GvIwx008061
	for <linux-ide@vger.kernel.org>; Thu, 4 Sep 2008 09:57:19 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11497

           Summary: Polling of IDE CD status can make machine unresponsive
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


Whenever a device handled by ide-cd is opened, the driver polls the device
status for up to 5 seconds waiting for a good status value. Since this is done
in the open operation, it is holding the BKL all this time. For unknown reasons
(possibly another driver bug) the DVD-ROM drives in some machines here can get
into a state where they always return status 0xd0 and ide-cd always polls for
the full 5 seconds.

hal-storage-daemon appears to open CD-ROM devices every 5 seconds, with the
result that in this state all other operations requiring the BKL can only run
at 5 second intervals. This is possibly bad behaviour on HAL's part, but the
driver also seems to be at fault in holding the BKL for so long.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
