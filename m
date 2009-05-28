From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] New: kernel crash SONY DVD-ROM with cd
Date: Thu, 28 May 2009 16:54:38 GMT
Message-ID: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40987 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbZE1Qyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 May 2009 12:54:36 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4SGscuj001640
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2009 16:54:38 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399

           Summary: kernel crash SONY DVD-ROM with cd
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30-rc1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: bruinjm@xs4all.nl
                CC: rjw@sisk.pl
        Regression: Yes


Created an attachment (id=21602)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21602)
dump of crash at boottime

After placing a cd in the dvdplayer the kernel crashes. Both at boot as at
runtime.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
