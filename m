From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33402] New: [regression] 2.6.39-rc[1-3] fail to boot on G5
 PowerMac
Date: Sun, 17 Apr 2011 17:01:40 GMT
Message-ID: <bug-33402-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter2.kernel.org ([140.211.167.42]:41131 "EHLO
	demeter2.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab1DQRBk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2011 13:01:40 -0400
Received: from demeter2.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter2.kernel.org (8.14.4/8.14.3) with ESMTP id p3HH1eek011415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 17 Apr 2011 17:01:40 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33402

           Summary: [regression] 2.6.39-rc[1-3] fail to boot on G5
                    PowerMac
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.39-rc1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: maciej.rutecki@gmail.com
                CC: mikpe@it.uu.se, rjw@sisk.pl, maciej.rutecki@gmail.com
        Regression: Yes


Subject    : [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Date       : 2011-04-12 17:30
Message-ID : 19876.35918.322649.256455@pilspetsen.it.uu.se
References : http://marc.info/?l=linuxppc-embedded&m=130263128523237&w=2

This entry is being used for tracking a regression from 2.6.38. Please don't
close it until the problem is fixed in the mainline.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
