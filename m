From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33342] New: [2.6.39-rc2][bisected] Constant
 DISK_MEDIA_CHANGE_EVENTS from CDROM drive.
Date: Fri, 15 Apr 2011 17:13:04 GMT
Message-ID: <bug-33342-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:59136 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab1DORNG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Apr 2011 13:13:06 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3FHD4Gn009172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 15 Apr 2011 17:13:04 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33342

           Summary: [2.6.39-rc2][bisected] Constant
                    DISK_MEDIA_CHANGE_EVENTS from CDROM drive.
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.39-rc2
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


Subject    : [2.6.39-rc2][bisected] Constant DISK_MEDIA_CHANGE_EVENTS from
CDROM drive.
Submitter  : Shaun Ruffell <sruffell@digium.com>
Date       : 2011-04-08 20:15
Message-ID : 20110408201513.GA3040@digium.com
References : http://marc.info/?l=linux-kernel&m=130229371907209&w=2

This entry is being used for tracking a regression from 2.6.38. Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
