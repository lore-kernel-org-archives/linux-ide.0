From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33412] New: 2.6.39-rc3 udevadm settle timeout, many hdb events,
 interrupt storm
Date: Sun, 17 Apr 2011 17:12:05 GMT
Message-ID: <bug-33412-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:44246 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1DQRMH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2011 13:12:07 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3HHC5bb030728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 17 Apr 2011 17:12:06 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33412

           Summary: 2.6.39-rc3 udevadm settle timeout, many hdb events,
                    interrupt storm
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.39-rc3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: maciej.rutecki@gmail.com
                CC: rjw@sisk.pl, maciej.rutecki@gmail.com
        Regression: Yes


Subject    : 2.6.39-rc3 udevadm settle timeout, many hdb events, interrupt
storm
Submitter  : Tim Shepard <shep@alum.mit.edu>
Date       : 2011-04-12 19:14
Message-ID : E1Q9j2p-0008Rr-00@www.xplot.org
References : http://marc.info/?l=linux-kernel&m=130263709430814&w=2

This entry is being used for tracking a regression from 2.6.38. Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
