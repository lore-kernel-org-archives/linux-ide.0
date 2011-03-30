From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 32262] New: 2.6.38-git15+  IDE hangs boot
Date: Wed, 30 Mar 2011 19:31:45 GMT
Message-ID: <bug-32262-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:39964 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1C3Tbq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2011 15:31:46 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p2UJVjM8012489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 30 Mar 2011 19:31:45 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=32262

           Summary: 2.6.38-git15+  IDE hangs boot
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.38-git15
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


Subject    : 2.6.38-git15+  IDE hangs boot
Submitter  : Pete Clements <clem@clem.clem-digital.net>
Date       : 2011-03-25 15:38
Message-ID : 201103251538.p2PFc11i001674@clem.clem-digital.net
References : http://marc.info/?l=linux-kernel&m=130106749313695&w=2

This entry is being used for tracking a regression from 2.6.38. Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
