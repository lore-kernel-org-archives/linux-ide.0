From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] New: Suspend to disk no longer works in 2.6.30.2 with an
 EIDE drive
Date: Sat, 1 Aug 2009 10:12:51 GMT
Message-ID: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49841 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZHAKMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 06:12:51 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71ACptG013053
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 10:12:51 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886

           Summary: Suspend to disk no longer works in 2.6.30.2 with an
                    EIDE drive
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30.2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: akwatts@ymail.com
        Regression: No


s2disk worked in 2.6.28 and no longer works in 2.6.30.2

(s2disk here means: echo disk > /sys/power/state).

Screen blanks and system hangs with no writes to disk. Hard restart
required afterwards.

Bisection identifies problem commit has hash 
295f00042aaf6b553b5f37348f89bab463d4a469.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
